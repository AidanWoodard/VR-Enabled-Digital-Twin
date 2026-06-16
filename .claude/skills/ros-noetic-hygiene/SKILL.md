---
name: ros-noetic-hygiene
description: Enforces ROS Noetic Python 3 architectural standards. Use when generating, modifying, or compiling ROS nodes, package.xml manifests, or CMakeLists.txt build files.
---
# ROS Noetic Hygiene & Compilation Standards

## Implementation Rules
* **Shebang Alignment:** Every Python node must begin with an explicit Python 3 path: `#!/usr/bin/env python3`.
* **Workspace Isolation:** Never permit execution of `catkin_make` inside a sub-folder. Always navigate to the root workspace directory before compiling.
* **Build Registration:** When adding new service (`.srv`) files, explicitly update `CMakeLists.txt` under the `add_service_files` macro and verify `generate_messages` is un-commented.
* **Thread Termination:** Wrap all persistent spin loops in a `try-except` block catching `rospy.ROSInterruptException` to allow graceful thread destruction on SIGINT.
