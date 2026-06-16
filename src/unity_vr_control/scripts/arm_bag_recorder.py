#!/usr/bin/env python3

import os
import subprocess
import threading

import actionlib
import rospy
from control_msgs.msg import FollowJointTrajectoryAction, FollowJointTrajectoryGoal
from sensor_msgs.msg import JointState
from std_msgs.msg import String
from trajectory_msgs.msg import JointTrajectoryPoint

RECORDINGS_DIR = os.path.expanduser("~/ROS_Files/sagittarius_ws/recordings")
NUM_SLOTS = 5
JOINT_NAMES = ['joint1', 'joint2', 'joint3', 'joint4', 'joint5', 'joint6']
PLAYBACK_RATE_HZ = 10
PLAYBACK_JS_TOPIC = "/sgr532/playback/joint_states"


class ArmBagRecorder:
    def __init__(self):
        rospy.init_node("arm_bag_recorder", anonymous=False)

        os.makedirs(RECORDINGS_DIR, exist_ok=True)

        self._state = "IDLE"
        self._active_slot = None
        self._proc = None
        self._state_lock = threading.Lock()

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

        rospy.Timer(rospy.Duration(1.0 / PLAYBACK_RATE_HZ), self._playback_timer_cb)

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
        else:
            msg = f"PLAYING:{self._active_slot}"
        self._status_pub.publish(String(data=msg))

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
        if self._proc and self._proc.poll() is None:
            self._proc.terminate()
            try:
                self._proc.wait(timeout=2.0)
            except subprocess.TimeoutExpired:
                self._proc.kill()
        self._proc = None

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
        if os.path.exists(bag_path):
            os.remove(bag_path)
        self._proc = subprocess.Popen(
            ["rosbag", "record", "-O", self._slot_prefix(slot),
             "/sgr532/joint_states", "/sgr532/gripper/command"],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        self._state = "RECORDING"
        self._active_slot = slot
        self._publish_status()
        rospy.loginfo(f"[BagRecorder] Recording slot {slot}  (PID {self._proc.pid})")

    def _cmd_play(self, slot):
        bag_path = self._slot_path(slot)
        if not os.path.exists(bag_path):
            rospy.logwarn(f"[BagRecorder] Slot {slot} bag not found: {bag_path}")
            return
        self._cmd_stop()
        # Remap joint_states to a shadow topic so live hardware encoder feedback
        # is not polluted by replayed data. Gripper commands are NOT remapped —
        # they go directly to the gripper hardware, which is correct during playback.
        self._proc = subprocess.Popen(
            ["rosbag", "play", bag_path,
             f"/sgr532/joint_states:={PLAYBACK_JS_TOPIC}"],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        self._state = "PLAYING"
        self._active_slot = slot
        self._publish_status()
        rospy.loginfo(f"[BagRecorder] Playing slot {slot}  (PID {self._proc.pid})")

    def _cmd_stop(self):
        self._stop_subprocess()
        self._arm_client.cancel_all_goals()
        self._state = "IDLE"
        self._active_slot = None
        self._publish_status()
        rospy.loginfo("[BagRecorder] Stopped. State: IDLE")

    def _cmd_clear(self, slot):
        if self._state != "IDLE":
            rospy.logwarn("[BagRecorder] Send STOP before CLEAR.")
            return
        bag_path = self._slot_path(slot)
        if os.path.exists(bag_path):
            os.remove(bag_path)
            rospy.loginfo(f"[BagRecorder] Cleared slot {slot}")
        else:
            rospy.loginfo(f"[BagRecorder] Slot {slot} already empty.")

    # ── topic callbacks ────────────────────────────────────────────────────────

    def _ik_goal_callback(self, goal):
        with self._state_lock:
            if self._state == "PLAYING":
                return  # block teleop during playback
            self._arm_client.send_goal(goal)

    def _playback_js_callback(self, msg):
        with self._state_lock:
            if self._state != "PLAYING":
                return

        name_to_pos = dict(zip(msg.name, msg.position))
        positions = [name_to_pos.get(j, 0.0) for j in JOINT_NAMES]

        goal = FollowJointTrajectoryGoal()
        goal.trajectory.joint_names = JOINT_NAMES
        goal.trajectory.header.stamp = rospy.Time.now()

        pt = JointTrajectoryPoint()
        pt.positions = positions
        pt.velocities = [0.0] * len(JOINT_NAMES)
        pt.time_from_start = rospy.Duration(1.0 / PLAYBACK_RATE_HZ)
        goal.trajectory.points.append(pt)

        self._arm_client.send_goal(goal)

    def _playback_timer_cb(self, event):
        with self._state_lock:
            if self._state != "PLAYING" or self._proc is None:
                return
            if self._proc.poll() is not None:
                rospy.loginfo(
                    f"[BagRecorder] Playback finished (exit {self._proc.returncode}). → IDLE"
                )
                self._proc = None
                self._state = "IDLE"
                self._active_slot = None
                self._publish_status()


if __name__ == "__main__":
    try:
        ArmBagRecorder()
        rospy.spin()
    except rospy.ROSInterruptException:
        pass
