# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is the ROS side of a Kent State VR robotics project: a Unity VR client controls a physical **Sagittarius arm (sgr532 by NXROBO)** over a peer-to-peer Ethernet network. Unity runs on a Windows VR host (IP `192.168.1.50`) and communicates to this Ubuntu/WSL2 ROS machine (IP `192.168.1.100`) over port `10000` using the ROS-TCP-Connector/Endpoint bridge.

**Software stack:** SteamVR + Unity 6000.0.51f1 (C#) → ROS-TCP-Endpoint → ROS Noetic (Python 3) → MoveIt → Sagittarius arm SDK.

## Building

Always build from the workspace root — never from inside `src/`:

```bash
cd ~/ROS_Files/sagittarius_ws
catkin_make
```

Only `src/` is tracked by git. `build/` and `devel/` are excluded via `.gitignore`.

## Launch Sequence (in order)

These shell aliases are defined in `~/.bashrc` and source `devel/setup.bash` automatically:

| Alias | What it does |
|---|---|
| `rosclaunch` | Start `roscore` (required first) |
| `sgrlaunch` | Start Sagittarius MoveIt driver (`sgr532_moveit_in_spark.launch`), auto-detects `/dev/ttyACM*` |
| `endplaunch` | Start ROS-TCP-Endpoint server (Unity bridge on port 10000) |
| `liklaunch` | Launch `light_ik_solver.py` — the active real-time IK solver |
| `camlaunch` | Launch dual webcam nodes (auto-detects `/dev/video*` ports) |
| `cliklaunch` | Launch `clean_ik_solver.py` (uses MoveGroupCommander; NOT currently in use) |

The arm serial port must first be shared from Windows PowerShell via `usbipd attach -w -b <port>`.

## Node Graph (`full_system.launch`)

Running `src/unity_vr_control/launch/full_system.launch` brings up 8 nodes (joint_state_publisher_gui and rviz are disabled by default and don't count):

| Node | Source | Role |
|---|---|---|
| `robot_state_publisher` | `sagittarius_descriptions/description.launch` | URDF + joint angles → TF tree |
| `joint_state_publisher` | `sgr532_moveit_in_spark.launch` | aggregates joint topic (real data overrides via hardware driver) |
| `sdk_sagittarius_arm` | `sdk_sagittarius_arm/launch/sdk_sagittarius_arm.launch` | C++ vendor driver; serial link to hardware, publishes real `/sgr532/joint_states`, executes servo commands |
| `move_group` | `sagittarius_moveit/launch/move_group.launch` | MoveIt planning node; exposes `/sgr532/compute_ik` and the `FollowJointTrajectory` action server |
| `unity_endpoint` | `ROS-TCP-Endpoint/launch/endpoint.launch` (`default_server_endpoint.py`) | generic TCP socket server on port 10000; binary-serializes/relays arbitrary ROS topics/services to/from Unity's `ROSConnection` client. No Sagittarius-specific logic. |
| `light_ik_solver` | `unity_vr_control/launch/unity_vr_control.launch` | subscribes `/sgr532/vr_target_pose`, calls `/sgr532/compute_ik` directly, publishes resulting goal to `/sgr532/ik_goal_cmd` (does not own an action client itself) |
| `arm_bag_recorder` | `unity_vr_control/launch/unity_vr_control.launch` | MUX: owns the actual `FollowJointTrajectory` action client, arbitrates between `light_ik_solver`'s live goals and rosbag playback, pre-positions arm before real-speed playback |
| `dashboard_controller` | `unity_vr_control/launch/unity_vr_control.launch` | separate record/playback services for Unity's dashboard UI; own slot set in `~/dashboard_bags/`, no pre-positioning |

`usb_cam.launch` is launched separately (via `camlaunch`) and is not part of `full_system.launch`; it starts 4 nodes: `cam1/usb_cam`, `cam1/image_republisher`, `cam2/usb_cam`, `cam2/image_republisher`.

## Key Custom Package: `unity_vr_control`

Located at `src/unity_vr_control/scripts/`. All scripts use Python 3 (`#!/usr/bin/env python3`).

**`light_ik_solver.py`** — The active IK solver. Deliberately avoids `MoveGroupCommander` to prevent C++ initialization race conditions/deadlocks on this machine. Uses the `/sgr532/compute_ik` service directly and sends trajectories via the `FollowJointTrajectory` action client. Joint names are hardcoded as `['joint1'...'joint6']` because dynamic MoveIt queries trigger hangs.

**`clean_ik_solver.py`** — A copy that does use `MoveGroupCommander` (kept for reference/testing). Not currently deployed.

**`unity_vr_goal_listener.py`** — Simpler variant using `move_group.go()` directly instead of the low-level action client. Uses `#!/usr/bin/env python` (Python 2 shebang — do not change without verifying runtime).

**`TeleopLogger.py`** — Records poses from `/sgr532/teach_pose` + gripper values to `teleop_poses.json` for teach-and-repeat.

**`teach_repeat_executor.py`** — Reads `teleop_poses.json` and executes poses in a loop via `MoveGroupCommander`.

**`arm_bag_recorder.py`** — MUX node multiplexing the arm's `FollowJointTrajectory` action server between live VR teleop (`/sgr532/ik_goal_cmd`) and `rosbag`-based playback. Driven by string commands on `/sgr532/bag_control` (`RECORD:N`, `PLAY:N`, `STOP`, `CLEAR:N`); records `/sgr532/joint_states` + `/sgr532/gripper/command` to `~/ROS_Files/sagittarius_ws/recordings/slot_N.bag`. `_cmd_play()` pre-positions the arm to the bag's first joint frame (peeked via a throwaway `rosbag play -r 0`, then driven there and confirmed via polling real `/sgr532/joint_states` within 0.05 rad/5s timeout) **before** starting real-speed playback — this prevents the arm from visibly lurching/chasing the trajectory for the first 1-2s.

**`dashboard_controller.py`** — Separate `dashboard/record`, `dashboard/playback`, `dashboard/query_slots`, `dashboard/clear` services for the Unity dashboard UI. Records `/sgr532/vr_target_pose` + gripper to `~/dashboard_bags/slot_N.bag` (a different directory/topic set than `arm_bag_recorder.py`'s slots — the two systems are not interchangeable). `handle_playback()` has no joint-state tracking or action client, so it does **not** get the pre-positioning fix above; playback can still lurch. Also publishes `/dashboard/playback_finished` (`std_msgs/Int32`, payload = slot index) exactly once when a `rosbag play` subprocess exits **on its own** — a daemon thread per playback calls `proc.wait()` then checks `playback_procs[slot]` is still that same `proc` object before publishing, so manual Stops (which pop the dict first) never trigger it. Lets Unity's `CommandSlotDashboard.cs` reset a slot's UI without polling.

## ROS Namespace

All arm topics live under `/sgr532/`:
- `/sgr532/vr_target_pose` — incoming `PoseStamped` from Unity VR
- `/sgr532/joint_states` — real hardware encoder values (not `/joint_states`)
- `/sgr532/sagittarius_arm_controller/follow_joint_trajectory` — trajectory action server
- `/sgr532/compute_ik` — IK service
- `/sgr532/gripper/command` — gripper Float64 command

## Dual Webcam Setup

Webcams use `/dev/video0` and `/dev/video2` (skipping index 1) — cam2 has a mandatory 4-second staggered launch delay to prevent kernel race conditions when two identical `VID:PID 0c45:636b` devices initialize simultaneously. Configured for 640×480 at 30fps, `pixel_format: mjpeg`. Each camera group also runs an `image_transport/republish` node (JPEG quality 80) that publishes `sensor_msgs/CompressedImage` on `/cam1/usb_cam/image_raw/compressed` and `/cam2/usb_cam/image_raw/compressed` — these are the topics Unity subscribes to over ROS-TCP-Endpoint.

**WSL fallback:** If `usbipd` cannot attach the cameras, run `src/sagittarius_perception/sagittarius_object_color_detector/scripts/cam_bridge.py` on the **Windows host** (not in WSL) — it streams both webcam frames over a socket on `127.0.0.1:8484`, and the WSL receiver picks them up via `nodes/cam_bridge_receiver.py`.

## MoveIt Quirk

`MoveGroupCommander` initialization can deadlock on this machine due to C++ `roscpp_initialize` conflicting with the existing rospy node. `light_ik_solver.py` avoids this entirely. If adding a new node that needs joint names, hardcode `['joint1', 'joint2', 'joint3', 'joint4', 'joint5', 'joint6']` rather than querying MoveIt at startup.

## Coordinate Frames

Unity uses a left-handed coordinate system (Y-up, Z-forward). ROS uses REP-103 right-handed (X-forward, Y-left, Z-up). The ROS-TCP-Connector handles this transform at the bridge layer; do not apply extra rotations inside ROS nodes.

## Network Configuration (Physical Ethernet, not WSL loopback)

When running on the dedicated Linux Robot Host (not WSL):
```bash
export ROS_IP=192.168.1.100
export ROS_MASTER_URI=http://192.168.1.100:11311
```

Campus Wi-Fi blocks peer-to-peer TCP (AP isolation) — use the direct Cat6 cable or a dedicated local router.

