# Project Documentation: Distributed Physical AI Architecture
## Unity VR Client & Sagittarius Arm ROS Integration

---

## 1. Executive Project Summary
This project details the architecture for a distributed physical AI and robotics manipulation system. It integrates a **Unity VR Client** (serving as a remote operator dashboard and state orchestrator) with a **ROS 1 (Noetic) Backend** running on Ubuntu to control a physical **Sagittarius robotic arm**. 

The current phase focuses on transitioning the system into an efficient, robust, multi-slot motion recording and playback engine suitable for teleoperation and trajectory logging.

---

## 2. Workspace Hygiene & Deployment Environment
To maintain technical health and prevent development environment contamination, the project enforces strict version control and compilation boundaries:

* **Repository Scope:** The remote Git repository tracks *only* the `src/` directory. 
* **Tracked Assets:** System networking infrastructure (`ROS-TCP-Endpoint`, `unity_robotics_demo`), vendor drivers (`sdk_sagittarius_arm`, `sagittarius_sdk`), and custom execution logic (`unity_vr_control`).
* **Strict Exclusions (`.gitignore`):** Local bootstrap/deployment scripts (`onekey.sh`), catkin build artifacts (`build/`, `devel/`), and heavy local runtime binaries are strictly untracked.
* **Compilation Rule:** The `catkin_make` build system must always be executed from the workspace root (exactly one directory up from `src/`) to ensure proper package mapping without leaking artifacts into version control.

---

## 3. Core Architectural Principles & Refactors

### A. The Orchestrator Pattern (Unity De-scoping)
* **Legacy Behavior:** Unity functioned as a continuous data firehose, constantly streaming positions across the network, creating high bandwidth overhead and synchronization drift.
* **Refactored State:** Unity is stripped down to an **Orchestrator and State Dispatcher**. It does not handle filesystem I/O or raw data serialization. It remains silent until specific UI toggles are triggered, sending low-frequency command signals (`START_RECORD`, `STOP_RECORD`, `PLAYBACK`) alongside a target `Slot_ID`.

### B. Isolated Multiprocessing (The ROS Recording Engine)
* **The GIL Bottleneck:** ROS 1 (`rospy`) is bound by Python's Global Interpreter Lock (GIL). Combining high-frequency network deserialization and blocking disk I/O within a single node introduces micro-stutters that degrade physical hardware control loops.
* **The Decoupled Solution:** Recording logic is entirely isolated into a standalone process: `interaction_recorder_node`. If this node experiences a filesystem error (e.g., disk full, file corruption), the crash domain is contained; the primary robot tracking and control node continues running unaffected.

### C. Feedback-Based Trajectory Logging (Reality vs. Intent)
* **The Vulnerability:** Recording the raw stream of commands coming out of Unity records "operator intent," which ignores network jitter, latency, and physical actuator saturation limits, resulting in jerky playback.
* **The Implementation:** The recording node intercepts the real-world **feedback loops** generated directly by the physical robot's drivers. It ignores open-loop commands and captures the true physical path executed by the hardware.

---

## 4. Middleware Data Logging Strategy (`.bag` vs. JSON)
To maximize throughput and prevent real-time serialization bottlenecks, the system uses native ROS `.bag` files streamed directly to disk in a pre-allocated directory: `~/<ws>/src/unity_vr_control/recordings/slot_[X].bag`.

### Target Data Types for Storage
Every recording slot captures exactly two native ROS topic streams:

1.  **`sensor_msgs/JointState` (Primary Target):**
    * Captures raw motor states: `name` (joint identifiers), `position` (angles in radians), `velocity` (speed profiles), and `effort` (torque/current).
    * *Architectural Benefit:* Storing raw joint space removes the need to calculate intensive Inverse Kinematics (IK) during replay, leading to deterministic and safe playback.
2.  **`tf2_msgs/TFMessage` (Contextual Target):**
    * Logs the 3D spatial transformations of the gripper frame relative to the robot base.
    * *Architectural Benefit:* Enables offline coordinate manipulation and virtual "ghost arm" mirroring in Unity without re-solving forward kinematics.

---

## 5. System State Machine Mapping

| Operator Action (Unity VR) | Network Event | ROS Backend State | File I/O Action |
| :--- | :--- | :--- | :--- |
| **Select Slot + Toggle Live** | Connects tracking stream | `unity_control_node` passes targets to `SGRCtrlAction` | None (Passive graph) |
| **Press "Record"** | Synchronous Service Call: `START_RECORD(Slot_X)` | `interaction_recorder_node` activates subscriber threads | Opens `slot_X.bag` for binary writing (Overwrites existing data) |
| **Press "Stop"** | Synchronous Service Call: `STOP_RECORD` | Recorder node drops subscriptions, returns to Standby | Closes file handle, flushes buffers safely to disk |
| **Press "Playback"** | Synchronous Service Call: `PLAY_BACK(Slot_X)` | TBD: Executes path via action server or virtual remapping | Reads `slot_X.bag` sequentially |

---

## 6. Deprecation & Legacy Code Audit
* **`color_classification_node`:** Audited and flagged as completely unsuitable for environment deployment due to an open-loop design. It used a fragile 2D linear regression shortcut (`k * pixel + b`) to guess 3D locations, featured bare Python `except:` blocks that masked runtime faults, and introduced blocking patterns via `rospy.wait_for_message`.
* **Status:** Stripped of all mathematical and computer vision functionality. Its utility is strictly confined to serving as a local API payload reference for interacting with the `SGRCtrlAction` server.
* **Vision Overlay Scoping:** High-visibility marker tracking via OpenCV (HSV thresholding) for path-drawing has been entirely removed from the active development scope to reduce computational overhead and eliminate occlusion vulnerabilities.