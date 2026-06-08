"""
To handle issues with multi-usb camera/webcam setups, which WSL struggles with,
this publisher script will instead setup 2 webcams with a openCV local network
connection. This will bypass the need for 'usbipd bind ...' commands in PShell.

DO NOT RUN IN WSL. You will get access errors, run on native machine.
"""

import cv2
import socket
import struct
import pickle

print("Beginning connection script for 2 Webcams...")

# Initialize both cameras natively in Windows
cam1 = cv2.VideoCapture(0)  # Maps to Bus 2-4
cam2 = cv2.VideoCapture(1)  # Maps to Bus 3-4

# Set resolutions matching your ROS launch targets
for cam in [cam1, cam2]:
    cam.set(cv2.CAP_PROP_FRAME_WIDTH, 640)
    cam.set(cv2.CAP_PROP_FRAME_HEIGHT, 480)
    cam.set(cv2.CAP_PROP_FPS, 15)

# Setup network socket to talk to WSL (localhost)
server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_socket.bind(('127.0.0.1', 8484))
server_socket.listen(2)

print("Windows Camera Bridge Listening on port 8484... Start your ROS nodes now.")

while True:
    conn, addr = server_socket.accept()
    try:
        while True:
            ret1, frame1 = cam1.read()
            ret2, frame2 = cam2.read()
            
            if ret1 and ret2:
                # Package both frames together
                data = pickle.dumps((frame1, frame2))
                message = struct.pack("Q", len(data)) + data
                conn.sendall(message)
    except Exception as e:
        conn.close()
