# System Architecture & Networking Project Context
**Target System:** NotebookLM Research & Context Injection
**Date:** June 2026

---

## 1. Core Software & Hardware Stack
The system architecture spans a high-level simulation/user interface engine and a low-level bare-metal robotics framework, split cleanly across a physical distributed network.

* **User Interface & Simulation:** Built in **Unity Engine** using native **C#**. It handles spatial tracking, OpenXR/VR headset runtime telemetry, user inputs, and canvas-level video rendering.
* **Hardware Control Layer:** Managed entirely via **ROS (Robot Operating System)** utilizing **Python** and **C++** for real-time node computation and driver tracking.
* **Target Physical Subsystems:**
    * **The Sagittarius Arm by NEXROBO:** A high-precision, multi-axis robotic manipulator driven by incoming joint transformations.
    * **Dual Microdia Webcams (0c45:636b):** A twin-camera array deployed for stereoscopic visual capture or real-time spatial monitoring.

---

## 2. Distributed Architecture & Serialization Boundary
To shift from a localized loopback environment (WSL2 virtualization) to a true physical distributed deployment, the architecture establishes a definitive "break" at the network layer.

### The Serialization Loop
Standard ROS publishing/listening protocols do *not* broadcast raw data over cross-platform physical wires natively. Instead, communication relies on a dual-component bridge:

```
[ WINDOWS VR HOST ] (Static IP: 192.168.1.50)
        │
        │ Native Unity Runtime / C# Socket Client
        │ Uses: ROS-TCP-Connector (Targeting 192.168.1.100:10000)
        │
        ▼ [Physical Peer-to-Peer Cat6 Ethernet Cable]
        ▲
        │ Native Ubuntu Linux Environment (or Single WSL2 Engine)
        │ Uses: ROS-TCP-Endpoint (Server Node Bound to 192.168.1.100:10000)
        │
[ LINUX ROBOT HOST ] (Static IP: 192.168.1.100)
```

1.  **Control Telemetry Loop (Outbound):** VR controller transforms are captured by Unity $ightarrow$ serialized into bytes by the **C# ROS-TCP-Connector** package $ightarrow$ transmitted over the wire $ightarrow$ ingested by the **ROS-TCP-Endpoint** server node $ightarrow$ published locally to the ROS Master (`roscore`) as native ROS messages (`geometry_msgs/PoseStamped`) $ightarrow$ processed by the Sagittarius SDK for Inverse Kinematics (IK).
2.  **Visual Feedback Loop (Inbound):** Webcams capture raw frames on Linux $ightarrow$ compressed into lightweight payloads via `image_transport` plugins $ightarrow$ packaged by the **ROS-TCP-Endpoint** node $ightarrow$ sent across the wire over **Port 10000** $ightarrow$ captured by the Unity C# engine $ightarrow$ applied directly to UI canvas texture objects.

---

## 3. Physical Network Options & Implementation Roadmap

### Phase 1: Peer-to-Peer Dedicated Ethernet (Immediate Development Baseline)
* **Topology:** A single standard **Cat6 Ethernet cable** plugged directly from the RJ-45 port of the Windows VR Host into the RJ-45 port of the Linux Robot Host.
* **Hardware Mechanics:** Leverages **Auto-MDIX** (Automatic Medium-Dependent Interface Crossover) built into modern network interface cards (NICs). The hardware automatically detects the link and swaps internal Transmit ($TX$) and Receive ($RX$) pins dynamically, eliminating the need for old crossover cables.
* **Static IP Routing Setup:** Because an isolated cable lack a DHCP server ("traffic cop"), static addresses must be mapped manually to open the network socket:
    * **Windows VR Host:** IP `192.168.1.50` | Subnet `255.255.255.0` | Gateway `Blank`
    * **Linux Robot Host:** IP `192.168.1.100` | Subnet `255.255.255.0` | Gateway `Blank`
* **Environment Mapping:** Before launching nodes, the Linux environment must anchor its lookup table to the physical interface card:
    ```bash
    export ROS_IP=192.168.1.100
    export ROS_MASTER_URI=http://192.168.1.100:11311
    ```
* **Engineering Merits:** Complete removal of hypervisor packet drops; absolute isolation adhering to repository security specifications; zero wireless packet jitter or latency spikes.

### Phase 2: Local Subnet Migration (Wireless Target)
* **Topology:** Dedicated local Wi-Fi 6 or Wi-Fi 6E hardware router positioned inside the lab space. 
* **Architecture:** The Linux Robot Host maintains a hardwired Cat6 line into a physical LAN port on the router. The Windows VR Host communicates over an isolated $5\text{ GHz}$ or $6\text{ GHz}$ wireless channel.
* **Payload Modification:** Due to bandwidth constraints over the airwaves, uncompressed raw video frames (`sensor_msgs/Image`) must be explicitly downsampled and converted using JPEG algorithms (via `image_transport_plugins`) at a target optimization metric of **80% quality**. Texture updates on the Unity canvas are intentionally throttled to isolate frame-rate latency away from the primary OpenXR headset positional rendering loop.

### Avoided Track: Enterprise Campus Infrastructure
Relying directly on university Wi-Fi or wall jacks routes data into central campus switches enforcing **AP Isolation (Access Point / Client Isolation)**. This security metric intentionally drops peer-to-peer TCP communication between separate client machines to prevent scanning attacks, meaning the Unity C# client will be blocked from reaching the ROS endpoint out of the box.

---

## 4. Hardware Driver Sequencing & Kernel Mitigations
When launching the twin-camera pipeline on the Robot Host, identical hardware footprints (`VID:PID 0c45:636b`) cause kernel-level race conditions if spun up simultaneously. The system addresses this via a strict, deterministic launch script sequencing protocol:

1.  **Core Initialization:** Instantiation of `roscore` and the execution of the `ROS-TCP-Endpoint` script bound to the physical interface IP.
2.  **Primary Camera Boot:** Initialization of the device driver node targeting the primary physical USB controller bus (e.g., Physical Bus 2).
3.  **Staggered Hardware Delay:** Execution of a mandatory **4-second software delay block**. This allows the primary driver to fully initialize kernel handles and claim its endpoint hardware flags. *(Note: To guard against CPU throttling, a polling health-check script tracking the live publication of `/cam1/usb_cam/image_raw` is preferred over standard time blocks).*
4.  **Secondary Camera Boot:** Initialization of the second driver node targeting a separate, independent physical host controller bus (e.g., Physical Bus 3) on the IO backplane. This explicit bus splitting ensures max USB controller bandwidth and bypasses endpoint routing collisions.
5.  **Device Node Persistence:** All launch paths target explicit symbolic links in `/dev/v4l/by-path/` instead of fluctuating `/dev/videoX` indices, guaranteeing that left and right optical frames do not cross-invert during system reboots.

---

## 5. Repository Integrity & Asset Policies
To ensure rapid history calculation and prevent accidental security leaks under version control, the active workspaces abide by a strict Git configuration:

* **Asset Management (Extract and Exclude):** Large 3D spatial environments or asset packages are managed via a custom `.gitignore` layout using localized wildcards. Necessary operational assets are isolated as independent "Original Prefabs" inside a verified tracking folder, while structural package definitions are preserved through Unity's standard `manifest.json` file for automation.
* **Network Security Parameter Boundary:** Hardcoded local IP profiles, public-facing network declarations (`0.0.0.0`), and script edits designed to drop firewalls are blocked from commits. Configuration routing is handled entirely at the system level through localized shell environments (`.bashrc`) or system hypervisor configuration frameworks (`.wslconfig`).