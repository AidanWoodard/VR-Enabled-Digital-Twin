# Sam's Robot Shop — Project Overview

A Unity 6 VR teleoperation system for a Sagittarius SGR532 robotic arm. A VR user controls the arm's end-effector pose in real time over ROS via a TCP bridge. The Unity side runs on a Windows PC; the ROS side (Noetic) runs on a separate Linux machine (or WSL2 Ubuntu), connected via Ethernet.

This is the entry point for a new user picking up the project. It links out to the two setup guides for the details of each side.

## Hardware

- **Robot arm:** Sagittarius SGR532 by NXROBO ([vendor repo](https://github.com/NXROBO/sagittarius_ws))
- **VR headset:** HTC Vive
- **VR controllers:** Valve Index (Knuckles)

## Software stack

| Component | Version |
|---|---|
| Unity | 6000.0.51f1 |
| SteamVR | Active OpenXR runtime for the Vive + Index hardware |
| ROS | Noetic |
| Linux environment | Ubuntu 20.04 (native or WSL2) |

## Two-computer architecture

The system is split across two machines connected over Ethernet:

- **Windows VR host** — runs Unity and SteamVR. No ROS or WSL environment is required here; Unity's ROS-TCP-Connector talks to the other machine over a plain TCP socket.
- **Linux ROS host** — runs `roscore`, the ROS-TCP-Endpoint bridge, the Sagittarius arm driver, the IK solver, and (optionally) the camera nodes.

Both machines need to be able to reach each other on the network, with the Linux host's IP configured on the Unity side (see `UNITY_SETUP.md`) and the ROS environment variables pointed at itself (see `ROS_SETUP.md`). Exact IP addresses depend on your local network setup — treat any specific addresses you see elsewhere in these docs as examples, not fixed values.

## Where to go next

- **[ROS_SETUP.md](ROS_SETUP.md)** — setting up and launching the ROS/Linux side (arm driver, TCP bridge, IK solver, camera, dashboard recorder).
- **[UNITY_SETUP.md](UNITY_SETUP.md)** — opening the Unity project, package/XR configuration, and connecting to ROS.

## Reference material

- `Docs/Media/` and `Docs/Reference Images/` — photos of the physical rig and setup screenshots.
- `REU2026/Samuel/Samuel/Sam's Robot Shop/Presentations and Documentation/ReuTeleoperationPoster.pdf` — background on the REU project's goals, for outside-audience context.
- `Docs/ref/` — older, informal setup notes from the previous student. Some of it is accurate ground-truth (referenced while writing these docs); some of it (the more polished, longer documents) describes designs that were never actually implemented. When in doubt, trust this README and its two companion docs, or the code itself, over `Docs/ref/`.
