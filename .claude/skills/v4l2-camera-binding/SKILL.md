---
name: v4l2-camera-binding
description: Prevents USB video device kernel racing and stereoscopic channel inversion. Use when editing launch scripts or hardware driver definitions for dual webcams.
---
# V4L2 Hardware Mapping Policy

## Configuration Constraints
* **Index Volatility:** Standard Linux device paths (`/dev/video0`, `/dev/video1`) are completely unstable and change arbitrarily based on USB controller polling order at boot.
* **Symlink Mandate:** You must explicitly forbid using generic integer indices for the twin Microdia webcams. 
* **Hardware Anchoring:** Subagents must configure the camera launch configuration parameters using persistent physical path paths found under `/dev/v4l/by-path/`.
* **Initialization Safeguard:** Implement an explicit verification check in your driver scripts ensuring the designated left-eye hardware symlink exists before initializing the right-eye driver process.
