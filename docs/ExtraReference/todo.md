# TODO — EE-Playback Feature: Debug & Hardware Verification

## State (as of 2026-07-13)

Feature: new "end-effector playback" mode — `PLAY:N` replays the recorded `/sgr532/vr_target_pose`
through `/sgr532/compute_ik` inside the MUX, instead of raw joint_states, to compare playback
accuracy of servo-angle vs EE-pose data.

- Code lives **uncommitted** in worktree `.claude/worktrees/ee-playback` (branch `worktree-ee-playback`,
  based on master @ ba59968). NOT merged. Main checkout does NOT have the feature.
- Files changed (all in `src/unity_vr_control/`):
  - `scripts/arm_bag_recorder.py` — all node logic (see below)
  - `launch/unity_vr_control.launch` — new arg `playback_mode` (default `joints`) → private param on arm_bag_recorder
  - `launch/full_system.launch` — forwards `playback_mode` arg
  - `launch/full_system_ee.launch` — NEW thin wrapper: full_system.launch with `playback_mode:=ee`
- `light_ik_solver.py` untouched. No CMakeLists/package.xml changes, no catkin_make needed (scripts+launch only).
- Static checks passed: py_compile, XML valid, roslaunch-check on unity_vr_control.launch.
  Two subagent reviews done (plan audit clean; 3 bugs found and FIXED — post-STOP send_goal race,
  peek-burst leak into playback, peek window too narrow). **Zero hardware testing so far.**

## Architecture (what changed in arm_bag_recorder.py)

- `RECORD:N` now records 3 topics into `recordings/slot_N.bag`:
  `/sgr532/joint_states`, `/sgr532/gripper/command`, `/sgr532/vr_target_pose`
  → one demo is playable in BOTH modes (apples-to-apples comparison). Old bags lack the pose topic.
- New rosparam `~playback_mode`: `"joints"` (default, old behavior) | `"ee"`. Invalid → warn + joints.
- New state `PLAYING_EE` (alongside IDLE/RECORDING/PLAYING); helper `_is_playing()` gates
  `_ik_goal_callback` (live teleop blocked during both playback modes) and `_playback_timer_cb`.
  Status topic `/sgr532/bag_status` publishes `PLAYING_EE:N`.
- EE play path (`_start_play_ee`):
  1. `rospy.wait_for_service("/sgr532/compute_ik", timeout=5)` — lazy check; MUX __init__ deliberately
     does NOT wait (would serialize bring-up behind move_group; MUX must come up first as sole
     `/sgr532/ik_goal_cmd` subscriber). Abort PLAY with logwarn if unavailable.
  2. Pre-position: `_peek_initial_ee_pose` runs
     `rosbag play --immediate -u 5 -d 1 <bag> /sgr532/vr_target_pose:=/sgr532/playback/ee_peek
      /sgr532/joint_states:=/sgr532/playback/void_js /sgr532/gripper/command:=/sgr532/playback/void_grip`
     then `wait_for_message` on the PEEK topic (timeout 8 s) → `_solve_ik` once → reuse `_move_to_and_wait`.
     PEEK topic is separate from playback topic ON PURPOSE (bug fix: burst was queuing on the
     persistent subscriber and replaying into playback). `-d 1` because rosbag's default post-advertise
     delay is only 0.2 s.
  3. Real-speed: `rosbag play <bag> /sgr532/vr_target_pose:=/sgr532/playback/ee_pose
     /sgr532/joint_states:=/sgr532/playback/void_js` (gripper passthrough intentional).
  4. `_playback_ee_callback` (on `/sgr532/playback/ee_pose`): gate state==PLAYING_EE → deadband
     (same math/thresholds as light_ik_solver: 0.003 m / 0.02 quat-abs-sum) → `_solve_ik`
     (group `sagittarius_arm`, pose passed through with restamped header, timeout 0.05 s,
     no ik_link_name → tip `sgr532/link_grasping_frame`, error_code.val==1, position[:6]) →
     single-point FollowJointTrajectoryGoal, `time_from_start = 0.1 s` (parity with joints playback —
     deliberately NOT light_ik_solver's distance-scaled 0.2–0.6 s, so command source is the only
     comparison variable) → **re-check state under `_state_lock` before send_goal** (bug fix:
     STOP during the blocking IK call must never be followed by a goal).
- Joints play path unchanged except replayed `vr_target_pose` is now voided
  (`:=/sgr532/playback/void_pose`) so light_ik_solver never sees it.
- Constraints honored (project skills): NO `import rosbag` in MUX (subprocess only),
  NO MoveGroupCommander (deadlocks on this machine), joint names hardcoded joint1..6.

## TODO — hardware debug session (in order)

1. Enter worktree: `cd ~/ROS_Files/sagittarius_ws/.claude/worktrees/ee-playback`
   (or merge first — see hazard below). usbipd-attach arm from Windows PowerShell.
   NOTE: roslaunch resolves packages via the SOURCED workspace — the main checkout's devel points
   at main's src, so running the worktree code requires either merging to main src, or building/
   sourcing the worktree, or copying the 4 files over. Easiest for testing: copy the 4 changed
   files into the main checkout, test, then commit in the worktree.
2. Regression (joints mode): `roslaunch unity_vr_control full_system.launch`;
   `rosparam get /arm_bag_recorder/playback_mode` → `joints`. Record via
   `rostopic pub -1 /sgr532/bag_control std_msgs/String "data: 'RECORD:1'"`, teleop ~10 s, `STOP`.
   `rosbag info ~/ROS_Files/sagittarius_ws/recordings/slot_1.bag` must show all 3 topics.
   `PLAY:1` → pre-position then replay; `rostopic echo /sgr532/vr_target_pose` must stay SILENT during playback.
3. EE mode: `roslaunch unity_vr_control full_system_ee.launch`; `PLAY:1` →
   expect: no gripper twitch during ~1–2 s peek, single-IK pre-position, arm tracks recorded EE path,
   `/sgr532/bag_status` = `PLAYING_EE:1` → `IDLE` at bag end,
   `rostopic hz /sgr532/joint_states` stays at live driver rate (no replay pollution).
4. Gating/safety: during PLAYING_EE move the VR controller → arm must ignore it.
   `STOP` mid-playback → immediate IDLE + goals cancelled + NO further motion (this was the race bug — watch it).
5. Watch for suspected issues not yet observable statically:
   - IK solution jumps/elbow flips between consecutive poses (compute_ik has no seed from current
     joints here — light_ik_solver doesn't seed either, but confirm behavior matches live teleop).
   - Peek timing: if `wait_for_message` times out on a good bag, raise `-d`/timeout in
     `_peek_initial_ee_pose`.
   - Deadband too tight/loose for replayed stream rate (constants EE_POS_THRESHOLD/EE_ROT_THRESHOLD
     at top of arm_bag_recorder.py).
6. Accuracy comparison (the point of all this): same slot, run PLAY under both launch files,
   record `/sgr532/joint_states` externally during each, compare tracking error.
7. When satisfied: commit in worktree, then merge to master. (The earlier merge hazard —
   debug_checkpoint scaffolding in main's `full_system.launch`/CMakeLists — was removed 2026-07-15;
   the startup-hang diagnosis it served is concluded.)

## Known/accepted behaviors

- EE-playing an old bag (no vr_target_pose): logwarn, ~8 s peek stall, then "plays" with arm
  stationary (gripper still moves). Record fresh bags.
- Unity needs NO changes: same RECORD/PLAY/STOP/CLEAR strings on /sgr532/bag_control; mode is
  picked purely by which launch file is started.
- Plan file with full detail: ~/.claude/plans/create-a-plan-for-cryptic-tide.md ; memory note:
  ~/.claude/projects/-home-xrlab23-ROS-Files-sagittarius-ws/memory/ee_playback_feature.md
