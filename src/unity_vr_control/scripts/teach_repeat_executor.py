#!/usr/bin/env python

import rospy
import json
import os
import time
import moveit_commander
from geometry_msgs.msg import PoseStamped, Point, Quaternion
from std_msgs.msg import Float64

JSON_PATH = os.path.expanduser("~/sagittarius_ws/src/sagittarius_arm_ros/unity_vr_control/scripts/teleop_poses.json")

def main():
    rospy.init_node("teach_repeat_executor")

    rospy.loginfo("[Executor] Waiting for MoveIt to fully start...")
    rospy.sleep(5)
    moveit_commander.roscpp_initialize([])

    robot = moveit_commander.RobotCommander(robot_description="/sgr532/robot_description")
    scene = moveit_commander.PlanningSceneInterface()
    move_group = moveit_commander.MoveGroupCommander("sagittarius_arm")

    gripper_pub = rospy.Publisher("/sgr532/gripper/command", Float64, queue_size=10)
    rospy.sleep(1.0)

    if not os.path.exists(JSON_PATH):
        rospy.logerr(f"[Executor] Could not find pose file at {JSON_PATH}")
        return

    with open(JSON_PATH, 'r') as f:
        saved_poses = json.load(f)

    rospy.loginfo(f"[Executor] Loaded {len(saved_poses)} poses")

    # Insert current pose as the first pose
    current_pose = move_group.get_current_pose().pose
    start_pose_data = {
        "position": {
            "x": current_pose.position.x,
            "y": current_pose.position.y,
            "z": current_pose.position.z
        },
        "orientation": {
            "x": current_pose.orientation.x,
            "y": current_pose.orientation.y,
            "z": current_pose.orientation.z,
            "w": current_pose.orientation.w
        },
        "gripper": 0.0  # default
    }
    saved_poses.insert(0, start_pose_data)
    rospy.loginfo("[Executor] Inserted current robot pose as first position")

    while not rospy.is_shutdown():
        for i, pose_data in enumerate(saved_poses):
            rospy.loginfo(f"[Executor] Executing pose {i+1}/{len(saved_poses)}")

            pose_msg = PoseStamped()
            pose_msg.header.frame_id = move_group.get_planning_frame()
            pose_msg.header.stamp = rospy.Time.now()
            pose_msg.pose.position = Point(
                x=pose_data["position"]["x"],
                y=pose_data["position"]["y"],
                z=pose_data["position"]["z"]
            )
            pose_msg.pose.orientation = Quaternion(
                x=pose_data["orientation"]["x"],
                y=pose_data["orientation"]["y"],
                z=pose_data["orientation"]["z"],
                w=pose_data["orientation"]["w"]
            )

            move_group.set_start_state_to_current_state()
            move_group.set_pose_target(pose_msg)

            plan_success = False
            attempt = 0
            max_attempts = 3

            while not plan_success and attempt < max_attempts:
                attempt += 1
                rospy.loginfo(f"[Executor] Attempt {attempt} to plan and execute pose {i+1}")
                plan_success = move_group.go(wait=True)

                if not plan_success:
                    rospy.logwarn(f"[Executor] Attempt {attempt} failed. Retrying...")
                    rospy.sleep(1.5)  # wait a bit before retry

            if plan_success:
                rospy.loginfo(f"[Executor] Pose {i+1} executed successfully ")
                rospy.loginfo(f"[Executor] Robot at Position {pose_data['position']}")

            else:
                rospy.logerr(f"[Executor] Failed to execute pose {i+1} after {max_attempts} attempts ")

            move_group.stop()
            move_group.clear_pose_targets()

            if "gripper" in pose_data:
                gripper_value = pose_data["gripper"]
                gripper_pub.publish(Float64(gripper_value))
                rospy.loginfo(f"[Executor] Gripper value set to {gripper_value}")

            rospy.sleep(2.0)  # Full stop before next pose

    rospy.loginfo("[Executor] All saved poses executed.")

if __name__ == "__main__":
    main()


