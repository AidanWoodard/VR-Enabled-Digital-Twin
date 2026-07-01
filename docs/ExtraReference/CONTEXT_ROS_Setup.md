==========================ROS\_SETUP========================



This is a brief summary of how to setup and run ROS properly for this project. I'm assuming you already have the correct ROS files and have WSL setup with proper Ubuntu version (see README, use AI).



=====Project\_Tree=====

\~/sagittarius\_ws/		**# RUN 'devel/setup.bash' SOURCE COMMAND FROM HERE**

├── build/                      # Generated automatically by command: catkin\_make

├── devel/                      # Contains setup scripts and generated headers

│   └── setup.bash

└── src/                        # Your active source code repository

&#x20;   ├── CMakeLists.txt          # Top-level workspace build configuration

&#x20;   │

&#x20;   ├── ROS-TCP-Endpoint/       # The communication bridge to Unity

&#x20;   │   ├── CMakeLists.txt

&#x20;   │   ├── package.xml

&#x20;   │   ├── src/

&#x20;   │   │   └── ros\_tcp\_endpoint/

&#x20;   │   │       ├── default\_server\_endpoint.py

&#x20;   │   │       └── server.py

&#x20;   │   └── config/

&#x20;   │       └── params.yaml     # Port and IP settings for the network bridge

&#x20;   │

&#x20;   └── sgr532\_robot/           # The recovered hardware driver package

&#x20;       ├── CMakeLists.txt

&#x20;       ├── package.xml

&#x20;       ├── launch/

&#x20;       │   └── sgr532\_hardware.launch  # <-- Target file for updating /dev/ttyUSB0

&#x20;       ├── src/

&#x20;       │   └── sgr532\_serial\_node.py   # Processes topics and writes to serial

&#x20;       └── urdf/               # (Optional) 3D mesh and joint limits of the arm

&#x20;           └── sgr532.urdf



=====BEFORE\_ANYTHING=====

In sagittarius\_ws directory:

&#x09;**source \~/../../opt/ros/noetic/setup.bash \&\& roscore**



Each of the following steps should be done in their own WSL window, including the above. They are active programs, so keep them alive all at once.



=====SHORTCUT=====

**Note:** Steps 2\) through 5\) below (MoveIt/driver, Unity TCP endpoint, MUX, and the IK solver) can now be replaced by a single combined launch command:

&#x09;**roslaunch unity\_vr\_control full\_system.launch**

Add **serialname:=/dev/tty<your\_specific\_ending>** at the end if your port isn't ttyACM0. The manual step-by-step below is still useful for debugging individual pieces in their own separate terminal windows.



=====SETUP\_PROCEDURE=====

1\) Connecting USB to WSL

\- After plugging in robot via USB to computer, run WindowsPowershell as admin and type:

&#x09;**usbipd list**

\- Whatever USB bus id your plugged-in usb is, put that into:

&#x09;**usbipd bind --busid <bus\_id\_of\_USB>**

&#x09;**usbipd attach --wsl --busid <bus\_id\_of\_USB>**

\- Then, in WSL in the \~	directory:

&#x09;**cd \~/../../ \&\& ls /dev/tty\***

\- This will print out all connections, yours will end in USB or ACM (with a number usually). Finally:

&#x09;**sudo chmod 666 /dev/tty<your\_specific\_ending>**



Now you have access through WSL to a windows USB port!

Note: This must be done whenever you unplug the robot. If you type usbipd list in powershell and see that your port is already shared, then don't worry about re-binding the port. Just attach it to wsl and run the chmod command in wsl to finish.



2\) Running MoveIt

\- Source the directory first, make sure to always do this on startup:

&#x09;**source devel/setup.bash**

\- Run:

&#x09;**roslaunch sagittarius\_moveit sgr532\_moveit\_in\_spark.launch**



If your port is something other than ttyACM0, use **serialname:=/dev/tty<your\_specific\_ending>** at the end of the above command to use your specific serial. For example, if you accidentally unplug in the middle of a simulation, WSL might automatically send the next plug-in from ACM0 to ACM1 since the last port wasn't properly cleaned.



3\) Running connection to Unity

\- Source the directory as usual:

&#x09;**source devel/setup.bash**

\- Run:

&#x09;**roslaunch ros\_tcp\_endpoint endpoint.launch**

You should see messages when Unity is running and not running! This is the first connection from ROS to Unity.



4\) Running the MUX (arm\_bag\_recorder.py)

\- This node owns the only sanctioned connection to the arm's follow\_joint\_trajectory action server, and is the only subscriber on the /sgr532/ik\_goal\_cmd topic. It must be running before the IK solver in step 5\) is started, since light\_ik\_solver.py publishes a "move to home" goal to /sgr532/ik\_goal\_cmd on startup and needs a subscriber there to receive it. Source:

&#x09;**source devel/setup.bash**

\- Run:

&#x09;**rosrun unity\_vr\_control arm\_bag\_recorder.py**



5\) Running the Inverse Kinematics Solver

\- This will be what converts the coordinates outputted by Unity into usable robot path trajectories using a simple Inverse Kinematics solver (written in Python, uses ROS libraries). Source:

&#x09;**source devel/setup.bash**

\- Run using rosrun and .py, NOT as before:

&#x09;**rosrun unity\_vr\_control light\_ik\_solver.py**



**Warning:** Do NOT run clean\_ik\_solver.py. It is dead/unused code that has not been updated for the MUX architecture \- it still opens its own direct actionlib.SimpleActionClient to the follow\_joint\_trajectory action server, which will fight with the MUX (arm\_bag\_recorder.py) over the same action server if both are running. It also calls rospy.init\_node("light\_ik\_solver", ...) \- the exact same node name light\_ik\_solver.py uses \- so running both at once causes a node name collision. Only light\_ik\_solver.py is correct in the current setup.



**Note:** If red errors showing in the MoveIt window, change Robot Description and Fixed Frame in the GUI, not terminal. This isn't necessary actually, but if you want to start debugging and getting a display in RViz, these are mandatory:

&#x09;1) change /robot\_description to /sgr532/robot\_description

&#x09;2) change Fixed Frame from odom to sgr532/base\_link

