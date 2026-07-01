# Unity Setup

This covers the Windows/Unity side: opening the project, package/XR configuration, and connecting to ROS.

**Project location:** `REU2026/Samuel/Samuel/Sam's Robot Shop/`
**Unity version:** exactly `6000.0.51f1` — install this via Unity Hub before opening the project, or Hub will prompt to upgrade (avoid upgrading; the project isn't verified against newer 6.x versions).

## 1. First-clone package gotcha

`Packages/manifest.json` references the ROS-TCP-Connector Unity package via a **local file path**:
```
"com.unity.robotics.ros-tcp-connector": "file:ROS-TCP-Connector/com.unity.robotics.ros-tcp-connector"
```
That `ROS-TCP-Connector/` folder is gitignored in this project and is **not** included when you clone the repo — Package Manager will fail to resolve packages on first open without it.

Fix: copy (or symlink) the vendored copy at `REU2026/Misc/ROS-TCP-Connector/com.unity.robotics.ros-tcp-connector` into a `ROS-TCP-Connector/` folder sitting next to `Sam's Robot Shop/Packages/`, matching the relative path in `manifest.json`, before opening the project.

Other notable packages already declared in `manifest.json` (no action needed, Package Manager resolves these normally): XR Interaction Toolkit 3.0.8, Input System 1.14.0, OpenXR 1.14.3, XR Management 4.5.1, XR Hands 1.5.1, URDF-Importer (git tag v0.5.2), Universal Render Pipeline 17.0.4, and `com.coplaydev.unity-mcp` (Unity MCP server, git-sourced).

## 2. SteamVR

SteamVR must be running, with the Vive headset and Index controllers paired and tracked, **and set as the active OpenXR runtime**, before entering Play mode. Pairing controllers is done through the SteamVR client itself.

## 3. OpenXR settings check

Open `Assets/XR/Settings/OpenXR Package Settings.asset` (or Project Settings → XR Plug-in Management → OpenXR) and confirm, under Standalone:

- `ValveIndexControllerProfile` — **enabled**
- `HTCViveControllerProfile` — **enabled**
- `MockRuntime` — **must be disabled**. If this is ever accidentally enabled, it intercepts all OpenXR calls and blocks real hardware entirely — this has bitten the project before, so check it first if hardware seems unresponsive.

The headset itself doesn't need its own interaction profile; SteamVR exposes HMD tracking through the OpenXR view reference space automatically.

## 4. Opening the scene

There's only one scene in the project: `Assets/Scenes/SampleScene.unity`. Open it — this is the scene to Press Play on.

## 5. Connecting to ROS

The ROS connection is **not** a scene GameObject — it's the `ROSConnection` singleton, auto-instantiated at runtime from `Assets/Resources/ROSConnectionPrefab.prefab` the first time any script calls `ROSConnection.GetOrCreateInstance()`.

That prefab defaults to `127.0.0.1:10000` (localhost). **This is the #1 reason teleop won't connect for a new setup** — you need to either:
- edit the prefab's Inspector fields (`m_RosIPAddress`, `m_RosPort`) directly, or
- use the **Robotics → ROS Settings** menu in the Unity Editor,

and point it at your Linux ROS machine's actual IP (matching `ROS_IP`/`ROS_MASTER_URI` set on the ROS side — see `ROS_SETUP.md`). Port `10000` matches the ROS-TCP-Endpoint default and shouldn't need to change unless the ROS side was reconfigured.

The ROS TCP endpoint (`roslaunch ros_tcp_endpoint endpoint.launch`) needs to already be running on the Linux side before/while you enter Play mode.

## 6. Further reference

- `Assets/readme.md` (inside the Unity project itself) — a solid existing technical writeup, "Robot Segment Position and Rotation Control System," with a diagram of the full VR→ROS→ArticulationBody control loop and the joint-name mapping table. Read this for how pose data flows once you're connected.
- `Presentations and Documentation/` (project root, sibling of `Assets/`) — has the REU poster and a few architecture screenshots (`ros_unity_bridge1-3.png`, `robotinunity1.png`) that are useful as a visual sanity check of what a working bridge looks like.
- Root `CLAUDE.md` — the fuller technical reference for ongoing development (controls, calibration flow, dashboard record/playback system, coordinate conventions, etc.) once you're past first-time setup.

## 7. Quick controls reference

- **Calibration:** the controller's pose 10 seconds after Play is captured as the home reference frame — hold still during this window.
- **Toggle live publishing:** hold both triggers together for ~1 second.
- **Reset controller origin:** hold left B + right B together for ~1 second; re-homes the controller and sends the arm back to its home position.

See `CLAUDE.md` for the full detail on these and on the record/playback dashboard UI.
