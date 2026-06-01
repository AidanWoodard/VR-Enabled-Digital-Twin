#!/usr/bin/env python

import rospy
import os
import json
from geometry_msgs.msg import PoseStamped
from std_msgs.msg import Float64

# Path to store your poses
SAVE_PATH = os.path.expanduser("~/sagittarius_ws/src/sagittarius_arm_ros/unity_vr_control/scripts/teleop_poses.json")

# Initialize list to store poses and the latest gripper value
saved_poses = []
latest_gripper_value = 0.0

def gripper_callback(msg):
    global latest_gripper_value
    latest_gripper_value = msg.data
    rospy.loginfo(f"[TeleopLogger] Gripper state updated: {latest_gripper_value}")

def pose_callback(msg):
    pose_data = {
        "position": {
            "x": msg.pose.position.x,
            "y": msg.pose.position.y,
            "z": msg.pose.position.z
        },
        "orientation": {
            "x": msg.pose.orientation.x,
            "y": msg.pose.orientation.y,
            "z": msg.pose.orientation.z,
            "w": msg.pose.orientation.w
        },
        "gripper": latest_gripper_value
    }

    saved_poses.append(pose_data)
    rospy.loginfo(f"[TeleopLogger] Pose + gripper saved: {pose_data}")

    with open(SAVE_PATH, 'w') as f:
        json.dump(saved_poses, f, indent=4)

def listener():
    rospy.init_node('teleop_logger', anonymous=True)
    rospy.Subscriber('/sgr532/teach_pose', PoseStamped, pose_callback)
    rospy.Subscriber('/sgr532/gripper/command', Float64, gripper_callback)
    rospy.loginfo("[TeleopLogger] Listening to /sgr532/teach_pose and /sgr532/gripper/command...")
    rospy.spin()

if __name__ == '__main__':
    listener()
