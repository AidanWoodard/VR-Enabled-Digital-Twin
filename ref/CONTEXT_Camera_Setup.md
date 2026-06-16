==========================CAM_SETUP========================

This is a brief summary of how to setup and run the webcams used in this project for live visuals on the robot. This includes how to plug them in and where as well as how to run the ROS nodes for these inputs (see README, use AI).


=====BEFORE_ANYTHING=====
In sagittarius_ws directory:
	source ~/../../opt/ros/noetic/setup.bash && roscore

Each of the following steps should be done in their own WSL window, including the above. They are active programs, so keep them alive all at once.

=====SHARING_PORTS=====
1) In PowerShell (Windows, not WSL), run as admin and use usbipd commands in ROS setup:
	usbipd list
	usbipd bind -b <usb_id>
	usbipd attach -w -b <usb_id>
Do this for each camera that shows up, usually as a webcam.

=====SETUP_PROCEDURE=====
1) Allow Webcam Connections
- Once both cameras are plugged in (or however many), use chmod to allow access to those ports:
	sudo chmod 666 ~/../../dev/video<number>
Note: Replace <number> with whatever appears. Use this command to see what's available. Each camera is two 'video<num>' devices, choose the first one (usually video0 and video2 are what you want):
	ls ~/../../dev/video*

2) Run ROS
- Source the project as usual:
	source devel/setup.bash
- Run the command below to start the data listening:
	roslaunch sagittarius_object_color_detector usb_cam.launch

=====TESTING_OUTPUT=====
Now the cameras should be running with the above commands. The standard tripod webcam should have a red power light on when plugged in, and when it connects the left light should turn green.

To Test the output however, do the following.

1) Run RViz with:
	rosrun rviz rviz

2) Add a new topic:
	(click 'Add' in bottom left of RViz window)

3) Add the camera feed:
	(click 'By Topic' and find the 'usb_cam' topic. Click 'image')