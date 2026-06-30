"""
Run on the Windows host (NOT in WSL) to stream both webcams to WSL at 30fps.

IMPORTANT: The cameras must NOT be attached to WSL via usbipd when you run this.
           usbipd gives the camera exclusively to WSL, so Windows DirectShow cannot
           see it. If you attached them with 'usbipd attach', run 'usbipd detach'
           for both cameras first, then run this script.

Each camera runs on its own thread and its own TCP port so they are fully
independent — a slow frame on one camera never blocks the other.

Ports:
  8484 — cam1 (OpenCV index 0)
  8485 — cam2 (OpenCV index 1)

Usage (Windows PowerShell or CMD — do NOT double-click the file):
  python cam_bridge.py

Then in WSL: camlaunch   (auto-starts cam_bridge_receiver if no usbipd cameras found)
"""

import cv2
import socket
import struct
import threading

CAM1_PORT  = 8484
CAM2_PORT  = 8485
WIDTH  = 640
HEIGHT = 480
FPS    = 30
JPEG_QUALITY = 80


def _open_camera(cam_index: int, backend: int, name: str) -> cv2.VideoCapture:
    cap = cv2.VideoCapture(cam_index, backend)
    cap.set(cv2.CAP_PROP_FRAME_WIDTH,  WIDTH)
    cap.set(cv2.CAP_PROP_FRAME_HEIGHT, HEIGHT)
    cap.set(cv2.CAP_PROP_FPS,          FPS)
    cap.set(cv2.CAP_PROP_FOURCC, cv2.VideoWriter_fourcc('M', 'J', 'P', 'G'))
    if not cap.isOpened():
        raise RuntimeError(f"[{name}] Failed to open camera index {cam_index}")
    return cap


def stream_camera(cam_index: int, backend: int, port: int, name: str) -> None:
    cap = _open_camera(cam_index, backend, name)
    actual_fps = cap.get(cv2.CAP_PROP_FPS)
    print(f"[{name}] Opened at {int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))}x"
          f"{int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))} @ {actual_fps:.0f} fps")

    srv = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    srv.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    srv.bind(('0.0.0.0', port))
    srv.listen(1)
    print(f"[{name}] Listening on 0.0.0.0:{port} — start camlaunch in WSL now.")

    while True:
        conn, addr = srv.accept()
        conn.setsockopt(socket.IPPROTO_TCP, socket.TCP_NODELAY, 1)
        print(f"[{name}] WSL receiver connected from {addr}")
        try:
            while True:
                ret, frame = cap.read()
                if not ret:
                    print(f"[{name}] WARNING: frame read failed, retrying")
                    continue

                ok, buf = cv2.imencode('.jpg', frame,
                                       [cv2.IMWRITE_JPEG_QUALITY, JPEG_QUALITY])
                if not ok:
                    continue

                payload = buf.tobytes()
                # 4-byte big-endian length header then JPEG bytes
                conn.sendall(struct.pack('!I', len(payload)) + payload)
        except (BrokenPipeError, ConnectionResetError, OSError):
            print(f"[{name}] WSL receiver disconnected, waiting for reconnect...")
        finally:
            conn.close()


def scan_cameras(max_index: int = 10) -> list:
    """Return list of (index, backend_flag, width, height, fps) for each working camera."""
    found = []
    for backend_flag, backend_name in [(cv2.CAP_DSHOW, 'DSHOW'), (cv2.CAP_MSMF, 'MSMF')]:
        print(f"  Trying backend {backend_name}...")
        for i in range(max_index):
            cap = cv2.VideoCapture(i, backend_flag)
            if cap.isOpened():
                w = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
                h = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
                fps = cap.get(cv2.CAP_PROP_FPS)
                found.append((i, backend_flag, backend_name, w, h, fps))
                print(f"    index {i}: {w}x{h} @ {fps:.0f} fps")
            cap.release()
        if found:
            break  # use whichever backend found cameras first
    return found


if __name__ == '__main__':
    print("Windows Camera Bridge starting...")
    print("Scanning for cameras (indices 0-9, trying DSHOW then MSMF)...")
    cams = scan_cameras()
    if not cams:
        print("\nERROR: No cameras found at any index 0-9 with either backend.")
        print("  - Are the cameras plugged in and visible in Device Manager?")
        print("  - Did 'usbipd detach' succeed for both cameras?")
        print("  - Try running: python -c \"import cv2; print(cv2.__version__)\"")
        input("\nPress Enter to exit...")
        raise SystemExit(1)

    print(f"\nFound {len(cams)} camera(s) using {cams[0][2]} backend.")
    if len(cams) < 2:
        print("WARNING: Only 1 camera found. Check the second camera's USB connection.")

    cam1_idx, cam1_backend = cams[0][0], cams[0][1]
    cam2_idx, cam2_backend = (cams[1][0], cams[1][1]) if len(cams) > 1 else (cams[0][0], cams[0][1])
    print(f"Using cam1=index{cam1_idx}, cam2=index{cam2_idx}  ({cams[0][2]} backend)\n")

    t1 = threading.Thread(target=stream_camera,
                          args=(cam1_idx, cam1_backend, CAM1_PORT, 'cam1'), daemon=True)
    t2 = threading.Thread(target=stream_camera,
                          args=(cam2_idx, cam2_backend, CAM2_PORT, 'cam2'), daemon=True)
    t1.start()
    t2.start()
    t1.join()
    t2.join()
