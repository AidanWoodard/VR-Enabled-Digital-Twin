#!/usr/bin/env python3
"""
WSL-side receiver for cam_bridge.py (run cam_bridge.py on the Windows host first).

Connects to two independent TCP ports (cam1=8484, cam2=8485), receives
JPEG frames, and publishes CompressedImage on the same topics that
usb_cam + image_republisher would publish, so Unity sees no difference.

Published topics:
  /cam1/usb_cam/image/compressed  (sensor_msgs/CompressedImage)
  /cam2/usb_cam/image/compressed  (sensor_msgs/CompressedImage)
"""

import rospy
import socket
import struct
import threading
from sensor_msgs.msg import CompressedImage

CAM1_PORT = 8484
CAM2_PORT = 8485
HOST      = '127.0.0.1'
RECONNECT_DELAY_S = 2.0


def _recv_exactly(sock: socket.socket, n: int) -> bytes:
    buf = b''
    while len(buf) < n:
        chunk = sock.recv(n - len(buf))
        if not chunk:
            raise ConnectionError("socket closed")
        buf += chunk
    return buf


def receive_camera(port: int, topic: str, name: str) -> None:
    pub = rospy.Publisher(topic, CompressedImage, queue_size=2)

    while not rospy.is_shutdown():
        try:
            rospy.loginfo(f"[{name}] Connecting to Windows bridge on port {port}...")
            sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            sock.connect((HOST, port))
            sock.setsockopt(socket.IPPROTO_TCP, socket.TCP_NODELAY, 1)
            rospy.loginfo(f"[{name}] Connected — receiving frames.")

            while not rospy.is_shutdown():
                header = _recv_exactly(sock, 4)
                size   = struct.unpack('!I', header)[0]
                data   = _recv_exactly(sock, size)

                msg = CompressedImage()
                msg.header.stamp    = rospy.Time.now()
                msg.header.frame_id = name + "_link"
                msg.format          = "jpeg"
                msg.data            = data
                pub.publish(msg)

        except (ConnectionError, ConnectionRefusedError, OSError) as e:
            rospy.logwarn(f"[{name}] Connection lost ({e}). "
                          f"Retrying in {RECONNECT_DELAY_S}s...")
            rospy.sleep(RECONNECT_DELAY_S)
        finally:
            try:
                sock.close()
            except Exception:
                pass


def main() -> None:
    rospy.init_node('cam_bridge_receiver', anonymous=False)

    t1 = threading.Thread(
        target=receive_camera,
        args=(CAM1_PORT, '/cam1/usb_cam/image/compressed', 'cam1'),
        daemon=True,
    )
    t2 = threading.Thread(
        target=receive_camera,
        args=(CAM2_PORT, '/cam2/usb_cam/image/compressed', 'cam2'),
        daemon=True,
    )
    t1.start()
    t2.start()
    rospy.spin()


if __name__ == '__main__':
    try:
        main()
    except rospy.ROSInterruptException:
        pass
