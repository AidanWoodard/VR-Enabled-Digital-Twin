# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is the ROS side of a Kent State VR robotics project: a Unity VR client controls a physical **Sagittarius arm (sgr532 by NXROBO)**. **Current setup (2026-07): single machine** — Unity runs on the Windows host and ROS runs in WSL2 on the same box; Unity's ROSConnection targets `127.0.0.1:10000` through WSL2 mirrored networking (verified working end-to-end on 2026-07-14). The older two-machine peer-to-peer Ethernet setup (Unity host `192.168.1.50` → ROS machine `192.168.1.100`) described in some docs is historical. The bridge is ROS-TCP-Connector/Endpoint on port `10000` either way. The Unity project lives at `D:\Aidan\REU2026\Samuel\Samuel\Sam's Robot Shop` (readable from WSL at `/mnt/d/...`).

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
| `dashboard_controller` | `unity_vr_control/launch/unity_vr_control.launch` | thin adapter: translates Unity's dashboard services into MUX commands on `/sgr532/bag_control`, mirrors `/sgr532/bag_status`; shares the MUX's slot set in `recordings/` |

`usb_cam.launch` is launched separately (via `camlaunch`) and is not part of `full_system.launch`; it starts 4 nodes: `cam1/usb_cam`, `cam1/image_republisher`, `cam2/usb_cam`, `cam2/image_republisher`.

## Key Custom Package: `unity_vr_control`

Located at `src/unity_vr_control/scripts/`. All scripts use Python 3 (`#!/usr/bin/env python3`).

**`light_ik_solver.py`** — The active IK solver. Deliberately avoids `MoveGroupCommander` to prevent C++ initialization race conditions/deadlocks on this machine. Uses the `/sgr532/compute_ik` service directly and sends trajectories via the `FollowJointTrajectory` action client. Joint names are hardcoded as `['joint1'...'joint6']` because dynamic MoveIt queries trigger hangs.

**`clean_ik_solver.py`** — A copy that does use `MoveGroupCommander` (kept for reference/testing). Not currently deployed.

**`unity_vr_goal_listener.py`** — Simpler variant using `move_group.go()` directly instead of the low-level action client. Uses `#!/usr/bin/env python` (Python 2 shebang — do not change without verifying runtime).

**`TeleopLogger.py`** — Records poses from `/sgr532/teach_pose` + gripper values to `teleop_poses.json` for teach-and-repeat.

**`teach_repeat_executor.py`** — Reads `teleop_poses.json` and executes poses in a loop via `MoveGroupCommander`.

**`arm_bag_recorder.py`** — MUX node multiplexing the arm's `FollowJointTrajectory` action server between live VR teleop (`/sgr532/ik_goal_cmd`) and `rosbag`-based playback. Driven by string commands on `/sgr532/bag_control` (`RECORD:N`, `PLAY:N`, `STOP`, `CLEAR:N`) — published by `dashboard_controller.py` (Unity's dashboard UI) or manually via `rostopic pub`. Publishes latched status on `/sgr532/bag_status` (`IDLE`/`RECORDING:N`/`PLAYING:N`/`PLAYING_EE:N`). Records `/sgr532/joint_states` + `/sgr532/gripper/command` + `/sgr532/vr_target_pose` to `~/ROS_Files/sagittarius_ws/recordings/slot_N.bag`. Recordings are finalized with SIGINT (so rosbag renames `.bag.active` → `.bag`), a `rospy.on_shutdown` handler SIGINTs any child rosbag on node shutdown, and playback falls back to a crash-orphaned `.bag.active` if no finalized `.bag` exists (formerly the SIGTERM bug that lost all MUX recordings — see `docs/RECORDING_PIPELINE_KNOWN_ISSUES.md`). Playback has two modes via the `~playback_mode` param (`joints` default, `ee` — set by `full_system_ee.launch`): joints mode replays recorded joint states; EE mode re-solves IK per recorded `vr_target_pose` (peeked via `rosbag play --immediate -u 5 -d 1`, since `-r 0` can miss the sparse first pose). In joints mode `_cmd_play()` pre-positions the arm to the bag's first joint frame (peeked via a throwaway `rosbag play -r 0` with `vr_target_pose`/`gripper` remapped to void topics so nothing leaks to `light_ik_solver` or the gripper during the peek, then driven there and confirmed via polling real `/sgr532/joint_states` within 0.05 rad/5s timeout) **before** starting real-speed playback — this prevents the arm from visibly lurching/chasing the trajectory for the first 1-2s.

**`dashboard_controller.py`** — Thin adapter between Unity's dashboard UI and the MUX. Exposes the same four services as always (`dashboard/record`, `dashboard/playback`, `dashboard/query_slots`, `dashboard/clear` — Unity's `CommandSlotDashboard.cs` is unchanged) but no longer spawns its own rosbag subprocesses: record/play/stop are forwarded as `RECORD:N`/`PLAY:N`/`STOP` on `/sgr532/bag_control` and confirmed by watching the latched `/sgr532/bag_status` (short condition-variable wait). Slots are therefore the MUX's `recordings/slot_N.bag` files, and VR-triggered playback now gets pre-positioning, teleop gating, and the joints/EE `playback_mode` distinction. Old bags in `~/dashboard_bags/` are orphaned legacy data and no longer appear in the UI. Because MUX `STOP` is global, per-slot stop/clear requests only send `STOP` if `bag_status` shows that slot active; otherwise they fail with a message. Playback-start returns optimistic success if the MUX hasn't flipped to `PLAYING[_EE]:N` within 2 s (pre-positioning can take ~10–20 s); record/stop waits are longer and definitive. Still publishes `/dashboard/playback_finished` (`std_msgs/Int32`, payload = slot index) exactly once per natural playback end — a `PLAYING[_EE]:N → IDLE` status transition counts as natural only if no dashboard command was sent in the last 1 s, so manual Stops never trigger it. `dashboard/clear` deletes both `slot_N.bag` and any `.bag.active` orphan (cleared slots are now missing files, not 0-byte files). If a `.bag.active` orphan is found after a crash, `rosbag reindex slot_N.bag.active` can recover data; check for orphaned recorder processes with `ps aux | grep "rosbag record"`. The node does **not** auto-respawn if killed — restart via `roslaunch unity_vr_control unity_vr_control.launch`.

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

**On WSL2**, `~/.bashrc` sets `export ROS_HOSTNAME=localhost` instead. WSL2 mirrored networking exposes a live campus DNS/mDNS interface alongside the direct Ethernet link; without this, ROS's hostname lookup can intermittently resolve to a link-local `fe80::` address and hang `roslaunch`/`roscore` at startup. Unity is unaffected — it connects via `ros_tcp_endpoint`'s own `0.0.0.0:10000` socket, not the ROS master URI.

**WSL2 mirrored networking blackholes TCP connects to never-bound localhost ports** (~130s in `SYN-SENT` instead of instant refusal), and `roscore` probes `127.0.0.1:11311` at startup to detect an existing master — untreated, every `roscore` launch hangs silently for ~2 minutes (a Ctrl+C aborts the probe and boot continues). The fix is a port warm-up (bind + release 11311) inside the `rosclaunch` shell function before `roscore` runs. **Do not use `ignoredPorts=11311` in `.wslconfig`** — tested on WSL 2.7.3, it does not stop the blackhole and makes the port unreachable over loopback even while bound, breaking the master entirely. See `docs/ExtraReference/CUSTOM_BASHRC_FUNCTIONS.md` for details and a verification snippet. The same probe hits `roslaunch` too: any launch started **without a master already running** (e.g. `fullsyslaunch` on its own) stalls the same way, so every launch wrapper needs the same port warm-up, not just `rosclaunch`.

**"TCP connected but no Unity↔ROS data" is a Unity-side problem, not WSL.** Verified 2026-07-14: the mirrored-networking boundary passes ROS-TCP payload fine in both directions (tested from Windows with `src/unity_vr_control/scripts/debug_fake_unity_client.py`). If the endpoint logs a connection but `rosnode info /unity_endpoint` shows no registrations, debug the Unity project, not this workspace — full diagnosis recipe in `docs/UNITY_SETUP.md` §7.

