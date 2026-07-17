#!/usr/bin/env python3
"""Compare a slot's recorded demo against its joints/EE playback captures.

Usage: python3 compare_playback.py <slot> [--reference PATH]
                                    [--joints-capture PATH] [--ee-capture PATH]
"""

import argparse
import csv
import glob
import os
import sys
import time

import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import rosbag

RECORDINGS_DIR = os.path.expanduser("~/ROS_Files/sagittarius_ws/recordings")
CAPTURE_DIR = os.path.join(RECORDINGS_DIR, "playbacks")
JOINT_NAMES = ["joint1", "joint2", "joint3", "joint4", "joint5", "joint6"]


def extract_bag(path):
    times, series = [], {j: [] for j in JOINT_NAMES}
    with rosbag.Bag(path) as bag:
        for _, msg, t in bag.read_messages(topics=["/sgr532/joint_states"]):
            name_to_pos = dict(zip(msg.name, msg.position))
            times.append(t.to_sec())
            for j in JOINT_NAMES:
                series[j].append(name_to_pos.get(j, float("nan")))
    if not times:
        return None
    t0 = times[0]
    return [t - t0 for t in times], series


def extract_csv(path):
    times, series = [], {j: [] for j in JOINT_NAMES}
    with open(path, newline="") as f:
        for row in csv.DictReader(f):
            times.append(float(row["time"]))
            for j in JOINT_NAMES:
                series[j].append(float(row[j]))
    if not times:
        return None
    return times, series


def latest_capture(slot, mode):
    matches = sorted(glob.glob(os.path.join(CAPTURE_DIR, f"slot_{slot}_{mode}_*.csv")))
    return matches[-1] if matches else None


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("slot", type=int)
    ap.add_argument("--reference", help="override reference bag path")
    ap.add_argument("--joints-capture", help="override joints capture CSV path")
    ap.add_argument("--ee-capture", help="override EE capture CSV path")
    args = ap.parse_args()

    ref_path = args.reference or os.path.join(RECORDINGS_DIR, f"slot_{args.slot}.bag")
    if not os.path.isfile(ref_path):
        sys.exit(f"Reference bag not found: {ref_path}")
    ref = extract_bag(ref_path)
    if ref is None:
        sys.exit(f"No /sgr532/joint_states messages in {ref_path}")
    ref_t, ref_series = ref

    captures = {}
    joints_path = args.joints_capture or latest_capture(args.slot, "joints")
    ee_path = args.ee_capture or latest_capture(args.slot, "ee")
    if joints_path and os.path.isfile(joints_path):
        captures["joints"] = extract_csv(joints_path)
    if ee_path and os.path.isfile(ee_path):
        captures["ee"] = extract_csv(ee_path)
    if not captures:
        sys.exit(f"No playback captures found for slot {args.slot} in {CAPTURE_DIR}")

    fig, axes = plt.subplots(len(JOINT_NAMES), 1, figsize=(10, 14), sharex=True)
    metrics = {}
    for ax, joint in zip(axes, JOINT_NAMES):
        ax.plot(ref_t, ref_series[joint], label="reference", color="black", linewidth=1.5)
        for mode, (t, series) in captures.items():
            ax.plot(t, series[joint], label=mode, alpha=0.8)
            err = np.array(series[joint]) - np.interp(t, ref_t, ref_series[joint])
            metrics.setdefault(mode, {})[joint] = (
                float(np.sqrt(np.mean(err ** 2))), float(np.max(np.abs(err))))
        ax.set_ylabel(joint)
        ax.legend(loc="upper right", fontsize=8)
    axes[-1].set_xlabel("time (s)")
    fig.suptitle(f"Slot {args.slot} playback comparison")
    fig.tight_layout()

    ts = time.strftime("%Y%m%d-%H%M%S")
    out_png = os.path.join(CAPTURE_DIR, f"slot_{args.slot}_compare_{ts}.png")
    fig.savefig(out_png, dpi=150)
    print(f"Saved plot: {out_png}\n")

    print(f"{'mode':<8}{'joint':<10}{'RMSE(rad)':>12}{'max|err|(rad)':>16}")
    for mode, joint_metrics in metrics.items():
        for joint, (rmse, maxerr) in joint_metrics.items():
            print(f"{mode:<8}{joint:<10}{rmse:>12.4f}{maxerr:>16.4f}")
        overall_rmse = float(np.sqrt(np.mean([v[0] ** 2 for v in joint_metrics.values()])))
        overall_max = max(v[1] for v in joint_metrics.values())
        print(f"{mode:<8}{'OVERALL':<10}{overall_rmse:>12.4f}{overall_max:>16.4f}")


if __name__ == "__main__":
    main()
