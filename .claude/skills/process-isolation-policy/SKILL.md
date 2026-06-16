---
name: process-isolation-policy
description: Enforces absolute separation between real-time control loops and disk operations. Use when building or refactoring the MUX node or binary recording streams.
---
# Process Isolation & Fault Tolerance Policy

## Execution Rules
* **Memory Constraints:** The MUX node (`unity_control_node`) must remain entirely in-memory to prevent micro-stutters. Do not import `rosbag` inside this file.
* **I/O Offloading:** All serialization tasks targeting storage disk arrays must be offloaded exclusively to the `interaction_recorder_node`.
* **Inter-process Communication:** The MUX node interacts with the recording lifecycle solely using synchronous ROS Service proxies.
* **Failure Boundaries:** If the recorder engine hits an I/O block, disk-full exception, or file system lockup, it must fail silently to the rest of the ROS graph—ensuring the telemetry pipeline remains unblocked.
