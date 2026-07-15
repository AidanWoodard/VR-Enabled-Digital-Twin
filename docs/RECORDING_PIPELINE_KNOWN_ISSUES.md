# Recording Pipeline — Known Issues & Fix Handoff

**Date:** 2026-07-13
**Scope:** the two bag record/playback systems in `src/unity_vr_control/scripts/` —
`arm_bag_recorder.py` (the MUX) and `dashboard_controller.py` — plus their interaction
with `light_ik_solver.py`. Compiled from a full code audit + git-history trace.
Nothing here has been fixed yet unless marked otherwise.

---

## TL;DR — why "nothing is saved"

`rosbag record -O slot_N` writes to `slot_N.bag.active` for the entire recording and
only renames it to `slot_N.bag` (and writes the index) on a **clean SIGINT**.

- `dashboard_controller.py` handles this correctly (SIGINT stop + `.active`-aware
  readers) — fixed in commit `999b4ae` "Autosave .bag on Unity scene exit".
- `arm_bag_recorder.py` **never got that fix**: `_stop_subprocess()`
  (`arm_bag_recorder.py:82-89`) stops with `terminate()` (SIGTERM, forwarded as SIGTERM
  to the C++ recorder — bag never finalized) and escalates to `kill()` after only 2 s.
  Its readers (`_slot_path`, `:57-58`) only ever look for `slot_N.bag`, never
  `.bag.active`, so an unfinalized recording is invisible — the slot reports empty.
- The SIGTERM stop has been present since the file's first commit (`e367386`); no
  commit ever revisited it.
- The **ee-playback worktree** (`.claude/worktrees/ee-playback`) rewrote much of
  `arm_bag_recorder.py` but **kept `terminate()` and has zero `.active` handling** —
  the same bug must be fixed there too or it returns at merge.

**Current on-disk state (2026-07-13):** `recordings/` is empty (no `.bag`, no
`.active`, no log traces of any record attempt — the MUX recorder may simply never
have been triggered). `~/dashboard_bags/` has `slot_1..3.bag` all **0 bytes**, which
is exactly what `handle_clear()`'s truncate (`open(path,'wb')`) produces — i.e.
cleared slots, not failed writes.

**Recovery for orphans:** `rosbag reindex slot_N.bag.active`.
**Check for orphaned recorders:** `ps aux | grep "rosbag record"`.

---

## Who triggers what (architecture facts)

Two independent, non-interchangeable systems share the arm but never coordinate:

| | `arm_bag_recorder.py` (MUX) | `dashboard_controller.py` |
|---|---|---|
| Trigger | `std_msgs/String` on `/sgr532/bag_control` (`RECORD:N`/`PLAY:N`/`STOP`/`CLEAR:N`) — **manual `rostopic pub` only; no node or Unity UI publishes it** | ROS services `dashboard/record`/`playback`/`query_slots`/`clear` — **this is what Unity's `CommandSlotDashboard.cs` uses** |
| Records | `/sgr532/joint_states` + `/sgr532/gripper/command` | `/sgr532/vr_target_pose` + `/sgr532/gripper/command` |
| Storage | `~/ROS_Files/sagittarius_ws/recordings/slot_N.bag` | `~/dashboard_bags/slot_N.bag` |
| Playback | Remapped joint replay through its own action client, with pre-positioning | Raw `rosbag play` of `vr_target_pose` — **no gating, no pre-positioning** |

---

## Findings — ranked

Severity tags: 🔴 critical · 🟠 high · 🟡 medium · ⚪ low.
"[both]" = present in master **and** the ee-playback worktree copy.

### Cross-system

1. 🔴 **Dashboard playback physically drives the arm, ungated.**
   `dashboard_controller.py:121` replays `/sgr532/vr_target_pose`;
   `light_ik_solver.py:133-187` consumes it as live VR input and publishes IK goals;
   the MUX (`arm_bag_recorder.py:231`) only drops IK goals when **its own** state is
   `PLAYING` — in normal `IDLE` it forwards every replayed pose to the hardware.
   The arm snaps from its current pose to the first recorded pose at full IK speed;
   replayed gripper commands hit hardware too.
   *Fix:* route dashboard playback through the MUX (`PLAY:N` on `/sgr532/bag_control`)
   or add an explicit arm-live gate before replayed poses reach the solver.

2. 🟠 **MUX `RECORDING` + dashboard playback = unintended motion gets recorded.**
   `_ik_goal_callback` only early-returns in `PLAYING` (`arm_bag_recorder.py:231-235`),
   so during a MUX recording, dashboard-replayed poses still drive the arm and are
   captured into the joint bag.
   *Fix:* shared "arm busy" interlock — dashboard refuses to play unless
   `/sgr532/bag_status` is `IDLE`, and vice versa.

3. 🟠 **`light_ik_solver` cannot reject replayed/stale poses.**
   `pose_callback` (`light_ik_solver.py:133-189`) filters only on spatial deltas,
   never on `header.stamp`.
   *Fix:* drop poses older than ~0.2 s.

### `arm_bag_recorder.py` (MUX) — beyond the SIGTERM root cause

4. 🟠 **No `rospy.on_shutdown` handler → orphaned rosbag children.** [both]
   `__main__` (`:271-276`) just spins. Ctrl+C on roslaunch mid-record orphans the
   `rosbag` wrapper + C++ `record` grandchild (keeps writing `.bag.active` forever);
   an orphaned `rosbag play` keeps driving the arm after the MUX dies.
   *Fix:* `rospy.on_shutdown(self._stop_subprocess)` (with SIGINT per the root-cause
   fix), mirroring `dashboard_controller._shutdown_handler`.

5. 🟠 **TOCTOU race: stale goal sent after STOP.** [both, joints path]
   `_playback_js_callback` (`:237-255`) checks `PLAYING` under `_state_lock` but calls
   `send_goal` **after releasing it** — a STOP can interleave and the arm moves after
   the user aborted. The worktree fixed exactly this for its new EE callback
   (`[wt]:431-436`) but left the joints callback unguarded in both files.
   *Fix:* re-check state under the lock immediately before `send_goal`.

6. 🟠 **Pre-positioning holds `_state_lock` for up to ~10 s; STOP can't interrupt.** [both]
   `_control_callback` (`:145`) holds the lock across `_cmd_play` → peek (≤3 s + 2 s)
   → `_move_to_and_wait` (≤5 s); STOP on the same single-threaded subscriber is
   serialized behind it anyway. Worse in the worktree EE path (+5 s `wait_for_service`,
   +8 s EE peek).
   *Fix:* run playback startup on a worker thread with an abort flag, or release the
   lock during the peek/pre-position phase.

7. 🟡 **Gripper twitches during the joints-mode peek.** [both]
   `_peek_initial_positions` (`:94-99`) remaps only `joint_states`; the bag's first
   `/sgr532/gripper/command` goes straight to hardware during the throwaway
   `rosbag play -r 0` peek — before playback even starts. The worktree voids these
   topics for the EE peek (`[wt]:186-189`) but not the joints peek.
   *Fix:* remap `/sgr532/gripper/command` to a void topic in the peek args.

8. 🟡 **Goal spam: one preempting single-point goal per replayed message (~100 Hz).** [both]
   `_playback_js_callback` sends a new `FollowJointTrajectory` goal per
   `joint_states` message (recorded at hardware rate), each with
   `time_from_start=0.1s` and zero velocities — constant preemption thrash,
   stuttery motion. `PLAYBACK_RATE_HZ` (10) only limits the exit-poll timer.
   *Fix:* throttle goal emission or batch points into multi-point trajectories.

9. 🟡 **`/sgr532/bag_status` has no error state.** [both]
   Failure paths (bag missing at `:183`, empty bag, worktree IK-unavailable abort)
   publish nothing; Unity can't distinguish "failed" from "idle".
   *Fix:* publish `ERROR:<reason>` / `PLAY_FAILED:N` on early-return paths.
   (Note: the `process-isolation-policy` skill requires recorder failures not to
   block the telemetry pipeline — a status publish + log satisfies that; silent
   swallowing is not required.)

10. ⚪ Natural playback finish (`_playback_timer_cb`, `:261-268`) flips to `IDLE`
    without `cancel_all_goals` — last in-flight goal keeps executing.

### `dashboard_controller.py`

11. 🟡 **Empty (zero-message) bags report as having data.**
    `slot_has_data` (`:47-51`) only checks `getsize > 0`; a bag that captured zero
    messages is still multi-KB of headers. Unity lights the slot; playback finishes
    instantly and fires `playback_finished` immediately.
    *Fix:* check message count (`rosbag info`) not just file size.

12. 🟡 **No lock around `record_procs`/`playback_procs`.**
    Concurrent service threads mutate the dicts (`:30-31`) unlocked; `handle_clear`'s
    truncate can race a freshly spawned `rosbag record` on the same slot.
    *Fix:* one `threading.Lock` around all dict access + subprocess start/stop
    (the MUX already models this with `_state_lock`).

13. 🟡 **SIGKILL fallback (5 s timeout, `:91-95`, `:133-137`) can leave an unindexed
    `.bag.active`** that `_get_playable_path` then hands to `rosbag play`.
    *Fix:* longer SIGINT grace; validate/reindex a leftover `.active` before treating
    it as playable.

14. ⚪ Finished playback procs never popped from `playback_procs` (`:36-40`) — minor leak.
15. ⚪ `Popen` failures unhandled in `handle_record`/`handle_playback` (`:79`, `:121`)
    — a missing `rosbag` binary raises instead of returning `success=False`.

### ee-playback worktree only

16. 🟡 **Blocking `compute_ik` call inside the EE playback callback** (`[wt]:415`,
    0.05 s service timeout) at recorded stream rate — unbounded subscriber queue means
    playback progressively lags the bag clock.
    *Fix:* small `queue_size` (drop stale) or solve IK off the callback thread.
17. 🟡 **Legacy bags (no `vr_target_pose`) cause an 8 s node freeze per EE play**
    (`[wt]:194-208` `wait_for_message` under the held lock, see #6), then pre-position
    is silently skipped → lurch. Logged, but freeze + lurch remain. Record fresh bags.

### Launch / packaging

18. ⚪ `arm_bag_recorder.py:38` `wait_for_server()` and `light_ik_solver.py:54`
    `wait_for_service()` have no timeout — if MoveIt/the arm driver fails to start,
    both nodes hang forever with no error.
19. ⚪ No `respawn` on any node in `unity_vr_control.launch` — a crashed
    `dashboard_controller` silently removes Unity's services. Respawn is reasonable
    for the dashboard, **not** for the MUX (respawn mid-record would orphan rosbag).
20. ⚪ `package.xml` is missing `<exec_depend>rosbag</exec_depend>` even though both
    recorders shell out to it.
21. ⚪ ~~**Commit hazard:** the modified `full_system.launch` references
    `debug_checkpoint.sh`, which is **untracked**~~ — resolved 2026-07-15: the
    debug_checkpoint scaffolding was removed from the launch files and CMakeLists.

---

## Suggested fix order

1. Port commit `999b4ae`'s pattern into `arm_bag_recorder.py`: SIGINT stop with a
   generous timeout, `.bag.active` fallback in `_slot_path`/playback checks,
   `rospy.on_shutdown` handler (#TL;DR, #4). **Apply identically in the ee-playback
   worktree copy** or the bug returns at merge.
2. Gate dashboard playback / add the cross-system interlock + stale-pose rejection
   (#1–#3) — this is the safety-critical one for anyone operating the arm.
3. Fix the STOP races and lock-held pre-positioning (#5, #6).
4. Everything 🟡/⚪ as time allows.

## Verification checklist (after fixing)

```bash
# MUX recorder round-trip
rostopic pub -1 /sgr532/bag_control std_msgs/String "data: 'RECORD:1'"
ls ~/ROS_Files/sagittarius_ws/recordings/        # expect slot_1.bag.active DURING recording
rostopic pub -1 /sgr532/bag_control std_msgs/String "data: 'STOP'"
ls ~/ROS_Files/sagittarius_ws/recordings/        # expect finalized slot_1.bag
rosbag info ~/ROS_Files/sagittarius_ws/recordings/slot_1.bag   # expect nonzero message counts
# Kill test: start RECORD, Ctrl+C the roslaunch — expect a finalized .bag (shutdown hook),
# and `ps aux | grep "rosbag record"` shows no orphans.
```
