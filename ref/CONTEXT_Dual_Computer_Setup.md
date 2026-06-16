==========================DUAL_COMPUTER_SETUP========================

This is a walk-through of setting up this VR digital-twin system on two computers, where one computer is the controller (with the VR host), and the other controls the robot and takes webcam feed via USBs. This is the end goal, a remotely operated digital twin system, where you don't need to be in the room (even though you probably are) with the robot that you're controlling.


=====Overview=====
[ Windows VR Host ] (IP: 192.168.1.50)
   └── Unity Engine Runtime
   └── ROS-TCP-Connector (Configured to target 192.168.1.100:10000, NOT a ROS script, a C# unity script)
   └── VR Headset Runtime (Oculus/OpenXR/SteamVR)
          ▲
          │  Physical LAN (Wired Cat6 / Dedicated Router)
          ▼
[ Linux Robot Host ] (IP: 192.168.1.100)
   └── ROS Master (roscore) & ROS-TCP-Endpoint (Bound to 0.0.0.0:10000)
   └── Sagittarius Arm Driver Nodes
   └── Dual usb_cam Driver Nodes (Bus-separated physical webcams)

=====Computer_One_Sys=====
- Steam VR
	Running headset and controllers
- Unity 6000.0.51f1
	Running simulation and live feed listeners (from webcams)

=====Computer_Two_Sys=====
- Webcam listener
	usb_cam.launch
- Robot driver
	sgr532_moveit_in_spark.launch
- IK Solver
	light_ik_solver.py
- ROSCore
	Base for ROS work

=====BS=====
The computer with the VR world does not need any ROS environments running or a WSL window open, just the Unity scene and SteamVR. By setting the ROC_TCP_Connector script in the Unity game to look for the other computer's IP, it will act like there is nothing between the computers at all.

As for the second computer that is connected to the robot physically, this needs to run the necessary ROS node scripts and launch files to connect the webcams and robot to the Unity scene. The only major alteration however is to export the ROS config IP such that it's looking for the connected computer:
	export ROS_IP=192.168.1.100
	export ROS_MASTER_URI=http://192.168.1.100:11311
(or whatever the IP's are)

This should be all you need! Physically:
	Computer1:
	- VR Headset
	Computer2:
	- 2 Webcams
	- Sagittarius
	Both:
	- Shared cat6 ethernet cable



