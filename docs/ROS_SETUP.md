# ROS Setup

This covers the Linux side of the project: getting the Sagittarius arm driver, the Unity↔ROS TCP bridge, the IK solver, the camera feed, and the record/playback dashboard running.

**Workspace location:** The real, in-use workspace is `~/ROS_Files/sagittarius_ws/` on the Linux ROS machine. The `REU2026/OldROSFiles/sagittarius_ws/` folder in this repo is a **reference mirror only** — it's out of date and should not be treated as the source of truth. (See root `CLAUDE.md` for the same note.)

Everything below assumes you already have ROS Noetic installed and the workspace built (`catkin_make` from the workspace root, then `source devel/setup.bash`).

## 1. USB passthrough (WSL only)

If ROS is running under WSL2 rather than native Linux, USB devices (the robot arm, cameras) need to be shared into WSL first.

In an elevated **Windows PowerShell** (not WSL):
```
usbipd list
usbipd bind --busid <bus_id>
usbipd attach --wsl --busid <bus_id>
```

Then in WSL, find the device and grant access:
```
ls /dev/tty*        # robot arm — look for a new ttyUSB* or ttyACM*
sudo chmod 666 /dev/tty<your_device>

ls /dev/video*      # cameras
sudo chmod 666 /dev/video<number>
```

This has to be redone any time a device is unplugged and replugged. If `usbipd list` already shows a device as shared, you only need to re-`attach` and re-`chmod`, not re-`bind`.

## 2. Launch order

Each of these should run in its own terminal window and stay running. Source the workspace (`source devel/setup.bash`) in each one first.

1. **ROS core**
   ```
   roscore
   ```
2. **Unity TCP bridge**
   ```
   roslaunch ros_tcp_endpoint endpoint.launch
   ```
   Default bind is `0.0.0.0:10000`. You'll see connect/disconnect messages here whenever Unity enters/exits Play mode — useful for confirming the bridge is alive.
3. **Robot arm driver + MoveIt**
   ```
   roslaunch sagittarius_moveit sgr532_moveit_in_spark.launch
   ```
   If the arm isn't on `/dev/ttyACM0`, add `serialname:=/dev/tty<your_device>` to the command.
4. **IK solver**
   ```
   rosrun unity_vr_control light_ik_solver.py
   ```
   This converts the pose Unity publishes into joint targets for the arm. (Older notes also mention a `clean_ik_solver.py` with extra collision-avoidance safety checks — it wasn't found in the reference mirror at the time these docs were written, so confirm it still exists on the live machine before relying on it.)
5. **Camera feed** (optional)
   ```
   roslaunch sagittarius_object_color_detector usb_cam.launch
   ```

## 3. Networking

Both machines need to be on the same subnet and able to reach each other. On the Linux side, point ROS at itself:
```
export ROS_IP=<linux-host-ip>
export ROS_MASTER_URI=http://<linux-host-ip>:11311
```
On the Unity side, the ROS-TCP-Connector needs to be pointed at this same IP and port `10000` — see `UNITY_SETUP.md`.

## 4. Record/playback dashboard

The Unity dashboard (5 record/play/clear slots) talks to a ROS node, `dashboard_controller.py` (part of the `unity_vr_control` package), which wraps `rosbag record`/`rosbag play` as subprocesses per slot. Bags are stored at `~/dashboard_bags/slot_N.bag`.

Services exposed:

| Service | Purpose |
|---|---|
| `dashboard/record` | start/stop recording a slot |
| `dashboard/playback` | start/stop playing back a slot |
| `dashboard/query_slots` | whether each slot has data |
| `dashboard/clear` | truncate a slot's bag to empty |

Plus one topic (not a service): `dashboard/playback_finished` (`std_msgs/Int32`, 1-based slot id) — pushed the instant a `rosbag play` subprocess exits on its own, so Unity can update its UI without the user pressing Stop.

This is the actual, currently-running architecture. If you come across older design notes describing a different recorder (e.g. one that records raw joint states/transforms via custom `START_RECORD`/`STOP_RECORD` services) — that was a proposal that was never implemented; the code that exists is the rosbag-based dashboard described above.

## 5. Handy aliases

The previous student set up shell function aliases in `~/.bashrc` for the common launch commands above (run from `~/ROS_Files/sagittarius_ws`):

| Alias | Does |
|---|---|
| `rosclaunch` | source + `roscore` |
| `endplaunch` | source + TCP endpoint |
| `liklaunch` | source + light IK solver |
| `sgrlaunch` | source + arm driver |
| `camlaunch` | source + dual-webcam launch |
| `fullsyslaunch` | runs `liklaunch`, `endplaunch`, `sgrlaunch` together |

Check `~/.bashrc` on the live machine to confirm these are still defined before relying on them.
