"""
Run on the Windows host (NOT in WSL) to stream both webcams to WSL at 30fps.

Each camera runs on its own thread and its own TCP port so they are fully
independent — a slow frame on one camera never blocks the other.

Ports:
  8484 — cam1 (OpenCV index 0)
  8485 — cam2 (OpenCV index 1)

Usage (Windows PowerShell or CMD):
  python cam_bridge.py

Then in WSL: rosrun sagittarius_object_color_detector cam_bridge_receiver.py
"""

import cv2
import socket
import struct
import threading

CAM1_INDEX = 0
CAM2_INDEX = 1
CAM1_PORT  = 8484
CAM2_PORT  = 8485
WIDTH  = 640
HEIGHT = 480
FPS    = 30
JPEG_QUALITY = 80


def stream_camera(cam_index: int, port: int, name: str) -> None:
    cap = cv2.VideoCapture(cam_index, cv2.CAP_DSHOW)
    cap.set(cv2.CAP_PROP_FRAME_WIDTH,  WIDTH)
    cap.set(cv2.CAP_PROP_FRAME_HEIGHT, HEIGHT)
    cap.set(cv2.CAP_PROP_FPS,          FPS)
    cap.set(cv2.CAP_PROP_FOURCC, cv2.VideoWriter_fourcc('M', 'J', 'P', 'G'))

    if not cap.isOpened():
        print(f"[{name}] ERROR: could not open camera index {cam_index}")
        return

    actual_fps = cap.get(cv2.CAP_PROP_FPS)
    print(f"[{name}] Opened at {int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))}x"
          f"{int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))} @ {actual_fps:.0f} fps")

    srv = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    srv.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    srv.bind(('127.0.0.1', port))
    srv.listen(1)
    print(f"[{name}] Listening on port {port} — start cam_bridge_receiver.py in WSL now.")

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
        except (BrokenPipeError, ConnectionResetError):
            print(f"[{name}] WSL receiver disconnected, waiting for reconnect...")
        finally:
            conn.close()


if __name__ == '__main__':
    print("Windows Camera Bridge starting...")
    t1 = threading.Thread(target=stream_camera,
                          args=(CAM1_INDEX, CAM1_PORT, 'cam1'), daemon=True)
    t2 = threading.Thread(target=stream_camera,
                          args=(CAM2_INDEX, CAM2_PORT, 'cam2'), daemon=True)
    t1.start()
    t2.start()
    t1.join()
    t2.join()
