#!/usr/bin/env python
"""
Dashboard controller node.
Exposes four services used by the Unity CommandSlotDashboard:
  - dashboard/record        (DashboardRecord)    start/stop rosbag recording
  - dashboard/playback      (DashboardPlayback)  start/stop rosbag playback
  - dashboard/query_slots   (DashboardQuerySlots) check which slots have data
  - dashboard/clear         (DashboardClear)     zero out a slot's bag file

Bag files are stored in ~/dashboard_bags/slot_N.bag
"""

import os
import signal
import subprocess
import threading
import rospy
from std_msgs.msg import Int32
from unity_vr_control.srv import (
    DashboardRecord,  DashboardRecordResponse,
    DashboardPlayback, DashboardPlaybackResponse,
    DashboardQuerySlots, DashboardQuerySlotsResponse,
    DashboardClear,   DashboardClearResponse,
)

BAG_DIR = os.path.expanduser("~/dashboard_bags")
RECORD_TOPICS = ["/sgr532/vr_target_pose", "/sgr532/gripper/command"]

# Active subprocesses keyed by slot index (1-5)
record_procs = {}
playback_procs = {}

playback_finished_pub = None


def _watch_playback_completion(slot, proc):
    proc.wait()
    if playback_procs.get(slot) is proc:
        playback_finished_pub.publish(Int32(data=slot))
        rospy.loginfo(f"[Dashboard] Playback finished naturally for slot {slot}")


def bag_path(slot_id):
    return os.path.join(BAG_DIR, f"slot_{slot_id}.bag")


def slot_has_data(slot_id):
    path = bag_path(slot_id)
    return os.path.isfile(path) and os.path.getsize(path) > 0


# ── Record service ─────────────────────────────────────────────────────────────

def handle_record(req):
    slot = req.slot_id
    if slot < 1 or slot > 5:
        return DashboardRecordResponse(success=False, message=f"Invalid slot {slot}")

    if req.start:
        if slot in record_procs and record_procs[slot].poll() is None:
            return DashboardRecordResponse(success=False, message=f"Slot {slot} already recording")

        os.makedirs(BAG_DIR, exist_ok=True)
        path = bag_path(slot)
        cmd = ["rosbag", "record", "-O", path] + RECORD_TOPICS
        proc = subprocess.Popen(cmd)
        record_procs[slot] = proc
        rospy.loginfo(f"[Dashboard] Recording slot {slot} → {path} (pid {proc.pid})")
        return DashboardRecordResponse(success=True, message=f"Recording started for slot {slot}")
    else:
        proc = record_procs.pop(slot, None)
        if proc is None:
            return DashboardRecordResponse(success=False, message=f"Slot {slot} not recording")
        if proc.poll() is not None:
            return DashboardRecordResponse(success=True, message=f"Slot {slot} recording already finished")

        # Send SIGINT so rosbag writes its index before exiting
        proc.send_signal(signal.SIGINT)
        try:
            proc.wait(timeout=5)
        except subprocess.TimeoutExpired:
            proc.kill()
        rospy.loginfo(f"[Dashboard] Recording stopped for slot {slot}")
        return DashboardRecordResponse(success=True, message=f"Recording stopped for slot {slot}")


# ── Playback service ───────────────────────────────────────────────────────────

def handle_playback(req):
    # TODO: unlike arm_bag_recorder.py's MUX, this service has no joint-state
    # tracking or action client, so it can't pre-position the arm to the bag's
    # initial pose before playback starts (see arm_bag_recorder._cmd_play).
    slot = req.slot_id
    if slot < 1 or slot > 5:
        return DashboardPlaybackResponse(success=False, message=f"Invalid slot {slot}")

    if req.start:
        if not slot_has_data(slot):
            return DashboardPlaybackResponse(success=False, message=f"Slot {slot} has no recording")

        if slot in playback_procs and playback_procs[slot].poll() is None:
            return DashboardPlaybackResponse(success=False, message=f"Slot {slot} already playing")

        path = bag_path(slot)
        proc = subprocess.Popen(["rosbag", "play", path])
        playback_procs[slot] = proc
        threading.Thread(target=_watch_playback_completion, args=(slot, proc), daemon=True).start()
        rospy.loginfo(f"[Dashboard] Playback started for slot {slot} ← {path} (pid {proc.pid})")
        return DashboardPlaybackResponse(success=True, message=f"Playback started for slot {slot}")
    else:
        proc = playback_procs.pop(slot, None)
        if proc is None:
            return DashboardPlaybackResponse(success=False, message=f"Slot {slot} not playing")
        if proc.poll() is not None:
            return DashboardPlaybackResponse(success=True, message=f"Slot {slot} playback already finished")

        proc.send_signal(signal.SIGINT)
        try:
            proc.wait(timeout=5)
        except subprocess.TimeoutExpired:
            proc.kill()
        rospy.loginfo(f"[Dashboard] Playback stopped for slot {slot}")
        return DashboardPlaybackResponse(success=True, message=f"Playback stopped for slot {slot}")


# ── Query slots service ────────────────────────────────────────────────────────

def handle_query_slots(req):
    has = [slot_has_data(i) for i in range(1, 6)]
    rospy.loginfo(f"[Dashboard] QuerySlots → {has}")
    return DashboardQuerySlotsResponse(has_recording=has)


# ── Clear service ──────────────────────────────────────────────────────────────

def handle_clear(req):
    slot = req.slot_id
    if slot < 1 or slot > 5:
        return DashboardClearResponse(success=False, message=f"Invalid slot {slot}")

    # Stop recording/playback if active
    for procs_dict in (record_procs, playback_procs):
        proc = procs_dict.pop(slot, None)
        if proc and proc.poll() is None:
            proc.send_signal(signal.SIGINT)
            try: proc.wait(timeout=3)
            except subprocess.TimeoutExpired: proc.kill()

    path = bag_path(slot)
    try:
        # Zero out the file (truncate to 0 bytes), preserving the path so
        # slot_has_data() returns False on next QuerySlots call.
        with open(path, 'wb'):
            pass
        rospy.loginfo(f"[Dashboard] Cleared slot {slot} at {path}")
        return DashboardClearResponse(success=True, message=f"Slot {slot} cleared")
    except Exception as e:
        rospy.logerr(f"[Dashboard] Failed to clear slot {slot}: {e}")
        return DashboardClearResponse(success=False, message=str(e))


# ── Main ───────────────────────────────────────────────────────────────────────

def main():
    global playback_finished_pub
    rospy.init_node("dashboard_controller")
    os.makedirs(BAG_DIR, exist_ok=True)

    playback_finished_pub = rospy.Publisher("/dashboard/playback_finished", Int32, queue_size=10)

    rospy.Service("dashboard/record",      DashboardRecord,      handle_record)
    rospy.Service("dashboard/playback",    DashboardPlayback,    handle_playback)
    rospy.Service("dashboard/query_slots", DashboardQuerySlots,  handle_query_slots)
    rospy.Service("dashboard/clear",       DashboardClear,       handle_clear)

    rospy.loginfo("[Dashboard] dashboard_controller ready. Bags → " + BAG_DIR)
    rospy.spin()


if __name__ == "__main__":
    main()
