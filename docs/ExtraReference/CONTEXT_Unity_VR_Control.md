# Unity VR Project Context: Digital Twin & OpenXR Troubleshooting

## 1. Project Overview & Architecture
**Objective:** Establish a fully synchronized VR Control Dashboard and Digital Robot Twin environment within Unity.

**Architecture:**
* **Frontend:** Unity XR Interaction Toolkit (XRI) and the New Input System driving a spatial user interface (Operator Control Station).
* **Hardware Setup (Hybrid):** HTC Vive headset (for localized environment tracking) combined with Valve Index (Knuckles) controllers (for complex manual manipulations).
* **Backend:** ROS/ROS2 network bridge. Local UI states (hovers, pokes, scrolling) in the world-space canvas translate into command data published over ROS teleoperation topics to drive downstream hardware nodes, path-planning scripts, and embedded controllers.

## 2. Current Technical State & Blockers
* **Core Issue:** An accidental deletion of the HTC Vive headset interaction profile in Unity's OpenXR project settings severed the data stream between the editor and the hardware layer on startup.
* **Symptoms:**
    * Unity runs, but the headset remains stuck in the SteamVR "Waiting..." room.
    * The OpenXR driver handshake fails to initialize properly.
    * Valve Index controllers and HTC Vive HMD tracking nodes are relegated to the "Unsupported" and "Disconnected" folders in the Unity Input Debugger.
    * Error logged: `XRInputV1::OpenXR::HeadTrackingOpenXR` disconnection.
* **UI/EventSystem Bugs:** World-space canvas elements previously failed to register spatial interaction states. There is an active conflict between the XR Ray Interactor (laser pointer) and the physical XR Poke Interactor (finger-depth bounds) dictating button activation states. The discrete "Click" action signal remains unexecuted by the EventSystem framework.

## 3. Executed Troubleshooting & Solutions
To restore the OpenXR driver layer and map the hybrid hardware setup via XRI:

### A. Repairing the OpenXR Hardware Handshake
1. Closed Unity to unlock active registry files.
2. Restarted SteamVR, ensuring headset and Index controllers are fully tracked.
3. Verified SteamVR as the active OpenXR Runtime.
4. In Unity `Project Settings -> XR Plug-in Management (PC Standalone)`, toggled OpenXR off and on to rebuild the loader cache.

### B. Correcting Interaction Profiles
Re-initialized profiles to support the hybrid hardware setup:
* Removed corrupted profiles.
* Added exactly two interaction profiles in order: **Valve Index Controller Profile** and **HTC Vive Controller Profile**.

### C. Aligning XRI Default Input Maps
* Bypassed custom Control Scheme creation (which triggered the initial profile deletion loop).
* Used the pre-built `XRI Default Input Actions` asset.
* Assigned generic hardware paths (e.g., `<XRController>{LeftHand}/triggerPressed`) to actions, ensuring "Use in control scheme" boxes were unchecked to prevent filtering bugs.

### D. Rebuilding the Input Cache
* Deleted the `Library` folder in the OS file explorer to force Unity to cleanly rebuild all hardware, driver, and asset metadata caches upon reopening.

## 4. Immediate Next Steps (Next Development Session)
1. **Verify Driver Handshake:** Confirm the Valve Index controllers have transitioned out of the "Unsupported" bin in the Input Debugger upon Unity restart.
2. **Verify Tracking Space:** Ensure the `XR Origin` tracking period is set to "Before Render", tracking state is "Floor", and the Main Camera's Tracked Pose Driver is mapped correctly (`<XRHMD>/centerEyePosition`).
3. **Unblock UI Click Path:** Once hardware is recognized, verify that the `Click Action` and `Left Click Action` fields in the XR UI Input Module point to verified hardware bindings.
4. **Calibrate Poke Interactor:** Check the `Click UI On Down` parameters on the poke interactor to prevent scroll-rect locking and ensure clean UI state transmission to the ROS backend.
