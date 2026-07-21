==========================ROS\_SETUP========================



These are all of the quick commands available on this local WSL. I created multiple quick-call functions in the \~/.bashrc file and they are available as follows. Run them in \~/ROS\_Files/sagittarius\_ws:



rosclaunch			(source dir, launch roscore)

endplaunch			(source dir, start tcp endpoint to Unity)

liklaunch			(source dir, launch light inverse kinematics solver)

cliklaunch			(source dir, launch clean inverse kinematics solver, NOT IN USE)

sgrlaunch			(source dir, start Sagittarius robot arm driver)

camlaunch			(source dir, launch dual-webcam setup)

fullsyslaunch (launch everything but dual-webcam feeds)

fullsyseelaunch (launch everything like usual, but use the IK-based playback instead of joint-angle like the above command)


===================================


