#!/usr/bin/env python3

import csv
import math
import os
import signal
import subprocess
import threading
import time

import actionlib
import rospy
from control_msgs.msg import FollowJointTrajectoryAction, FollowJointTrajectoryGoal
from geometry_msgs.msg import PoseStamped
from moveit_msgs.srv import GetPositionIK, GetPositionIKRequest
from sensor_msgs.msg import JointState
from std_msgs.msg import String
from trajectory_msgs.msg import JointTrajectoryPoint

RECORDINGS_DIR = os.path.expanduser("~/ROS_Files/sagittarius_ws/recordings")
CAPTURE_DIR = os.path.join(RECORDINGS_DIR, "playbacks")
NUM_SLOTS = 5
JOINT_NAMES = ['joint1', 'joint2', 'joint3', 'joint4', 'joint5', 'joint6']
PLAYBACK_RATE_HZ = 10
PLAYBACK_JS_TOPIC = "/sgr532/playback/joint_states"
PLAYBACK_EE_TOPIC = "/sgr532/playback/ee_pose"
# Peeks use their own topics so peeked messages never reach the persistent
# playback subscribers. For joint_states this is load-bearing, not hygiene:
# _control_callback holds _state_lock during the peek, _playback_js_callback
# needs that lock, and rospy dispatches a topic's callbacks sequentially — so
# a peek waiting on PLAYBACK_JS_TOPIC would be starved by its own sibling
# callback and always time out.
PEEK_EE_TOPIC = "/sgr532/playback/ee_peek"
PEEK_JS_TOPIC = "/sgr532/playback/js_peek"
# Dead-end topics: recorded topics a given playback mode must not deliver to
# their live consumers get remapped here (nothing subscribes to these).
VOID_JS_TOPIC = "/sgr532/playback/void_js"
VOID_POSE_TOPIC = "/sgr532/playback/void_pose"
VOID_GRIP_TOPIC = "/sgr532/playback/void_grip"
IK_GROUP = "sagittarius_arm"
# Deadband thresholds identical to light_ik_solver.py so EE playback re-solves
# exactly the poses live teleop would have acted on.
EE_POS_THRESHOLD = 0.003
EE_ROT_THRESHOLD = 0.02
# Fixed leading-row counts to drop from each mode's capture CSV after the
# fact — empirically how many samples of pre-positioning settling motion
# show up before the arm is actually still at the bag's start pose.
CAPTURE_TRIM_ROWS = {"joints": 8, "ee": 5}


class ArmBagRecorder:
    def __init__(self):
        rospy.init_node("arm_bag_recorder", anonymous=False)

        os.makedirs(RECORDINGS_DIR, exist_ok=True)
        os.makedirs(CAPTURE_DIR, exist_ok=True)

        self._state = "IDLE"
        self._active_slot = None
        self._proc = None
        self._state_lock = threading.Lock()
        self._latest_real_js = None
        self._last_ee_pose = None
        self._capture_file = None
        self._capture_writer = None
        self._capture_start = None
        self._capture_path = None
        self._capture_mode = None

        self._playback_mode = rospy.get_param("~playback_mode", "joints")
        if self._playback_mode not in ("joints", "ee"):
            rospy.logwarn(
                f"[BagRecorder] Unknown playback_mode '{self._playback_mode}'; falling back to 'joints'."
            )
            self._playback_mode = "joints"
        rospy.loginfo(f"[BagRecorder] Playback mode: {self._playback_mode}")

        # Proxy only — connectionless until called. Do NOT wait_for_service here:
        # the MUX must come up before move_group may be ready (it is the sole
        # /sgr532/ik_goal_cmd subscriber light_ik_solver blocks on). Availability
        # is checked lazily inside _cmd_play when mode is "ee".
        self._ik_service = rospy.ServiceProxy("/sgr532/compute_ik", GetPositionIK)

        self._arm_client = actionlib.SimpleActionClient(
            "/sgr532/sagittarius_arm_controller/follow_joint_trajectory",
            FollowJointTrajectoryAction,
        )
        rospy.loginfo("[BagRecorder] Waiting for arm action server...")
        self._arm_client.wait_for_server()
        rospy.loginfo("[BagRecorder] Arm action server connected.")

        self._status_pub = rospy.Publisher(
            "/sgr532/bag_status", String, queue_size=1, latch=True
        )

        rospy.Subscriber("/sgr532/bag_control", String, self._control_callback)
        rospy.Subscriber("/sgr532/ik_goal_cmd", FollowJointTrajectoryGoal, self._ik_goal_callback)
        rospy.Subscriber(PLAYBACK_JS_TOPIC, JointState, self._playback_js_callback)
        rospy.Subscriber(PLAYBACK_EE_TOPIC, PoseStamped, self._playback_ee_callback)
        rospy.Subscriber("/sgr532/joint_states", JointState, self._real_js_callback)

        rospy.Timer(rospy.Duration(1.0 / PLAYBACK_RATE_HZ), self._playback_timer_cb)

        rospy.on_shutdown(self._shutdown_handler)

        self._publish_status()
        rospy.loginfo("[BagRecorder] Ready. State: IDLE")

    # ── helpers ──────────────────────────────────────────────────────────────

    def _slot_path(self, n):
        return os.path.join(RECORDINGS_DIR, f"slot_{n}.bag")

    def _slot_prefix(self, n):
        return os.path.join(RECORDINGS_DIR, f"slot_{n}")

    def _publish_status(self):
        if self._state == "IDLE":
            msg = "IDLE"
        elif self._state == "RECORDING":
            msg = f"RECORDING:{self._active_slot}"
        elif self._state == "PLAYING_EE":
            msg = f"PLAYING_EE:{self._active_slot}"
        else:
            msg = f"PLAYING:{self._active_slot}"
        self._status_pub.publish(String(data=msg))

    def _is_playing(self):
        return self._state in ("PLAYING", "PLAYING_EE")

    def _parse_slot(self, token):
        try:
            n = int(token)
            if 1 <= n <= NUM_SLOTS:
                return n
            rospy.logwarn(f"[BagRecorder] Slot {n} out of range 1–{NUM_SLOTS}")
        except ValueError:
            rospy.logwarn(f"[BagRecorder] Invalid slot token: '{token}'")
        return None

    def _stop_subprocess(self):
        # SIGINT, never SIGTERM: rosbag record only writes its index and renames
        # .bag.active → .bag on a clean SIGINT. A SIGTERM leaves the recording
        # unfinalized and invisible to playback.
        if self._proc and self._proc.poll() is None:
            self._proc.send_signal(signal.SIGINT)
            try:
                self._proc.wait(timeout=10.0)
            except subprocess.TimeoutExpired:
                rospy.logwarn(
                    "[BagRecorder] rosbag ignored SIGINT for 10 s; killing "
                    "(a recording may be left as .bag.active — rosbag reindex can recover it)."
                )
                self._proc.kill()
        self._proc = None

    def _shutdown_handler(self):
        # Finalize any child rosbag before this node dies — otherwise Ctrl+C on
        # roslaunch mid-record orphans the recorder (bag stuck as .bag.active)
        # and an orphaned rosbag play keeps driving the arm.
        self._stop_subprocess()
        self._stop_capture()

    def _start_capture(self, slot, mode):
        # Real hardware encoder feedback only — replayed joint_states are
        # always remapped off /sgr532/joint_states during playback (both
        # modes), so whatever _real_js_callback sees here is purely what the
        # arm actually did. Every sample is written as it arrives (no runtime
        # skipping) — the leading pre-positioning rows are trimmed once, after
        # the fact, in _stop_capture -> _trim_capture.
        ts = time.strftime("%Y%m%d-%H%M%S")
        path = os.path.join(CAPTURE_DIR, f"slot_{slot}_{mode}_{ts}.csv")
        self._capture_file = open(path, "w", newline="")
        self._capture_writer = csv.writer(self._capture_file)
        self._capture_writer.writerow(["time"] + JOINT_NAMES)
        self._capture_start = rospy.Time.now()
        self._capture_path = path
        self._capture_mode = mode
        rospy.loginfo(f"[BagRecorder] Capturing joint angles to {path}")

    def _stop_capture(self):
        if self._capture_file is not None:
            self._capture_file.close()
            self._trim_capture(self._capture_path, self._capture_mode)
        self._capture_file = None
        self._capture_writer = None
        self._capture_start = None
        self._capture_path = None
        self._capture_mode = None

    def _trim_capture(self, path, mode):
        # Drop the fixed number of leading rows still showing pre-position
        # settling motion, then re-zero the remaining rows' time column so
        # the file starts at ~0 with no blank/offset lead-in — never leaves
        # the dropped rows' timestamps as gaps, just shifts everything down.
        trim_n = CAPTURE_TRIM_ROWS.get(mode, 0)
        if trim_n <= 0:
            return
        with open(path, newline="") as f:
            rows = list(csv.reader(f))
        header, data = rows[0], rows[1:]
        if len(data) <= trim_n:
            rospy.logwarn(
                f"[BagRecorder] Capture {path} has only {len(data)} row(s); "
                f"skipping trim of leading {trim_n}."
            )
            return
        kept = data[trim_n:]
        t0 = float(kept[0][0])
        for row in kept:
            row[0] = f"{float(row[0]) - t0:.6f}"
        with open(path, "w", newline="") as f:
            writer = csv.writer(f)
            writer.writerow(header)
            writer.writerows(kept)

    def _playable_path(self, n):
        """Slot's finalized .bag, or a crash-orphaned .bag.active as fallback."""
        path = self._slot_path(n)
        if os.path.isfile(path) and os.path.getsize(path) > 0:
            return path
        active = path + ".active"
        if os.path.isfile(active) and os.path.getsize(active) > 0:
            return active
        return None

    def _peek_initial_positions(self, bag_path):
        # rosbag play -r 0 still publishes the first frame (t=0) but never
        # advances bag time, so it effectively latches just that one message.
        # Every other recorded topic is voided so nothing leaks to a live
        # consumer during the peek: a t=0 vr_target_pose would otherwise reach
        # light_ik_solver (one stray IK goal while we're still IDLE), and a t=0
        # gripper command would twitch the gripper hardware.
        proc = subprocess.Popen(
            ["rosbag", "play", "-r", "0", bag_path,
             f"/sgr532/joint_states:={PEEK_JS_TOPIC}",
             f"/sgr532/vr_target_pose:={VOID_POSE_TOPIC}",
             f"/sgr532/gripper/command:={VOID_GRIP_TOPIC}"],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        try:
            msg = rospy.wait_for_message(PEEK_JS_TOPIC, JointState, timeout=3.0)
            name_to_pos = dict(zip(msg.name, msg.position))
            positions = [name_to_pos.get(j, 0.0) for j in JOINT_NAMES]
        except rospy.ROSException:
            rospy.logwarn("[BagRecorder] Timed out peeking bag's initial pose.")
            positions = None
        finally:
            if proc.poll() is None:
                # SIGINT (not terminate): lets rosbag play unregister from the
                # master instead of leaving a zombie /play_* node registration.
                proc.send_signal(signal.SIGINT)
                try:
                    proc.wait(timeout=2.0)
                except subprocess.TimeoutExpired:
                    proc.kill()
        return positions

    def _solve_ik(self, pose_stamped):
        # Mirrors light_ik_solver.py's request: pose passed through so its
        # frame_id is preserved; no ik_link_name -> group tip link.
        req = GetPositionIKRequest()
        req.ik_request.group_name = IK_GROUP
        pose_stamped.header.stamp = rospy.Time.now()  # bag stamps are stale
        req.ik_request.pose_stamped = pose_stamped
        req.ik_request.timeout = rospy.Duration(0.05)
        try:
            res = self._ik_service(req)
        except rospy.ServiceException as e:
            rospy.logwarn_throttle(1.0, f"[BagRecorder] compute_ik call failed: {e}")
            return None
        if res.error_code.val != 1:
            rospy.logwarn_throttle(
                1.0, f"[BagRecorder] IK failed (error {res.error_code.val}); dropping pose."
            )
            return None
        return list(res.solution.joint_state.position[:6])

    def _peek_initial_ee_pose(self, bag_path):
        # -r 0 only latches messages at bag t=0, which works for ~100 Hz
        # joint_states but can miss the sparser first vr_target_pose. Instead
        # blast the first 5 s of bag time with --immediate; wait_for_message
        # returns the FIRST pose it sees, so the pre-position target stays at
        # the true start of the motion even if teleop began a few seconds into
        # the recording. -d 1 makes rosbag pause 1 s after advertising (default
        # is only 0.2 s) so the wait_for_message subscriber is connected before
        # the burst fires. Poses go to the dedicated PEEK topic, and every
        # other recorded topic is remapped away from its live consumer so
        # nothing — especially the gripper — twitches during peek.
        proc = subprocess.Popen(
            ["rosbag", "play", "--immediate", "-u", "5", "-d", "1", bag_path,
             f"/sgr532/vr_target_pose:={PEEK_EE_TOPIC}",
             f"/sgr532/joint_states:={VOID_JS_TOPIC}",
             f"/sgr532/gripper/command:={VOID_GRIP_TOPIC}"],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        try:
            pose = rospy.wait_for_message(PEEK_EE_TOPIC, PoseStamped, timeout=8.0)
        except rospy.ROSException:
            rospy.logwarn(
                "[BagRecorder] Timed out peeking bag's initial EE pose "
                "(bag may predate vr_target_pose recording)."
            )
            pose = None
        finally:
            if proc.poll() is None:
                # SIGINT (not terminate): lets rosbag play unregister from the
                # master instead of leaving a zombie /play_* node registration.
                proc.send_signal(signal.SIGINT)
                try:
                    proc.wait(timeout=2.0)
                except subprocess.TimeoutExpired:
                    proc.kill()
        return pose

    def _make_goal(self, target_positions, duration):
        # The sdk driver rejects any trajectory with fewer than 2 points
        # (sdk_sagittarius_arm_real.cpp, setSucceeded(INVALID_GOAL) — silent!),
        # so every goal must be [current joints @ t=0, target @ t=duration],
        # the same shape light_ik_solver sends.
        goal = FollowJointTrajectoryGoal()
        goal.trajectory.joint_names = JOINT_NAMES

        start = JointTrajectoryPoint()
        js = self._latest_real_js
        if js is not None:
            name_to_pos = dict(zip(js.name, js.position))
            start.positions = [name_to_pos.get(j, 0.0) for j in JOINT_NAMES]
        else:
            # No encoder feedback yet — duplicate the target so the driver
            # still gets its 2 points (equivalent to a direct jump command).
            start.positions = list(target_positions)
        start.velocities = [0.0] * len(JOINT_NAMES)
        start.time_from_start = rospy.Duration(0.0)
        goal.trajectory.points.append(start)

        end = JointTrajectoryPoint()
        end.positions = list(target_positions)
        end.velocities = [0.0] * len(JOINT_NAMES)
        end.time_from_start = rospy.Duration(duration)
        goal.trajectory.points.append(end)
        return goal

    def _move_to_and_wait(self, positions, tolerance=0.05, timeout=5.0):
        self._arm_client.send_goal(self._make_goal(positions, 2.0))

        rate = rospy.Rate(20)
        deadline = rospy.Time.now() + rospy.Duration(timeout)
        while rospy.Time.now() < deadline:
            js = self._latest_real_js
            if js is not None:
                name_to_pos = dict(zip(js.name, js.position))
                current = [name_to_pos.get(j, 0.0) for j in JOINT_NAMES]
                if max(abs(c - t) for c, t in zip(current, positions)) < tolerance:
                    return
            rate.sleep()
        rospy.logwarn("[BagRecorder] Timed out waiting to reach initial pose; proceeding anyway.")

    # ── command handlers ──────────────────────────────────────────────────────

    def _control_callback(self, msg):
        raw = msg.data.strip().upper()
        with self._state_lock:
            if raw.startswith("RECORD:"):
                slot = self._parse_slot(raw[7:])
                if slot:
                    self._cmd_record(slot)
            elif raw.startswith("PLAY:"):
                slot = self._parse_slot(raw[5:])
                if slot:
                    self._cmd_play(slot)
            elif raw == "STOP":
                self._cmd_stop()
            elif raw.startswith("CLEAR:"):
                slot = self._parse_slot(raw[6:])
                if slot:
                    self._cmd_clear(slot)
            else:
                rospy.logwarn(f"[BagRecorder] Unknown command: '{raw}'")

    def _cmd_record(self, slot):
        self._cmd_stop()
        bag_path = self._slot_path(slot)
        for stale in (bag_path, bag_path + ".active"):
            if os.path.exists(stale):
                os.remove(stale)
        self._proc = subprocess.Popen(
            ["rosbag", "record", "-O", self._slot_prefix(slot),
             "/sgr532/joint_states", "/sgr532/gripper/command",
             "/sgr532/vr_target_pose"],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        self._state = "RECORDING"
        self._active_slot = slot
        self._publish_status()
        rospy.loginfo(f"[BagRecorder] Recording slot {slot}  (PID {self._proc.pid})")

    def _cmd_play(self, slot):
        bag_path = self._playable_path(slot)
        if bag_path is None:
            rospy.logwarn(f"[BagRecorder] Slot {slot} has no bag: {self._slot_path(slot)}")
            return
        self._cmd_stop()

        if self._playback_mode == "ee":
            self._start_play_ee(slot, bag_path)
        else:
            self._start_play_joints(slot, bag_path)

    def _start_play_joints(self, slot, bag_path):
        positions = self._peek_initial_positions(bag_path)
        if positions is not None:
            rospy.loginfo(f"[BagRecorder] Pre-positioning to slot {slot} start pose...")
            self._move_to_and_wait(positions)
        else:
            rospy.logwarn(f"[BagRecorder] Could not read initial pose for slot {slot}; skipping pre-position.")

        # Remap joint_states to a shadow topic so live hardware encoder feedback
        # is not polluted by replayed data, and vr_target_pose to a void topic
        # so light_ik_solver never sees replayed poses. Gripper commands are NOT
        # remapped — they go directly to the gripper hardware, which is correct
        # during playback.
        self._start_capture(slot, "joints")
        self._proc = subprocess.Popen(
            ["rosbag", "play", bag_path,
             f"/sgr532/joint_states:={PLAYBACK_JS_TOPIC}",
             f"/sgr532/vr_target_pose:={VOID_POSE_TOPIC}"],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        self._state = "PLAYING"
        self._active_slot = slot
        self._publish_status()
        rospy.loginfo(f"[BagRecorder] Playing slot {slot}  (PID {self._proc.pid})")

    def _start_play_ee(self, slot, bag_path):
        try:
            rospy.wait_for_service("/sgr532/compute_ik", timeout=5.0)
        except rospy.ROSException:
            rospy.logwarn(
                "[BagRecorder] /sgr532/compute_ik unavailable; aborting EE playback."
            )
            return

        pose = self._peek_initial_ee_pose(bag_path)
        positions = self._solve_ik(pose) if pose is not None else None
        if positions is not None:
            rospy.loginfo(f"[BagRecorder] Pre-positioning to slot {slot} start EE pose...")
            self._move_to_and_wait(positions)
        else:
            rospy.logwarn(
                f"[BagRecorder] Could not resolve initial EE pose for slot {slot}; skipping pre-position."
            )

        self._last_ee_pose = None  # fresh deadband for this playback

        # vr_target_pose goes to the shadow topic this node solves IK on;
        # joint_states to a void topic so replayed encoder data cannot pollute
        # live feedback. Gripper passthrough, same as joints mode.
        self._start_capture(slot, "ee")
        self._proc = subprocess.Popen(
            ["rosbag", "play", bag_path,
             f"/sgr532/vr_target_pose:={PLAYBACK_EE_TOPIC}",
             f"/sgr532/joint_states:={VOID_JS_TOPIC}"],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        self._state = "PLAYING_EE"
        self._active_slot = slot
        self._publish_status()
        rospy.loginfo(f"[BagRecorder] Playing slot {slot} via EE/IK  (PID {self._proc.pid})")

    def _cmd_stop(self):
        self._stop_subprocess()
        self._stop_capture()
        self._arm_client.cancel_all_goals()
        self._last_ee_pose = None
        self._state = "IDLE"
        self._active_slot = None
        self._publish_status()
        rospy.loginfo("[BagRecorder] Stopped. State: IDLE")

    def _cmd_clear(self, slot):
        if self._state != "IDLE":
            rospy.logwarn("[BagRecorder] Send STOP before CLEAR.")
            return
        bag_path = self._slot_path(slot)
        removed = False
        for p in (bag_path, bag_path + ".active"):
            if os.path.exists(p):
                os.remove(p)
                removed = True
        if removed:
            rospy.loginfo(f"[BagRecorder] Cleared slot {slot}")
        else:
            rospy.loginfo(f"[BagRecorder] Slot {slot} already empty.")

    # ── topic callbacks ────────────────────────────────────────────────────────

    def _real_js_callback(self, msg):
        self._latest_real_js = msg
        if self._capture_writer is not None:
            name_to_pos = dict(zip(msg.name, msg.position))
            elapsed = (rospy.Time.now() - self._capture_start).to_sec()
            self._capture_writer.writerow(
                [elapsed] + [name_to_pos.get(j, 0.0) for j in JOINT_NAMES])

    def _ik_goal_callback(self, goal):
        with self._state_lock:
            if self._is_playing():
                return  # block teleop during playback
            self._arm_client.send_goal(goal)

    def _playback_js_callback(self, msg):
        with self._state_lock:
            if self._state != "PLAYING":
                return

        name_to_pos = dict(zip(msg.name, msg.position))
        positions = [name_to_pos.get(j, 0.0) for j in JOINT_NAMES]

        self._arm_client.send_goal(
            self._make_goal(positions, 1.0 / PLAYBACK_RATE_HZ))

    def _playback_ee_callback(self, msg):
        with self._state_lock:
            if self._state != "PLAYING_EE":
                return

        # Deadband — same math/thresholds as light_ik_solver.pose_changed_significantly,
        # so stationary poses don't hammer compute_ik at the replayed stream rate.
        if self._last_ee_pose is not None:
            p, q = msg.pose.position, msg.pose.orientation
            lp, lq = self._last_ee_pose.position, self._last_ee_pose.orientation
            pos_diff = math.sqrt((p.x - lp.x) ** 2 + (p.y - lp.y) ** 2 + (p.z - lp.z) ** 2)
            rot_diff = (abs(q.x - lq.x) + abs(q.y - lq.y)
                        + abs(q.z - lq.z) + abs(q.w - lq.w))
            if pos_diff <= EE_POS_THRESHOLD and rot_diff <= EE_ROT_THRESHOLD:
                return
        self._last_ee_pose = msg.pose

        positions = self._solve_ik(msg)
        if positions is None:
            return  # dropped; _solve_ik already logged (throttled)

        # Fixed timing for parity with joints playback: the command source is
        # the only variable in the joints-vs-EE accuracy comparison.
        goal = self._make_goal(positions, 1.0 / PLAYBACK_RATE_HZ)

        # Re-check under the lock: the blocking compute_ik call above leaves a
        # window where STOP may have cancelled all goals — never send after it.
        with self._state_lock:
            if self._state != "PLAYING_EE":
                return
            self._arm_client.send_goal(goal)

    def _playback_timer_cb(self, event):
        with self._state_lock:
            if not self._is_playing() or self._proc is None:
                return
            if self._proc.poll() is not None:
                rospy.loginfo(
                    f"[BagRecorder] Playback finished (exit {self._proc.returncode}). → IDLE"
                )
                self._proc = None
                self._stop_capture()
                self._state = "IDLE"
                self._active_slot = None
                self._last_ee_pose = None
                self._publish_status()


if __name__ == "__main__":
    try:
        ArmBagRecorder()
        rospy.spin()
    except rospy.ROSInterruptException:
        pass
