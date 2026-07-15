#!/usr/bin/env python3
"""Fake ROS-TCP-Connector client for isolating Unity <-> ROS data-flow failures.

Speaks the same wire protocol as Unity's ROSConnection: each frame is
<u32 len><destination string><u32 len><payload>. Connects to the running
ros_tcp_endpoint, sends a __subscribe syscommand for /sgr532/joint_states,
and counts the messages streamed back.

Usage:
  python3 debug_fake_unity_client.py [host]     # default 127.0.0.1

Run it from two places to bisect the failure:
  1. Inside WSL          -> tests the endpoint + ROS graph
  2. On the Windows host -> tests the WSL2 mirrored-networking boundary,
     i.e. the exact path Unity uses (copy the file over, needs any Python 3)

If both print "TOTAL: 10 messages", the entire ROS/WSL/network side is healthy
and the problem is inside Unity itself (see docs/UNITY_SETUP.md troubleshooting).

NOTE: the endpoint's sender attaches to the most recent client connection, so
running this while Unity is connected will steal Unity's stream until it
reconnects. Fine for debugging; don't run it during a live teleop session.
"""
import socket, struct, json, sys, time

HOST = sys.argv[1] if len(sys.argv) > 1 else "127.0.0.1"
PORT = 10000
TOPIC = "/sgr532/joint_states"
MSG_TYPE = "sensor_msgs/JointState"


def frame(dest, payload: bytes) -> bytes:
    d = dest.encode()
    return struct.pack("<I", len(d)) + d + struct.pack("<I", len(payload)) + payload


def recvall(s, n):
    buf = b""
    while len(buf) < n:
        chunk = s.recv(n - len(buf))
        if not chunk:
            raise IOError("connection closed")
        buf += chunk
    return buf


def main():
    s = socket.create_connection((HOST, PORT), timeout=5)
    print(f"connected to {HOST}:{PORT} from {s.getsockname()}")

    sub = json.dumps({"topic": TOPIC, "message_name": MSG_TYPE}).encode()
    s.sendall(frame("__subscribe", sub))
    print(f"sent __subscribe for {TOPIC}")

    t0 = time.time()
    count = 0
    try:
        while time.time() - t0 < 5 and count < 10:
            n = struct.unpack("<I", recvall(s, 4))[0]
            dest = recvall(s, n).decode()
            m = struct.unpack("<I", recvall(s, 4))[0]
            recvall(s, m)
            count += 1
            if count <= 2:
                print(f"received msg on '{dest}' ({m} bytes)")
    except socket.timeout:
        pass
    print(f"TOTAL: {count} messages in {time.time() - t0:.1f}s")
    s.close()


if __name__ == "__main__":
    main()
