#!/usr/bin/env python3
"""
This file is the listener for the publisher script cam_bridge.py in ../scripts/
It listens for publications of camera data (outside of WSL) and converts it to
a usable image message format usable by ROS.
"""

import rospy
import socket
import struct
import pickle
import cv2
from sensor_msgs.msg import Image
from cv_bridge import CvBridge

def main():
    rospy.init_node('windows_camera_bridge_receiver', anonymous=True)
    
    # Create ROS publishers matching your C# expectations
    pub1 = rospy.Publisher('/cam1/usb_cam/image_raw', Image, queue_size=10)
    pub2 = rospy.Publisher('/cam2/usb_cam/image_raw', Image, queue_size=10)
    
    bridge = CvBridge()
    
    # Connect to the Windows host socket (127.0.0.1 loops back to the main OS)
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    try:
        client_socket.connect(('127.0.0.1', 8484))
    except Exception as e:
        rospy.logerr(f"Could not connect to Windows bridge: {e}")
        return

    data = b""
    payload_size = struct.calcsize("Q")
    
    rospy.loginfo("Connected to Windows Camera Bridge. Publishing frames...")

    while not rospy.is_shutdown():
        # Keep receiving data until we have the full frame size header
        while len(data) < payload_size:
            packet = client_socket.recv(4096)
            if not packet: break
            data += packet
        if not data: break
        
        packed_msg_size = data[:payload_size]
        data = data[payload_size:]
        msg_size = struct.unpack("Q", packed_msg_size)[0]
        
        # Keep receiving until the entire twin-frame payload is delivered
        while len(data) < msg_size:
            data += client_socket.recv(4096)
            
        frame_data = data[:msg_size]
        data = data[msg_size:]
        
        # Unpack the frames back into OpenCV images
        frame1, frame2 = pickle.loads(frame_data)
        
        # Convert OpenCV matrices to native ROS Image messages
        ros_img1 = bridge.cv2_to_imgmsg(frame1, encoding="bgr8")
        ros_img2 = bridge.cv2_to_imgmsg(frame2, encoding="bgr8")
        
        # Add timestamps and frame IDs
        ros_img1.header.stamp = rospy.Time.now()
        ros_img1.header.frame_id = "cam1_link"
        ros_img2.header.stamp = rospy.Time.now()
        ros_img2.header.frame_id = "cam2_link"
        
        # Publish to the ROS graph
        pub1.publish(ros_img1)
        pub2.publish(ros_img2)

    client_socket.close()

if __name__ == '__main__':
    try:
        main()
    except rospy.ROSInterruptException:
        pass
