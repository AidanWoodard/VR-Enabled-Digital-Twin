#!/usr/bin/env python3
"""
Dashboard controller node — thin adapter between Unity's CommandSlotDashboard
and the arm_bag_recorder MUX.

Exposes the same four services as before (Unity's C# side is unchanged):
  - dashboard/record        (DashboardRecord)     start/stop recording
  - dashboard/playback      (DashboardPlayback)   start/stop playback
  - dashboard/query_slots   (DashboardQuerySlots) check which slots have data
  - dashboard/clear         (DashboardClear)      delete a slot's bag

This node no longer spawns its own rosbag subprocesses. Every operation is
forwarded to the MUX (arm_bag_recorder.py) as a string command on
/sgr532/bag_control, and outcomes are confirmed by watching the MUX's latched
/sgr532/bag_status. Bags therefore live in the MUX's slot set
(~/ROS_Files/sagittarius_ws/recordings/slot_N.bag), and dashboard playback
gets the MUX's pre-positioning, teleop gating, and joints-vs-EE playback_mode
for free. Bags under ~/dashboard_bags/ are orphaned legacy data from the old
standalone implementation and no longer appear in the dashboard.

/dashboard/playback_finished (std_msgs/Int32, payload = slot index) still
fires exactly once when a playback ends on its own, and never on a manual
stop: a PLAYING[_EE]:N → IDLE status transition counts as natural only if no
dashboard command was issued within the last CMD_SUPPRESS_WINDOW seconds.
"""

import os
import threading
import time

import rospy
from std_msgs.msg import Int32, String
from unity_vr_control.srv import (
    DashboardRecord,  DashboardRecordResponse,
    DashboardPlayback, DashboardPlaybackResponse,
    DashboardQuerySlots, DashboardQuerySlotsResponse,
    DashboardClear,   DashboardClearResponse,
)

# Must match arm_bag_recorder.py's RECORDINGS_DIR / NUM_SLOTS.
RECORDINGS_DIR = os.path.expanduser("~/ROS_Files/sagittarius_ws/recordings")
NUM_SLOTS = 5

# A PLAYING→IDLE transition this soon after a dashboard command is
# command-induced (STOP, or the implicit stop inside CLEAR), not a natural
# playback finish.
CMD_SUPPRESS_WINDOW = 1.0

bag_control_pub = None
playback_finished_pub = None

# MUX state mirrored from the latched /sgr532/bag_status. _status_state stays
# None until the first message arrives — i.e. while the MUX is down.
_status_cond = threading.Condition()
_status_state = None   # "IDLE" | "RECORDING" | "PLAYING" | "PLAYING_EE"
_status_slot = None
_last_cmd_time = 0.0


def _send_cmd(cmd):
    global _last_cmd_time
    with _status_cond:
        _last_cmd_time = time.monotonic()
    bag_control_pub.publish(String(data=cmd))


def _status_callback(msg):
    global _status_state, _status_slot
    state, _, slot_str = msg.data.partition(":")
    slot = int(slot_str) if slot_str.isdigit() else None
    with _status_cond:
        prev_state, prev_slot = _status_state, _status_slot
        _status_state, _status_slot = state, slot
        natural_finish = (
            prev_state in ("PLAYING", "PLAYING_EE")
            and state == "IDLE"
            and time.monotonic() - _last_cmd_time > CMD_SUPPRESS_WINDOW
        )
        _status_cond.notify_all()
    if natural_finish:
        playback_finished_pub.publish(Int32(data=prev_slot))
        rospy.loginfo(f"[Dashboard] Playback finished naturally for slot {prev_slot}")


def _current_status():
    with _status_cond:
        return _status_state, _status_slot


def _wait_for_status(predicate, timeout=2.0):
    deadline = time.monotonic() + timeout
    with _status_cond:
        while not predicate(_status_state, _status_slot):
            remaining = deadline - time.monotonic()
            if remaining <= 0:
                return False
            _status_cond.wait(remaining)
        return True


def bag_path(slot_id):
    return os.path.join(RECORDINGS_DIR, f"slot_{slot_id}.bag")


def slot_has_data(slot_id):
    path = bag_path(slot_id)
    active_path = path + ".active"
    return (os.path.isfile(path) and os.path.getsize(path) > 0) or \
           (os.path.isfile(active_path) and os.path.getsize(active_path) > 0)


def _mux_down_response(response_cls):
    return response_cls(
        success=False,
        message="MUX unavailable — no /sgr532/bag_status yet (is arm_bag_recorder running?)",
    )


# ── Record service ─────────────────────────────────────────────────────────────

def handle_record(req):
    slot = req.slot_id
    if slot < 1 or slot > NUM_SLOTS:
        return DashboardRecordResponse(success=False, message=f"Invalid slot {slot}")

    state, active = _current_status()
    if state is None:
        return _mux_down_response(DashboardRecordResponse)

    if req.start:
        if state == "RECORDING":
            return DashboardRecordResponse(
                success=False,
                message=(f"Slot {slot} already recording" if active == slot
                         else f"Slot {active} is recording — stop it first"))
        if state in ("PLAYING", "PLAYING_EE"):
            return DashboardRecordResponse(
                success=False, message=f"Playback active on slot {active} — stop it first")

        _send_cmd(f"RECORD:{slot}")
        if _wait_for_status(lambda s, n: s == "RECORDING" and n == slot):
            rospy.loginfo(f"[Dashboard] Recording started for slot {slot} (via MUX)")
            return DashboardRecordResponse(success=True, message=f"Recording started for slot {slot}")
        return DashboardRecordResponse(
            success=False, message=f"MUX did not start recording slot {slot}")
    else:
        if not (state == "RECORDING" and active == slot):
            return DashboardRecordResponse(success=False, message=f"Slot {slot} not recording")

        _send_cmd("STOP")
        # Generous timeout: the MUX SIGINTs rosbag record and waits for the
        # index write / .bag.active → .bag rename before going IDLE.
        if _wait_for_status(lambda s, n: s == "IDLE", timeout=12.0):
            rospy.loginfo(f"[Dashboard] Recording stopped for slot {slot}")
            return DashboardRecordResponse(success=True, message=f"Recording stopped for slot {slot}")
        return DashboardRecordResponse(
            success=False, message=f"MUX did not confirm stop for slot {slot}")


# ── Playback service ───────────────────────────────────────────────────────────

def handle_playback(req):
    slot = req.slot_id
    if slot < 1 or slot > NUM_SLOTS:
        return DashboardPlaybackResponse(success=False, message=f"Invalid slot {slot}")

    state, active = _current_status()
    if state is None:
        return _mux_down_response(DashboardPlaybackResponse)

    if req.start:
        if not slot_has_data(slot):
            return DashboardPlaybackResponse(success=False, message=f"Slot {slot} has no recording")
        if state == "RECORDING":
            return DashboardPlaybackResponse(
                success=False, message=f"Slot {active} is still recording — stop recording first")
        if state in ("PLAYING", "PLAYING_EE"):
            return DashboardPlaybackResponse(
                success=False,
                message=(f"Slot {slot} already playing" if active == slot
                         else f"Slot {active} is playing — stop it first"))

        _send_cmd(f"PLAY:{slot}")
        if _wait_for_status(lambda s, n: s in ("PLAYING", "PLAYING_EE") and n == slot):
            rospy.loginfo(f"[Dashboard] Playback started for slot {slot} (via MUX)")
            return DashboardPlaybackResponse(success=True, message=f"Playback started for slot {slot}")
        # No transition yet — the MUX peeks the bag and pre-positions the arm
        # (up to ~10 s joints / ~20 s EE) before flipping to PLAYING. The bag
        # exists and the MUX is up, so report optimistic success rather than
        # blocking Unity's service call for the whole pre-position phase.
        rospy.loginfo(f"[Dashboard] Playback for slot {slot} accepted; MUX pre-positioning...")
        return DashboardPlaybackResponse(
            success=True, message=f"Playback starting for slot {slot} (pre-positioning)")
    else:
        if not (state in ("PLAYING", "PLAYING_EE") and active == slot):
            return DashboardPlaybackResponse(success=False, message=f"Slot {slot} not playing")

        _send_cmd("STOP")
        if _wait_for_status(lambda s, n: s == "IDLE", timeout=5.0):
            rospy.loginfo(f"[Dashboard] Playback stopped for slot {slot}")
            return DashboardPlaybackResponse(success=True, message=f"Playback stopped for slot {slot}")
        return DashboardPlaybackResponse(
            success=False, message=f"MUX did not confirm stop for slot {slot}")


# ── Query slots service ────────────────────────────────────────────────────────

def handle_query_slots(req):
    has = [slot_has_data(i) for i in range(1, NUM_SLOTS + 1)]
    rospy.loginfo(f"[Dashboard] QuerySlots → {has}")
    return DashboardQuerySlotsResponse(has_recording=has)


# ── Clear service ──────────────────────────────────────────────────────────────

def handle_clear(req):
    slot = req.slot_id
    if slot < 1 or slot > NUM_SLOTS:
        return DashboardClearResponse(success=False, message=f"Invalid slot {slot}")

    state, active = _current_status()
    # If the MUX is busy on THIS slot, stop it first (MUX STOP is global, so
    # never send it for a different slot's clear — that would kill unrelated
    # activity). A busy MUX on another slot is fine: its rosbag child is
    # touching a different file.
    if state in ("RECORDING", "PLAYING", "PLAYING_EE") and active == slot:
        _send_cmd("STOP")
        if not _wait_for_status(lambda s, n: s == "IDLE", timeout=12.0):
            return DashboardClearResponse(
                success=False, message=f"Could not stop slot {slot} before clearing")

    # Delete both the finalized bag and any crash orphan — mirrors the MUX's
    # CLEAR semantics (file removed, slot_has_data → False).
    path = bag_path(slot)
    try:
        for p in (path, path + ".active"):
            if os.path.exists(p):
                os.remove(p)
        rospy.loginfo(f"[Dashboard] Cleared slot {slot} at {path}")
        return DashboardClearResponse(success=True, message=f"Slot {slot} cleared")
    except OSError as e:
        rospy.logerr(f"[Dashboard] Failed to clear slot {slot}: {e}")
        return DashboardClearResponse(success=False, message=str(e))


# ── Main ───────────────────────────────────────────────────────────────────────

def main():
    global bag_control_pub, playback_finished_pub
    rospy.init_node("dashboard_controller")
    os.makedirs(RECORDINGS_DIR, exist_ok=True)

    bag_control_pub = rospy.Publisher("/sgr532/bag_control", String, queue_size=10)
    playback_finished_pub = rospy.Publisher("/dashboard/playback_finished", Int32, queue_size=10)
    rospy.Subscriber("/sgr532/bag_status", String, _status_callback)

    rospy.Service("dashboard/record",      DashboardRecord,      handle_record)
    rospy.Service("dashboard/playback",    DashboardPlayback,    handle_playback)
    rospy.Service("dashboard/query_slots", DashboardQuerySlots,  handle_query_slots)
    rospy.Service("dashboard/clear",       DashboardClear,       handle_clear)

    rospy.loginfo("[Dashboard] dashboard_controller ready (MUX adapter). Bags → " + RECORDINGS_DIR)
    rospy.spin()


if __name__ == "__main__":
    main()
