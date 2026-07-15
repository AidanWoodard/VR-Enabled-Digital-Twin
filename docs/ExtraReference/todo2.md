# TODO 2 — Playback Joint-Data Capture + Comparison Tooling (NOT implemented)

## Status

**Planned only — zero code written (as of 2026-07-15).** Prerequisite before implementing:
confirm `full_system_ee.launch` works fully on hardware (see `todo.md` steps 1–5).
Full plan was designed and user-approved in Q&A during a 2026-07-15 session; decisions below are final.

## Goal

`todo.md` step 6 (the accuracy comparison) needs the arm's *actual* joint trajectory during
playback captured to disk, for both playback modes, so joint angles over time can be compared
and the inconsistencies of the EE/IK method quantified against joints-mode playback and the
original demo.

Key fact that makes this clean: during playback in **both** modes, the replayed bag's
`joint_states` are remapped to shadow/void topics, so `/sgr532/joint_states` carries **only
live hardware encoder data** — capturing it during playback gives a pure record of what the
arm actually did.

## Confirmed design decisions (asked & answered 2026-07-15)

1. **Auto-capture on every PLAY**, both modes — no opt-in flag, no manual step.
2. Captures go to a **new sibling folder of `recordings/`**: `~/ROS_Files/sagittarius_ws/playback_captures/`.
3. **Timestamped filenames**, never overwrite: `slot_{N}_{joints|ee}_{YYYYmmdd-HHMMSS}.bag`.
4. Capture the **real-speed replay only** — start after pre-positioning completes, so t=0
   aligns across runs.
5. Deliverables include an **analysis script with plots + metrics** (PNG + printed table),
   not just bags.

## Implementation spec

### 1. `src/unity_vr_control/scripts/arm_bag_recorder.py` — auto-capture

- New constant `CAPTURE_DIR = ~/ROS_Files/sagittarius_ws/playback_captures/`;
  `os.makedirs(..., exist_ok=True)` in `__init__` (same pattern as `RECORDINGS_DIR`).
- New `self._capture_proc = None` + two helpers:
  - `_start_capture(slot, mode)` — `subprocess.Popen(["rosbag", "record", "-O", path,
    "/sgr532/joint_states", "__name:=playback_capture"])`, then `rospy.sleep(1.0)` so the
    recorder is subscribed before motion starts. Disk I/O stays in a subprocess — the
    project constraint of NO `import rosbag` inside the MUX still applies.
  - `_stop_capture()` — **SIGINT** (`proc.send_signal(signal.SIGINT)`, same pattern as
    `dashboard_controller.py:90`), `wait(timeout=5)`, escalate to `kill()` + logwarn.
    SIGINT is mandatory: it is what makes rosbag rename `.bag.active` → `.bag`.
- Call sites:
  - `_start_capture(...)` in `_start_play_joints()` and `_start_play_ee()`, immediately
    **before** the `rosbag play` Popen (i.e., after pre-positioning → replay-only window).
  - `_stop_capture()` in `_cmd_stop()` (manual STOP) and `_playback_timer_cb()` (natural end).
  - Register a `rospy.on_shutdown` handler that SIGINTs `_capture_proc` (and `_proc` when
    state is RECORDING) so a node kill doesn't orphan `.bag.active` files.

### 2. Same file — fix the RECORD stop bug (BLOCKER for the whole comparison)

`_cmd_stop()` → `_stop_subprocess()` uses `terminate()` (SIGTERM) for all subprocesses,
including `rosbag record` — slot recordings are left as `.bag.active` and `PLAY:N` can't find
them (documented in CLAUDE.md and `docs/RECORDING_PIPELINE_KNOWN_ISSUES.md`). Without this
fix you can't even record the demo to compare. Minimal fix (~4 lines): in
`_stop_subprocess()`, send SIGINT when state is RECORDING (rosbag *play* doesn't care;
*record* requires it).

### 3. New offline script: `src/unity_vr_control/scripts/compare_playback.py`

Plain `python3` tool (NOT a ROS node, not in CMakeLists, run directly). Deps verified
installed in WSL: matplotlib 3.1.2, numpy 1.17.4, python3 rosbag API.

- CLI: `python3 compare_playback.py <slot>` auto-discovers `recordings/slot_N.bag`
  (reference demo) + the **latest** `slot_N_joints_*.bag` and `slot_N_ee_*.bag` in
  `playback_captures/`; optional flags to name specific files.
- Extraction: `/sgr532/joint_states` from each bag → per-joint arrays, mapping joint1..6 by
  the `name` field (never by index); time normalized so t=0 = first message of each series.
- Plot: 6 subplots (one per joint) overlaying reference / joints-playback / ee-playback,
  saved to `playback_captures/slot_N_compare_<timestamp>.png`.
- Metrics: resample reference onto each capture's timestamps (`np.interp` per joint) →
  print per-joint **RMSE** and **max |error|** (rad) per mode, plus an overall row.

### 4. `.gitignore`

Add `recordings/` and `playback_captures/` (recordings/ was never actually ignored).

## Workflow once implemented

```bash
fullsyslaunch                       # joints mode
# RECORD:1 → teleop → STOP  (slot_1.bag must finalize as .bag, proving fix #2)
# PLAY:1  → auto-writes playback_captures/slot_1_joints_<ts>.bag
fullsyseelaunch                     # EE mode (alias added to ~/.bashrc 2026-07-15)
# PLAY:1  → auto-writes playback_captures/slot_1_ee_<ts>.bag
python3 src/unity_vr_control/scripts/compare_playback.py 1   # PNG + error table
```

## Verification checklist (for the implementing session)

1. `python3 -m py_compile` on both scripts.
2. `RECORD:1` → `STOP` → `recordings/slot_1.bag` exists as `.bag`, NOT `.bag.active`.
3. `PLAY:1` (joints) → capture file appears only after pre-positioning; finalized `.bag` at
   bag end; `rosbag info` shows only `/sgr532/joint_states` at the live driver rate
   (no replay pollution — the shadow-topic remap guarantees this).
4. `STOP` mid-playback → capture still finalizes cleanly (SIGINT path).
5. Same under `full_system_ee.launch` → `slot_1_ee_<ts>.bag`.
6. `compare_playback.py 1` → PNG with 6 joint overlays + RMSE/max-error table.

## Notes / hazards

- Edits go to the **main checkout** (current test path for the EE feature). The
  `ee-playback` worktree is still the feature's commit home — commit these changes there
  together with the EE feature during the todo.md step-7 reconciliation.
- Original plan file from the planning session: `~/.claude/plans/luminous-spinning-pixel.md`.
