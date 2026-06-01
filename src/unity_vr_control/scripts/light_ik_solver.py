#!/usr/bin/env python3

import rospy
import math
import actionlib
from geometry_msgs.msg import PoseStamped

# ==============================================================================
# CHANGED: Commented out MoveGroupCommander imports because their internal C++ 
# node handles create initialization race conditions/deadlocks on this machine.
# ==============================================================================
# from moveit_commander import RobotCommander, PlanningSceneInterface, MoveGroupCommander, roscpp_initialize

from moveit_msgs.srv import GetPositionIK, GetPositionIKRequest
from control_msgs.msg import FollowJointTrajectoryAction, FollowJointTrajectoryGoal
from trajectory_msgs.msg import JointTrajectoryPoint
from sensor_msgs.msg import JointState

class RealTimeIKSolver:
    def __init__(self):
        # ==============================================================================
        # CHANGED: Commented out roscpp_initialize because we are no longer using the 
        # C++ wrappers inside moveit_commander. Pure rospy handles everything now.
        # ==============================================================================
        # roscpp_initialize([])
        
        rospy.init_node("light_ik_solver", anonymous=True)

        # ==============================================================================
        # CHANGED: Bypassed MoveGroupCommander completely. Instead of dynamically querying
        # the MoveIt parameter server for joint names (which triggers the handshake hang), 
        # we explicitly hardcode the static Sagittarius arm joint list.
        # Modify this array if your URDF joint names ever change.
        # ==============================================================================
        # self.robot = RobotCommander(robot_description="/sgr532/robot_description")
        # self.scene = PlanningSceneInterface()
        # self.group = MoveGroupCommander("sagittarius_arm")
        # self.group.set_pose_reference_frame("base_link")
        # self.joint_names = self.group.get_active_joints()
        
        self.joint_names = ['joint1', 'joint2', 'joint3', 'joint4', 'joint5', 'joint6']
        rospy.loginfo(f"[IK Solver] Joint names bypassed & hardcoded: {self.joint_names}")

        # Action client for the arm controller
        self.client = actionlib.SimpleActionClient(
            "/sgr532/sagittarius_arm_controller/follow_joint_trajectory",
            FollowJointTrajectoryAction,
        )
        rospy.loginfo("[IK Solver] Waiting for trajectory action server...")
        self.client.wait_for_server()
        rospy.loginfo("[IK Solver] Connected to action server.")

        # IK service
        rospy.wait_for_service("/sgr532/compute_ik")
        self.ik_service = rospy.ServiceProxy("/sgr532/compute_ik", GetPositionIK)

        # Track latest joint states
        self.current_joints = None
        
        # ==============================================================================
        # CHANGED: Updated the topic path from global "/joint_states" to include the 
        # active namespace path "/sgr532/joint_states". This ensures the callback reads 
        # the real hardware encoder values instead of listening to a blank root path.
        # ==============================================================================
        # rospy.Subscriber("/joint_states", JointState, self.joint_state_callback)
        rospy.Subscriber("/sgr532/joint_states", JointState, self.joint_state_callback)

        # Initialize robot to "Home" position
        home_joints = [0.0, 0.2844886680750757, -0.32288591161895097,
                       2.076941809873252, 0.0, -2.0821777976292353]
        self.move_to_home(home_joints)

        # Pose filtering
        self.last_pose = None
        self.position_threshold = 0.003  # 3mm
        self.rotation_threshold = 0.02   # ~1 degree (quaternion diff)

        # Subscribe to VR target poses
        rospy.Subscriber("/sgr532/vr_target_pose", PoseStamped, self.pose_callback)
        rospy.loginfo("[IK Solver] Ready for VR teleop input...")

    def joint_state_callback(self, msg):
        # Save current joint positions (in order of self.joint_names)
        name_to_pos = dict(zip(msg.name, msg.position))
        self.current_joints = [name_to_pos.get(j, 0.0) for j in self.joint_names]

    def move_to_home(self, home_joints):
        rospy.loginfo(f"[IK Solver] Moving to Home position: {home_joints}")
        goal = FollowJointTrajectoryGoal()
        goal.trajectory.joint_names = self.joint_names

        # Just one point: move there in 3 seconds
        point = JointTrajectoryPoint()
        point.positions = home_joints
        point.velocities = [0.0] * len(home_joints)
        point.time_from_start = rospy.Duration(3.0)
        goal.trajectory.points.append(point)

        self.client.send_goal_and_wait(goal)
        rospy.loginfo("[IK Solver] Reached Home position.")
        self.current_joints = home_joints

    def pose_changed_significantly(self, p1, p2):
        if p1 is None or p2 is None:
            return True
        pos_diff = math.sqrt(
            (p1.position.x - p2.position.x) ** 2 +
            (p1.position.y - p2.position.y) ** 2 +
            (p1.position.z - p2.position.z) ** 2
        )
        rot_diff = abs(p1.orientation.x - p2.orientation.x) + \
                   abs(p1.orientation.y - p2.orientation.y) + \
                   abs(p1.orientation.z - p2.orientation.z) + \
                   abs(p1.orientation.w - p2.orientation.w)
        return pos_diff > self.position_threshold or rot_diff > self.rotation_threshold

    def pose_callback(self, pose_msg):
        if not self.pose_changed_significantly(pose_msg.pose, self.last_pose):
            return
        self.last_pose = pose_msg.pose

        # Solve IK for VR target pose
        ik_req = GetPositionIKRequest()
        ik_req.ik_request.group_name = "sagittarius_arm"
        ik_req.ik_request.pose_stamped = pose_msg
        ik_req.ik_request.timeout = rospy.Duration(0.05)

        try:
            ik_res = self.ik_service(ik_req)
        except rospy.ServiceException as e:
            rospy.logwarn(f"[IK Solver] IK service failed: {e}")
            return

        if ik_res.error_code.val != 1:
            rospy.logwarn(f"[IK Solver] No IK solution for pose: {pose_msg.pose}")
            return

        joint_positions = ik_res.solution.joint_state.position[:len(self.joint_names)]
        rospy.loginfo_throttle(1.0, f"[IK Solver] IK joint solution: {joint_positions}")

        # Build trajectory: start from current joints, move to new solution
        goal = FollowJointTrajectoryGoal()
        goal.trajectory.joint_names = self.joint_names

        # First point: current (starting) joints
        if self.current_joints:
            start_point = JointTrajectoryPoint()
            start_point.positions = self.current_joints
            start_point.velocities = [0.0] * len(self.current_joints)
            start_point.time_from_start = rospy.Duration(0.0)
            goal.trajectory.points.append(start_point)

        # Second point: IK solution
        end_point = JointTrajectoryPoint()
        end_point.positions = joint_positions
        end_point.velocities = [0.0] * len(joint_positions)
        end_point.time_from_start = rospy.Duration(0.5)  # 0.5s for smooth move
        goal.trajectory.points.append(end_point)

        self.client.send_goal(goal)
        self.current_joints = joint_positions
        rospy.loginfo_throttle(1.0, "[IK Solver] Sent trajectory goal to controller.")

if __name__ == "__main__":
    try:
        solver = RealTimeIKSolver()
        rospy.spin()
    except rospy.ROSInterruptException:
        pass
