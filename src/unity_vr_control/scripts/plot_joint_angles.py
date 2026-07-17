#!/usr/bin/env python3
"""Overlay joint-angle-vs-time from any number of playback CSVs on one plot.

Usage:
  python3 plot_joint_angles.py [paths...] [--slot N] [--joints] [--ee] [--omit N [N ...]]
                                [--actual] [--no-show]

With no arguments, plots every CSV in recordings/playbacks/. --slot/--joints/--ee filter
the auto-discovered set; explicit positional paths are always included in addition.
--omit excludes joints by number (e.g. --omit 1 6 drops joint1 and joint6).
--actual (requires --slot N) overlays recordings/slot_N.bag's ground-truth recording in
black and prints per-joint RMSE/max-error metrics for each playback against it.
"""

import argparse
import csv
import glob
import os
import sys
import time

import numpy as np
import matplotlib.pyplot as plt
from matplotlib.lines import Line2D
import rosbag

PLAYBACK_DIR = os.path.expanduser("~/ROS_Files/sagittarius_ws/recordings/playbacks")
RECORDINGS_DIR = os.path.expanduser("~/ROS_Files/sagittarius_ws/recordings")
JOINT_NAMES = ["joint1", "joint2", "joint3", "joint4", "joint5", "joint6"]
JOINT_LINESTYLES = ["-", "--", "-.", ":", (0, (3, 1, 1, 1)), (0, (5, 1))]


def extract_csv(path):
    times, series = [], {j: [] for j in JOINT_NAMES}
    with open(path, newline="") as f:
        for row in csv.DictReader(f):
            times.append(float(row["time"]))
            for j in JOINT_NAMES:
                series[j].append(float(row[j]))
    if not times:
        return None
    t0 = times[0]
    return [t - t0 for t in times], series


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


def discover_files(slot, want_joints, want_ee):
    matches = sorted(glob.glob(os.path.join(PLAYBACK_DIR, "*.csv")))
    if slot is not None:
        matches = [p for p in matches if f"slot_{slot}_" in os.path.basename(p)]
    if want_joints or want_ee:
        keep = set()
        if want_joints:
            keep.update(p for p in matches if "_joints_" in os.path.basename(p))
        if want_ee:
            keep.update(p for p in matches if "_ee_" in os.path.basename(p))
        matches = sorted(keep)
    return matches


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("paths", nargs="*", help="explicit CSV paths (added to any discovered files)")
    ap.add_argument("--slot", type=int, help="filter discovered files to slot_N_*")
    ap.add_argument("--joints", action="store_true", help="include joints-mode captures")
    ap.add_argument("--ee", action="store_true", help="include EE-mode captures")
    ap.add_argument("--omit", type=int, nargs="+", metavar="N", default=[],
                     help="joint numbers to exclude, e.g. --omit 1 6")
    ap.add_argument("--actual", action="store_true",
                     help="overlay recordings/slot_N.bag ground truth in black (requires --slot)")
    ap.add_argument("--no-show", action="store_true", help="skip the interactive window")
    args = ap.parse_args()

    if args.actual and args.slot is None:
        sys.exit("--actual requires --slot N")
    bag_path = None
    if args.actual:
        bag_path = os.path.join(RECORDINGS_DIR, f"slot_{args.slot}.bag")
        if not os.path.isfile(bag_path):
            sys.exit(f"--actual: bag not found: {bag_path}")

    for n in args.omit:
        if n not in range(1, len(JOINT_NAMES) + 1):
            sys.exit(f"--omit {n} out of range (valid: 1-{len(JOINT_NAMES)})")
    joint_names = [j for j in JOINT_NAMES if int(j.replace("joint", "")) not in args.omit]
    if not joint_names:
        sys.exit("--omit excluded every joint, nothing left to plot")

    files = discover_files(args.slot, args.joints, args.ee)
    for p in args.paths:
        if p not in files:
            files.append(p)
    if not files:
        sys.exit(f"No playback CSVs found in {PLAYBACK_DIR} (or matching given filters)")

    fig, ax = plt.subplots(figsize=(12, 7))
    color_cycle = plt.rcParams["axes.prop_cycle"].by_key()["color"]

    file_handles = []
    playback_data = {}
    for i, path in enumerate(files):
        data = extract_csv(path)
        if data is None:
            print(f"Skipping {path}: no data rows", file=sys.stderr)
            continue
        playback_data[path] = data
        t, series = data
        color = color_cycle[i % len(color_cycle)]
        for joint in joint_names:
            style_idx = JOINT_NAMES.index(joint)
            ax.plot(t, series[joint], color=color, linestyle=JOINT_LINESTYLES[style_idx], alpha=0.85)
        label = os.path.basename(path)
        file_handles.append(Line2D([0], [0], color=color, label=label))

    actual_data = None
    if args.actual:
        actual_data = extract_bag(bag_path)
        if actual_data is None:
            sys.exit(f"--actual: no /sgr532/joint_states messages in {bag_path}")
        actual_t, actual_series = actual_data
        for joint in joint_names:
            style_idx = JOINT_NAMES.index(joint)
            ax.plot(actual_t, actual_series[joint], color="black",
                     linestyle=JOINT_LINESTYLES[style_idx], linewidth=2)
        file_handles.append(Line2D([0], [0], color="black", label=f"slot_{args.slot}.bag (actual)"))

    joint_handles = [
        Line2D([0], [0], color="black", linestyle=JOINT_LINESTYLES[JOINT_NAMES.index(joint)], label=joint)
        for joint in joint_names
    ]

    ax.set_xlabel("time (s)")
    ax.set_ylabel("joint angle (rad)")
    ax.set_title("Playback joint-angle comparison")

    file_legend = ax.legend(handles=file_handles, loc="upper left", bbox_to_anchor=(1.02, 1.0),
                             title="playback (color)", fontsize=8)
    ax.add_artist(file_legend)
    ax.legend(handles=joint_handles, loc="lower left", bbox_to_anchor=(1.02, 0.0),
              title="joint (style)", fontsize=8)
    fig.tight_layout()

    ts = time.strftime("%Y%m%d-%H%M%S")
    out_png = os.path.join(PLAYBACK_DIR, f"joint_angles_{ts}.png")
    fig.savefig(out_png, dpi=150, bbox_inches="tight")
    print(f"Saved plot: {out_png}")

    if args.actual:
        slot_prefix = f"slot_{args.slot}_"
        print(f"\n{'playback':<40}{'joint':<10}{'RMSE(rad)':>12}{'max|err|(rad)':>16}")
        for path, (t, series) in playback_data.items():
            name = os.path.basename(path)
            if not name.startswith(slot_prefix):
                print(f"skipping metrics for {name}: not slot {args.slot}", file=sys.stderr)
                continue
            rmse_list, max_list = [], []
            for joint in joint_names:
                err = np.array(series[joint]) - np.interp(t, actual_t, actual_series[joint])
                rmse = float(np.sqrt(np.mean(err ** 2)))
                maxerr = float(np.max(np.abs(err)))
                rmse_list.append(rmse)
                max_list.append(maxerr)
                print(f"{name:<40}{joint:<10}{rmse:>12.4f}{maxerr:>16.4f}")
            overall_rmse = float(np.sqrt(np.mean(np.array(rmse_list) ** 2)))
            overall_max = max(max_list)
            print(f"{name:<40}{'OVERALL':<10}{overall_rmse:>12.4f}{overall_max:>16.4f}")

    if not args.no_show:
        plt.show()


if __name__ == "__main__":
    main()
