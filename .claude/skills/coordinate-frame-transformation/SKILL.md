---
name: coordinate-frame-transformation
description: Dictates left-to-right spatial coordinate system conversions. Use when writing transformation logic between Unity VR tracking spaces and ROS REP-103 frames.
---
# Unity to ROS Coordinate System Alignment

## Mathematical Transformations
* **Handedness Inversion:** Unity uses a Left-Handed System (Y-Up). ROS uses a Right-Handed System (Z-Up). Subagents must apply the following mapping for raw positional vectors:
  $$X_{ros} = Z_{unity}$$
  $$Y_{ros} = -X_{unity}$$
  $$Z_{ros} = Y_{unity}$$
* **Orientation Conversion:** When parsing tracking quaternions from the Valve Index controller, map the orientation coordinates as follows:
  $$x_{ros} = -z_{unity}$$
  $$y_{ros} = x_{unity}$$
  $$z_{ros} = -y_{unity}$$
  $$w_{ros} = w_{unity}$$
* **Enforcement:** Enforce this matrix processing step inside the MUX node immediately upon receiving a payload from `/unity/teleop_pose`.
