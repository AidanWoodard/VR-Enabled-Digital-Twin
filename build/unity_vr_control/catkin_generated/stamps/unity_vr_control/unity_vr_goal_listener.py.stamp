#!/usr/bin/env python

import rospy
import moveit_commander
from geometry_msgs.msg import PoseStamped

# Global state
move_group = None
last_pose = None
POSE_TOLERANCE = 0.03  # meters
ROT_TOLERANCE = 0.05   # radians


def poses_are_similar(p1, p2):
    """Check if position/rotation difference is small enough to skip"""
    if p1 is None or p2 is None:
        return False
    pos_diff = (
        abs(p1.position.x - p2.position.x) +
        abs(p1.position.y - p2.position.y) +
        abs(p1.position.z - p2.position.z)
    )
    # (Optional: can add quaternion angular difference too)
    return pos_diff < POSE_TOLERANCE

def callback(msg):
    global last_pose

    rospy.loginfo(f"[VR] Received pose:\n{msg.pose}")

    # Avoid redundant planning for nearly identical poses
    if poses_are_similar(msg.pose, last_pose):
        rospy.loginfo("[VR] Pose similar to previous. Skipping planning.")
        return

    last_pose = msg.pose

    # Get current robot pose (for debugging)
    current_pose = move_group.get_current_pose().pose
    rospy.loginfo(f"[Robot] Current EE pose:\n{current_pose}")

    # Update planner state
    move_group.set_start_state_to_current_state()
    msg.header.frame_id = move_group.get_planning_frame()
    move_group.set_pose_target(msg.pose)

    # Plan and execute
    plan_success = move_group.go(wait=False)
    rospy.loginfo(f"[Plan] Success: {plan_success}")

    # Cleanup
    move_group.stop()
    move_group.clear_pose_targets()

def main():
    global move_group

    rospy.init_node('unity_vr_goal_listener')
    moveit_commander.roscpp_initialize([])

    # Init MoveIt interfaces
    robot = moveit_commander.RobotCommander(robot_description="/sgr532/robot_description")
    scene = moveit_commander.PlanningSceneInterface()
    move_group = moveit_commander.MoveGroupCommander("sagittarius_arm")

    # Subscribe to VR target pose
    rospy.Subscriber('/sgr532/vr_target_pose', PoseStamped, callback)
    rospy.loginfo("[VR Bridge] Subscribed to /sgr532/vr_target_pose and waiting for input...")

    rospy.spin()

if __name__ == '__main__':
    main()
