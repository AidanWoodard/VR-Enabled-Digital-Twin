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

The ROS connection is the `ROSConnection` singleton. `SampleScene.unity` currently contains **two** ROSConnection GameObjects — `ROS Connection` (active) and `ROS Connection Ethernet` (inactive, a leftover from the two-machine setup) — plus the fallback `Assets/Resources/ROSConnectionPrefab.prefab` that `ROSConnection.GetOrCreateInstance()` instantiates only if no scene instance exists. The inactive duplicate should ideally be deleted: duplicate ROSConnection instances are a known way for `Subscribe()`/`RegisterPublisher()` calls to land on an instance that never connects (see §8).

That prefab defaults to `127.0.0.1:10000` (localhost). **This is the #1 reason teleop won't connect for a new setup** — you need to either:
- edit the prefab's Inspector fields (`m_RosIPAddress`, `m_RosPort`) directly, or
- use the **Robotics → ROS Settings** menu in the Unity Editor,

and point it at your Linux ROS machine's actual IP (matching `ROS_IP`/`ROS_MASTER_URI` set on the ROS side — see `ROS_SETUP.md`). Port `10000` matches the ROS-TCP-Endpoint default and shouldn't need to change unless the ROS side was reconfigured.

The ROS TCP endpoint (`roslaunch ros_tcp_endpoint endpoint.launch`) needs to already be running on the Linux side before/while you enter Play mode.

## 6. Further reference

- `Assets/readme.md` (inside the Unity project itself) — a solid existing technical writeup, "Robot Segment Position and Rotation Control System," with a diagram of the full VR→ROS→ArticulationBody control loop and the joint-name mapping table. Read this for how pose data flows once you're connected.
- `Presentations and Documentation/` (project root, sibling of `Assets/`) — has the REU poster and a few architecture screenshots (`ros_unity_bridge1-3.png`, `robotinunity1.png`) that are useful as a visual sanity check of what a working bridge looks like.
- Root `CLAUDE.md` — the fuller technical reference for ongoing development (controls, calibration flow, dashboard record/playback system, coordinate conventions, etc.) once you're past first-time setup.

## 7. Troubleshooting: "TCP is connected but no data flows either way"

Debugged 2026-07-14 on the single-machine setup (Unity on Windows, ROS in WSL2, connector → `127.0.0.1:10000`). Symptom: endpoint logs `Connection from 127.0.0.1`, Unity HUD shows connected, `ss` shows an ESTABLISHED connection — but the arm never moves and Unity never receives joint states or camera frames.

**Conclusion: this is a Unity-side issue.** The entire ROS/WSL/mirrored-networking path was proven healthy:

- `rosnode info /unity_endpoint` showed **zero topic registrations** — Unity's `__subscribe`/`__publish` syscommands never arrived.
- A fake connector client (`src/unity_vr_control/scripts/debug_fake_unity_client.py`) subscribed and streamed joint states instantly, **both** from inside WSL and from the Windows host over the exact `127.0.0.1:10000` path Unity uses. The WSL2 mirrored-networking boundary passes payload fine.
- `ss -ti 'sport = :10000'` byte counters showed Unity's connection sending ~8 bytes/s — keepalives only. Unity's sender thread was alive but **never sent a single registration**, so both directions die: ROS→Unity also requires Unity to first register its subscribers.

How to re-run this diagnosis (each step isolates one layer):

1. `rosnode info /unity_endpoint` — registrations present? If yes, the problem is elsewhere.
2. `python3 src/unity_vr_control/scripts/debug_fake_unity_client.py` in WSL — endpoint/ROS healthy?
3. Copy the same script to Windows and run it there — mirrored-networking boundary healthy?
4. `ss -ti 'sport = :10000'` twice a few seconds apart — is Unity sending anything beyond ~8 B/s keepalives?

If 1 shows nothing and 2–4 pass, stop touching WSL/ROS — the fix is in the Unity project. Unity-side suspects to check (all observed in the Editor log during this session):

- **Duplicate ROSConnection instances** in the scene (see §5) — `Subscribe()` calls can bind to a non-connected instance.
- **`[ROSPublishToggle]` / `[RobotBarrier]`** scripts gate publishing (see §8 controls) — but note these only block *publishing*, they don't explain missing *subscriber* registrations.
- **OpenXR failing to initialize** (`xrCreateInstance failed` in `%LOCALAPPDATA%\Unity\Editor\Editor.log`) — SteamVR not running/active runtime wrong; VR scripts may bail before registering anything.
- Unity's `Editor.log` is readable from WSL at `/mnt/c/Users/<user>/AppData/Local/Unity/Editor/Editor.log` — check whether `CameraSubscriber`/`JointStateSubscriber` `Start()` actually ran and whether any C# exception preceded the silence.

## 8. Quick controls reference

- **Calibration:** the controller's pose 10 seconds after Play is captured as the home reference frame — hold still during this window.
- **Toggle live publishing:** hold both triggers together for ~1 second.
- **Reset controller origin:** hold left B + right B together for ~1 second; re-homes the controller and sends the arm back to its home position.

See `CLAUDE.md` for the full detail on these and on the record/playback dashboard UI.
