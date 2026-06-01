#!/usr/bin/env python3



## BEGIN_SUB_TUTORIAL imports
##
## To use the Python MoveIt interfaces, we will import the `moveit_commander`_ namespace.
## This namespace provides us with a `MoveGroupCommander`_ class, a `PlanningSceneInterface`_ class,
## and a `RobotCommander`_ class. More on these below. We also import `rospy`_ and some messages that we will use:
##

# Python 2/3 compatibility imports
from __future__ import print_function
from turtle import position
from six.moves import input

import sys
import copy
import rospy
import moveit_commander
import moveit_msgs.msg
import geometry_msgs.msg
import time

try:
    from math import pi, tau, dist, fabs, cos
except:  # For Python 2 compatibility
    from math import pi, fabs, cos, sqrt

    tau = 2.0 * pi

    def dist(p, q):
        return sqrt(sum((p_i - q_i) ** 2.0 for p_i, q_i in zip(p, q)))


from std_msgs.msg import String
from moveit_commander.conversions import pose_to_list

## END_SUB_TUTORIAL



# CHANGE PATH HERE
sys.path.insert(1, "/home/xrlabkent2/sagittarius_ws/src/sagittarius_arm_ros/sagittarius_moveit/WebServer/")# CHANGE PATH TO WEB SERVER FOLDER HERE
import WebServer
import threading # for multithreading



def all_close(goal, actual, tolerance):
    """
    Convenience method for testing if the values in two lists are within a tolerance of each other.
    For Pose and PoseStamped inputs, the angle between the two quaternions is compared (the angle
    between the identical orientations q and -q is calculated correctly).
    @param: goal       A list of floats, a Pose or a PoseStamped
    @param: actual     A list of floats, a Pose or a PoseStamped
    @param: tolerance  A float
    @returns: bool
    """
    if type(goal) is list:
        for index in range(len(goal)):
            if abs(actual[index] - goal[index]) > tolerance:
                return False

    elif type(goal) is geometry_msgs.msg.PoseStamped:
        return all_close(goal.pose, actual.pose, tolerance)

    elif type(goal) is geometry_msgs.msg.Pose:
        x0, y0, z0, qx0, qy0, qz0, qw0 = pose_to_list(actual)
        x1, y1, z1, qx1, qy1, qz1, qw1 = pose_to_list(goal)
        # Euclidean distance
        d = dist((x1, y1, z1), (x0, y0, z0))
        # phi = angle between orientations
        cos_phi_half = fabs(qx0 * qx1 + qy0 * qy1 + qz0 * qz1 + qw0 * qw1)
        return d <= tolerance and cos_phi_half >= cos(tolerance / 2.0)

    return True


class MoveGroupPythonInterfaceTutorial(object):
    """MoveGroupPythonInterfaceTutorial"""

    def __init__(self):
        super(MoveGroupPythonInterfaceTutorial, self).__init__()

        ## First initialize `moveit_commander`_ and a `rospy`_ node:
        moveit_commander.roscpp_initialize(sys.argv)
        rospy.init_node("move_group_python_interface_tutorial", anonymous=True)
        ## Instantiate a `RobotCommander`_ object. Provides information such as the robot's
        ## kinematic model and the robot's current joint states
        robot = moveit_commander.RobotCommander()
        ## Instantiate a `PlanningSceneInterface`_ object.  This provides a remote interface
        ## for getting, setting, and updating the robot's internal understanding of the
        ## surrounding world:
        scene = moveit_commander.PlanningSceneInterface()
        ## Instantiate a `MoveGroupCommander`_ object.  This object is an interface
        ## to a planning group (group of joints).  In this tutorial the group is the primary
        ## arm joints in the Sagittarius robot, so we set the group's name to "sagittarius_arm".
        ## If you are using a different robot, change this value to the name of your robot
        ## arm planning group.
        ## This interface can be used to plan and execute motions:
        #group_name = "panda_arm"
        group_name = "sagittarius_arm"
        move_group = moveit_commander.MoveGroupCommander(group_name)
        ## Create a `DisplayTrajectory`_ ROS publisher which is used to display
        ## trajectories in Rviz:
        display_trajectory_publisher = rospy.Publisher(
            "/move_group/display_planned_path",
            moveit_msgs.msg.DisplayTrajectory,
            queue_size=20,
        )
    
        display_trajectory_publisher_gripper = rospy.Publisher(
            "/move_group_gripper/display_planned_path",
            moveit_msgs.msg.DisplayTrajectory,
            queue_size=20,
        )

        # We can get the name of the reference frame for this robot:
        planning_frame = move_group.get_planning_frame()
        print("============ Planning frame: %s" % planning_frame)

        # We can also print the name of the end-effector link for this group:
        eef_link = move_group.get_end_effector_link()
        print("============ End effector link: %s" % eef_link)

        # We can get a list of all the groups in the robot:
        group_names = robot.get_group_names()
        print("============ Available Planning Groups:", robot.get_group_names())

        # Sometimes for debugging it is useful to print the entire state of the
        # robot:
        print("============ Printing robot state")
        print(robot.get_current_state())
        print("")
        ## END_SUB_TUTORIAL

        # Misc variables
        self.box_name = ""
        self.robot = robot
        self.scene = scene
        self.move_group = move_group
        self.display_trajectory_publisher = display_trajectory_publisher
        self.planning_frame = planning_frame
        self.eef_link = eef_link
        self.group_names = group_names

    def go_to_joint_state(self,joint_goal):

        move_group = self.move_group
        move_group.go(joint_goal, wait=True)

        # Calling ``stop()`` ensures that there is no residual movement
        move_group.stop()

        ## END_SUB_TUTORIAL

        # For testing:
        current_joints = move_group.get_current_joint_values()
        return all_close(joint_goal, current_joints, 0.01)
        
        
    def go_to_joint_state_gripper(self,joint_goal_gripper, wait=False):
        move_group = moveit_commander.MoveGroupCommander("sagittarius_gripper")

        # The go command can be called with joint values, poses, or without any
        # parameters if you have already set the pose or joint target for the group
        # Start the movement without waiting
        move_group.go(joint_goal_gripper, wait=wait)
        # Wait for the movement to complete or for 3 seconds, whichever comes first
        if not wait:
            time.sleep(4)
        move_group.go(joint_goal_gripper, wait=False)
        # Calling ``stop()`` ensures that there is no residual movement
        move_group.stop()

        ## END_SUB_TUTORIAL

        # For testing:
        current_joints_gripper = move_group.get_current_joint_values()
        return all_close(joint_goal_gripper, current_joints_gripper, 0.01)

    def Pick_Candy(self):
        move_group = self.move_group
        joint_goal = move_group.get_current_joint_values()
        # [-0.5427973973702365, -1.2723450247038663, 0.2583087292951608, -0.5654866776461628, -2.045525883337354, 1.1658799403322122]
        #[-0.5602506898901798, -1.0122909661567112, 0.03665191429188092, -0.5078908123303498, -1.8291050560900572, 1.1623892818282235]
        joint_goal[0] = -0.5602506
        joint_goal[1] = -0.9
        joint_goal[2] = -0.07
        joint_goal[3] = -0.55
        joint_goal[4] = -1.7
        joint_goal[5] =  1.4
        return joint_goal
    # def Pick_Candy(self):
    #     move_group = self.move_group
    #     joint_goal = move_group.get_current_joint_values()
    #     joint_goal[0] = -1.5707
    #     joint_goal[1] = 0
    #     joint_goal[2] = -0.7854
    #     joint_goal[3] = 0
    #     joint_goal[4] = -0.7854
    #     joint_goal[5] = 0
    #     return joint_goal
    def Place_Candy(self):
        move_group = self.move_group
        joint_goal = move_group.get_current_joint_values()
        joint_goal[0] = -1.5707
        joint_goal[1] = 1.0472
        joint_goal[2] = 1.0472
        joint_goal[3] = 2.8973
        joint_goal[4] = -1.309
        joint_goal[5] = 0
        return joint_goal
    #def Place_Candy(self):
        #move_group = self.move_group
        #joint_goal = move_group.get_current_joint_values()
        #joint_goal[0] = -1.5707
        #joint_goal[1] = 1.0472
        #joint_goal[2] = 1.0472
        #joint_goal[3] = 2.8973
        #joint_goal[4] = -1.309
        #joint_goal[5] = 0
        #return joint_goal
    def Sleep_Position(self):
        move_group = self.move_group
        joint_goal = move_group.get_current_joint_values()
        joint_goal[0] = 0
        joint_goal[1] = 1.3963
        joint_goal[2] = -1.4661
        joint_goal[3] = 0
        joint_goal[4] = -0.4887
        joint_goal[5] = 0
        return joint_goal
    def Grab_Candy(self):
        move_group = moveit_commander.MoveGroupCommander("sagittarius_gripper")
        joint_goal_gripper = move_group.get_current_joint_values()
        joint_goal_gripper[0] = -0.031
        joint_goal_gripper[1] = -0.031
        return joint_goal_gripper
    def Release_Candy(self):
        move_group = moveit_commander.MoveGroupCommander("sagittarius_gripper")
        joint_goal_gripper = move_group.get_current_joint_values()
        joint_goal_gripper[0] = -0.01
        joint_goal_gripper[1] = -0.01

        return joint_goal_gripper

    
    def print_current_pose(self):
        # This is a function to print current pose of the sagittarius arm for debugging purposes only.
        move_group = self.move_group
        current_pose = self.move_group.get_current_pose().pose
        print("ATTENTION!!! Current pose is: ")
        print(current_pose)
        return current_pose
    
    def go_to_pose_goal(self):
        # Copy class variables to local variables to make the web tutorials more clear.
        # In practice, you should use the class variables directly unless you have a good
        # reason not to.
        move_group = self.move_group

        ## BEGIN_SUB_TUTORIAL plan_to_pose
        ##
        ## Planning to a Pose Goal
        ## ^^^^^^^^^^^^^^^^^^^^^^^
        ## We can plan a motion for this group to a desired pose for the
        ## end-effector:
        pose_goal = geometry_msgs.msg.Pose()
        pose_goal.orientation.w = 0.892
        pose_goal.position.x = 0.397
        pose_goal.position.y = 0.0
        pose_goal.position.z = 0.026

        move_group.set_pose_target(pose_goal)

        ## Now, we call the planner to compute the plan and execute it.
        # `go()` returns a boolean indicating whether the planning and execution was successful.
        success = move_group.go(wait=True)
        # Calling `stop()` ensures that there is no residual movement
        move_group.stop()
        # It is always good to clear your targets after planning with poses.
        # Note: there is no equivalent function for clear_joint_value_targets().
        move_group.clear_pose_targets()

        ## END_SUB_TUTORIAL

        # For testing:
        # Note that since this section of code will not be included in the tutorials
        # we use the class variable rather than the copied state variable
        current_pose = self.move_group.get_current_pose().pose
        return all_close(pose_goal, current_pose, 0.01)

    def plan_cartesian_path(self, scale=1):
        # Copy class variables to local variables to make the web tutorials more clear.
        # In practice, you should use the class variables directly unless you have a good
        # reason not to.
        move_group = self.move_group

        ## BEGIN_SUB_TUTORIAL plan_cartesian_path
        ##
        ## Cartesian Paths
        ## ^^^^^^^^^^^^^^^
        ## You can plan a Cartesian path directly by specifying a list of waypoints
        ## for the end-effector to go through. If executing  interactively in a
        ## Python shell, set scale = 1.0.
        ##
        waypoints = []

        wpose = move_group.get_current_pose().pose
        wpose.position.z += scale * 0.005  # First move up (z)
        # wpose.position.y += scale * 0.2  # and sideways (y)
        waypoints.append(copy.deepcopy(wpose))

        #wpose.position.x += scale * 0.1  # Second move forward/backwards in (x)
        #waypoints.append(copy.deepcopy(wpose))

        #wpose.position.y -= scale * 0.1  # Third move sideways (y)
        #waypoints.append(copy.deepcopy(wpose))

        # We want the Cartesian path to be interpolated at a resolution of 1 cm
        # which is why we will specify 0.01 as the eef_step in Cartesian
        # translation.  We will disable the jump threshold by setting it to 0.0,
        # ignoring the check for infeasible jumps in joint space, which is sufficient
        # for this tutorial.
        (plan, fraction) = move_group.compute_cartesian_path(
            waypoints, 0.01, 0.0  # waypoints to follow  # eef_step
        )  # jump_threshold

        # Note: We are just planning, not asking move_group to actually move the robot yet:
        return plan, fraction

        ## END_SUB_TUTORIAL

    def display_trajectory(self, plan):
        # Copy class variables to local variables to make the web tutorials more clear.
        # In practice, you should use the class variables directly unless you have a good
        # reason not to.
        robot = self.robot
        display_trajectory_publisher = self.display_trajectory_publisher

        ## BEGIN_SUB_TUTORIAL display_trajectory
        ##
        ## Displaying a Trajectory
        ## ^^^^^^^^^^^^^^^^^^^^^^^
        ## You can ask RViz to visualize a plan (aka trajectory) for you. But the
        ## group.plan() method does this automatically so this is not that useful
        ## here (it just displays the same trajectory again):
        ##
        ## A `DisplayTrajectory`_ msg has two primary fields, trajectory_start and trajectory.
        ## We populate the trajectory_start with our current robot state to copy over
        ## any AttachedCollisionObjects and add our plan to the trajectory.
        display_trajectory = moveit_msgs.msg.DisplayTrajectory()
        display_trajectory.trajectory_start = robot.get_current_state()
        display_trajectory.trajectory.append(plan)
        # Publish
        display_trajectory_publisher.publish(display_trajectory)

        ## END_SUB_TUTORIAL

    def execute_plan(self, plan):
        # Copy class variables to local variables to make the web tutorials more clear.
        # In practice, you should use the class variables directly unless you have a good
        # reason not to.
        move_group = self.move_group

        ## BEGIN_SUB_TUTORIAL execute_plan
        ##
        ## Executing a Plan
        ## ^^^^^^^^^^^^^^^^
        ## Use execute if you would like the robot to follow
        ## the plan that has already been computed:
        move_group.execute(plan, wait=True)

        ## **Note:** The robot's current joint state must be within some tolerance of the
        ## first waypoint in the `RobotTrajectory`_ or ``execute()`` will fail
        ## END_SUB_TUTORIAL

    def wait_for_state_update(
        self, box_is_known=False, box_is_attached=False, timeout=4
    ):
        # Copy class variables to local variables to make the web tutorials more clear.
        # In practice, you should use the class variables directly unless you have a good
        # reason not to.
        box_name = self.box_name
        scene = self.scene

        ## BEGIN_SUB_TUTORIAL wait_for_scene_update
        ##
        ## Ensuring Collision Updates Are Received
        ## ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        ## If the Python node was just created (https://github.com/ros/ros_comm/issues/176),
        ## or dies before actually publishing the scene update message, the message
        ## could get lost and the box will not appear. To ensure that the updates are
        ## made, we wait until we see the changes reflected in the
        ## ``get_attached_objects()`` and ``get_known_object_names()`` lists.
        ## For the purpose of this tutorial, we call this function after adding,
        ## removing, attaching or detaching an object in the planning scene. We then wait
        ## until the updates have been made or ``timeout`` seconds have passed.
        ## To avoid waiting for scene updates like this at all, initialize the
        ## planning scene interface with  ``synchronous = True``.
        start = rospy.get_time()
        seconds = rospy.get_time()
        while (seconds - start < timeout) and not rospy.is_shutdown():
            # Test if the box is in attached objects
            attached_objects = scene.get_attached_objects([box_name])
            is_attached = len(attached_objects.keys()) > 0

            # Test if the box is in the scene.
            # Note that attaching the box will remove it from known_objects
            is_known = box_name in scene.get_known_object_names()

            # Test if we are in the expected state
            if (box_is_attached == is_attached) and (box_is_known == is_known):
                return True

            # Sleep so that we give other threads time on the processor
            rospy.sleep(0.1)
            seconds = rospy.get_time()

        # If we exited the while loop without returning then we timed out
        return False
        ## END_SUB_TUTORIAL

    def add_box(self, timeout=4):
        # Copy class variables to local variables to make the web tutorials more clear.
        # In practice, you should use the class variables directly unless you have a good
        # reason not to.
        box_name = self.box_name
        scene = self.scene

        ## BEGIN_SUB_TUTORIAL add_box
        ##
        ## Adding Objects to the Planning Scene
        ## ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        ## First, we will create a box in the planning scene between the fingers:
        box_pose = geometry_msgs.msg.PoseStamped()
        #box_pose.header.frame_id = "panda_hand"
        #box_pose.header.frame_id = "sgr532/link_grasping_frame"
        #box_pose.header.frame_id = "sgr532/link_gripper_left"
        box_pose.header.frame_id = "world"
        box_pose.pose.orientation.w = 1.0
        box_pose.pose.position.z = 0.03
        box_pose.pose.position.x = 0.45
        box_pose.pose.position.y = 0
        box_name = "box"
        scene.add_box(box_name, box_pose, size=(0.01, 0.01, 0.01))

        ## END_SUB_TUTORIAL
        # Copy local variables back to class variables. In practice, you should use the class
        # variables directly unless you have a good reason not to.
        self.box_name = box_name
        return self.wait_for_state_update(box_is_known=True, timeout=timeout)

    def attach_box(self, timeout=4):
        # Copy class variables to local variables to make the web tutorials more clear.
        # In practice, you should use the class variables directly unless you have a good
        # reason not to.
        box_name = self.box_name
        robot = self.robot
        scene = self.scene
        eef_link = self.eef_link
        group_names = self.group_names

        ## BEGIN_SUB_TUTORIAL attach_object
        ##
        ## Attaching Objects to the Robot
        ## ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        ## Next, we will attach the box to the Sagittarius gripper. Manipulating objects requires the
        ## robot be able to touch them without the planning scene reporting the contact as a
        ## collision. By adding link names to the ``touch_links`` array, we are telling the
        ## planning scene to ignore collisions between those links and the box. For the Panda
        ## robot, we set ``grasping_group = 'hand'``. If you are using a different robot,
        ## you should change this value to the name of your end effector group name.
        #grasping_group = "panda_hand"
        grasping_group = "sagittarius_gripper"
        touch_links = robot.get_link_names(group=grasping_group)
        scene.attach_box(eef_link, box_name, touch_links=touch_links)
        ## END_SUB_TUTORIAL

        # We wait for the planning scene to update.
        return self.wait_for_state_update(
            box_is_attached=True, box_is_known=False, timeout=timeout
        )

    def detach_box(self, timeout=4):
        # Copy class variables to local variables to make the web tutorials more clear.
        # In practice, you should use the class variables directly unless you have a good
        # reason not to.
        box_name = self.box_name
        scene = self.scene
        eef_link = self.eef_link

        ## BEGIN_SUB_TUTORIAL detach_object
        ##
        ## Detaching Objects from the Robot
        ## ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        ## We can also detach and remove the object from the planning scene:
        scene.remove_attached_object(eef_link, name=box_name)
        ## END_SUB_TUTORIAL

        # We wait for the planning scene to update.
        return self.wait_for_state_update(
            box_is_known=True, box_is_attached=False, timeout=timeout
        )

    def remove_box(self, timeout=4):
        # Copy class variables to local variables to make the web tutorials more clear.
        # In practice, you should use the class variables directly unless you have a good
        # reason not to.
        box_name = self.box_name
        scene = self.scene

        ## BEGIN_SUB_TUTORIAL remove_object
        ##
        ## Removing Objects from the Planning Scene
        ## ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        ## We can remove the box from the world.
        scene.remove_world_object(box_name)

        ## **Note:** The object must be detached before we can remove it from the world
        ## END_SUB_TUTORIAL

        # We wait for the planning scene to update.
        return self.wait_for_state_update(
            box_is_attached=False, box_is_known=False, timeout=timeout
        )




local_loopType = 0


def handleQueue(controller):
    print("Handling Queue")
    counter = 0
    while True:
        counter += 1
        print("Counter: ", counter)
        # print("Length of Que: ", len(WebServer.cmdQue))
        if len(WebServer.cmdQue) <= 0:
            print("Task is None")
            break
        task = WebServer.cmdQue.popleft()
        print("Task: ", task)
        # for i in range(0, 6):
            # if f"joint{i}" in task:
        if "jointNumber" in task:
            jointNumber = task["jointNumber"]
            position = task["position"]
            # print("Joint: ", jointNumber, " Moving to position: ", position)
            if jointNumber != 7: 
                # get_joint_value_target
                currentJointTarget = controller.move_group.get_joint_value_target()
                currentJointTarget[jointNumber - 1] = position
                controller.go_to_joint_state(currentJointTarget)
            elif jointNumber == 7:
                # Joint 7 is the gripper. Move the gripper to the position.
                move_group = moveit_commander.MoveGroupCommander("sagittarius_gripper")
                joint_goal_gripper = move_group.get_current_joint_values()
                joint_goal_gripper[0] = position
                joint_goal_gripper[1] = position
                controller.go_to_joint_state_gripper(joint_goal_gripper)

        if "mode" in task:
            mode = task["mode"]
            print("Changing Mode to ", mode)
            global local_loopType
            local_loopType = mode




def main():
    # Set up the web server in a separate thread
    flaskThread = threading.Thread(target=WebServer.startFlask)
    flaskThread.setDaemon(True)
    flaskThread.start()
    # Start the handleQueue function in a separate thread
    # queueThread = threading.Thread(target=handleQueue, args=(MoveGroupPythonInterfaceTutorial(),))
    # queueThread.setDaemon(True)
    # queueThread.start()
    tutorial = MoveGroupPythonInterfaceTutorial()
    move_group = moveit_commander.MoveGroupCommander("sagittarius_gripper")
    ii = 0
    while not rospy.is_shutdown():
        if local_loopType == 0: # Idle
            #move_group = moveit_commander.MoveGroupCommander("sagittarius_arm")
            #position = move_group.get_current_joint_values()
            #print("Position: ", position)
            time.sleep(1)

        if local_loopType == 1: # Main loop
            #Starts in Sleep_Position
            if ii == 0:
                joint_goal = tutorial.Sleep_Position()
                joint_goal_gripper = tutorial.Release_Candy()
                tutorial.go_to_joint_state(joint_goal)
                tutorial.go_to_joint_state_gripper(joint_goal_gripper)
                ii = 1


            joint_goal = tutorial.Pick_Candy()
            joint_goal_gripper = tutorial.Grab_Candy()

            tutorial.go_to_joint_state(joint_goal)
            tutorial.go_to_joint_state_gripper(joint_goal_gripper)

            joint_gripper_current = move_group.get_current_joint_values()
            while joint_gripper_current[0] < joint_goal_gripper[0]+0.004:
                if local_loopType != 1:
                    break
                print("Current gripper position: ", joint_gripper_current[0], "is less than ", joint_goal_gripper[0]+0.004)
                joint_goal_gripper = tutorial.Release_Candy()
                tutorial.go_to_joint_state_gripper(joint_goal_gripper)
                joint_goal_gripper = tutorial.Grab_Candy()
                tutorial.go_to_joint_state_gripper(joint_goal_gripper)
                joint_gripper_current = move_group.get_current_joint_values()
                handleQueue(tutorial)
            
            #cartesian_plan, fraction = tutorial.plan_cartesian_path()
            #tutorial.execute_plan(cartesian_plan)
            joint_goal[1] += 0.1
            joint_goal[2] -= 0.1
            tutorial.go_to_joint_state(joint_goal)

            joint_goal = tutorial.Place_Candy()

            tutorial.go_to_joint_state(joint_goal)
            tutorial.go_to_joint_state_gripper(joint_goal_gripper)

            joint_gripper_current = move_group.get_current_joint_values()
            while joint_gripper_current[0] > joint_goal_gripper[0]+0.004:
                if local_loopType != 1:
                    break
                print("Current gripper position: ", joint_gripper_current[0], "is less than ", joint_goal_gripper[0]+0.004)
                joint_goal_gripper = tutorial.Grab_Candy()
                tutorial.go_to_joint_state_gripper(joint_goal_gripper)
                joint_gripper_current = move_group.get_current_joint_values()
                handleQueue(tutorial)

            joint_goal_gripper = tutorial.Release_Candy()
            tutorial.go_to_joint_state_gripper(joint_goal_gripper,wait=False)

        if local_loopType == 2:# Joint Control Loop
            print("Loop Type 2: Joint Control Loop")
            # Movemements handled in the handleQueue function

        if local_loopType == 3: # Exit Program
            print("Loop Type 3: Exit Program")
            break

        handleQueue(tutorial) # Handle the queue of commands from the web server, at the end of every loop.
        # with WebServer.mutex:
        #     local_loopType = WebServer.loopType

    # When finished shut down moveit_commander.
    moveit_commander.roscpp_shutdown()




if __name__ == "__main__":
    main()

## BEGIN_TUTORIAL
## .. _moveit_commander:
##    http://docs.ros.org/noetic/api/moveit_commander/html/namespacemoveit__commander.html
##
## .. _MoveGroupCommander:
##    http://docs.ros.org/noetic/api/moveit_commander/html/classmoveit__commander_1_1move__group_1_1MoveGroupCommander.html
##
## .. _RobotCommander:
##    http://docs.ros.org/noetic/api/moveit_commander/html/classmoveit__commander_1_1robot_1_1RobotCommander.html
##
## .. _PlanningSceneInterface:
##    http://docs.ros.org/noetic/api/moveit_commander/html/classmoveit__commander_1_1planning__scene__interface_1_1PlanningSceneInterface.html
##
## .. _DisplayTrajectory:
##    http://docs.ros.org/noetic/api/moveit_msgs/html/msg/DisplayTrajectory.html
##
## .. _RobotTrajectory:
##    http://docs.ros.org/noetic/api/moveit_msgs/html/msg/RobotTrajectory.html
##
## .. _rospy:
##    http://docs.ros.org/noetic/api/rospy/html/
## CALL_SUB_TUTORIAL imports
## CALL_SUB_TUTORIAL setup
## CALL_SUB_TUTORIAL basic_info
## CALL_SUB_TUTORIAL plan_to_joint_state
## CALL_SUB_TUTORIAL plan_to_pose
## CALL_SUB_TUTORIAL plan_cartesian_path
## CALL_SUB_TUTORIAL display_trajectory
## CALL_SUB_TUTORIAL execute_plan
## CALL_SUB_TUTORIAL add_box
## CALL_SUB_TUTORIAL wait_for_scene_update
## CALL_SUB_TUTORIAL attach_object
## CALL_SUB_TUTORIAL detach_object
## CALL_SUB_TUTORIAL remove_object
## END_TUTORIAL