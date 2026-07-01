# Camera Framerate — Status After Session 2

## What Was Fixed This Session

### Root cause confirmed and patched
`usb_cam_node` resets the V4L2 control `exposure_dynamic_framerate` (0x009a0903) **to 1
(enabled) every time it opens the device**, causing the camera firmware to drop from 30fps
to 15fps based on lighting. The correct fix is to apply `exposure_dynamic_framerate=0`
**after** the node has opened the device, not before.

### Changes made

| File | Change |
|------|--------|
| `~/.bashrc setCamSettings` | Added `exposure_dynamic_framerate=0` (pre-launch; doesn't hurt even though usb_cam resets it) |
| `launch/usb_cam.launch` cam1 | Added launch-prefix: starts node in background, sleeps 3s, reapplies `exposure_dynamic_framerate=0` while node runs |
| `launch/usb_cam.launch` cam2 | Replaced hardcoded port paths with `$(arg video_dev1)`/`$(arg video_dev2)`; same background+reapply pattern |
| `cam_bridge_receiver.py` | Auto-detects Windows gateway IP; added startup loginfo |
| `~/.bashrc camlaunch` | Bridge-mode branch when no usbipd cameras found |
| `launch/cam_bridge_receiver.launch` | New file for bridge receiver |

### Verified results (90-second sustained test)
- **cam2: stable 30.0 fps throughout** — confirmed fixed
- **cam1: starts at 30fps, drops to ~26-27fps within 10s, stabilizes there** — improved from 15fps crash but not fully resolved

## Remaining Issue: cam1 USB bandwidth cap

cam1 stabilizes at ~26-27fps (instead of 30fps) when both cameras stream simultaneously.
This is the vhci_hcd single-TCP-socket scheduler favoring cam2's port over cam1's port.
`exposure_dynamic_framerate=0` prevents the discrete 15fps drop but can't fix the transport
scheduling.

**Observed pattern:**
- Tested alone (sequential OpenCV): cam1 gets 30fps
- Both cameras simultaneous (ROS): cam2 = 30fps, cam1 = 26-27fps
- Port assignment changes each usbipd attach cycle; the "slow" behavior follows a specific
  physical camera, not a fixed port number

**Options if 27fps is unacceptable for cam1:**
1. Try attaching the cameras in reverse order (cam2 first, cam1 second) — the later-attached
   device may get the "higher" port which seems favored
2. Use a dedicated USB PCIe card for one camera so they're on separate host controllers
3. Revisit cam_bridge.py on Windows (Windows DirectShow captures both at 30fps without
   vhci_hcd sharing); was scrapped due to troubleshooting friction but functionally correct

## cam_bridge.py (Windows-side capture) — still available

Files are ready and working; only scrapped due to testing difficulty:
- `src/.../scripts/cam_bridge.py` — run on Windows (cameras must NOT be usbipd-attached)
- `src/.../nodes/cam_bridge_receiver.py` — run in WSL
- `camlaunch` auto-detects zero-camera case and prints bridge-mode instructions

To test: detach cameras from usbipd in PowerShell, run `python cam_bridge.py` on Windows,
then `camlaunch` in WSL (will auto-start cam_bridge_receiver).
