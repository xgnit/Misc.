#!/usr/bin/env python

import glob
import os
import sys
from cv_bridge import CvBridge, CvBridgeError
# OpenCV2 for saving an image
import cv2
topic = "/carla/ego_vehicle/camera/semantic_segmentation/front/image_segmentation"


import rospy
from sensor_msgs.msg import Image

bridge = CvBridge()
 
def callback(data):
    print("Received an image!")
    try:
        # Convert your ROS Image message to OpenCV2
        cv2_img = bridge.imgmsg_to_cv2(data, "bgr8")
    except CvBridgeError, e:
        print(e)
    else:
        # Save your OpenCV2 image as a jpeg 
		time = data.header.stamp
		cv2.imwrite(''+str(time)+'.jpeg', cv2_img)
		rospy.sleep(1)
 	
	
def listener():
	rospy.init_node('ros_listener', anonymous=True)
	channel = "/carla/ego_vehicle/camera/semantic_segmentation/front/image_segmentation"
	rospy.Subscriber(topic, Image, callback)

	
	rospy.spin()

if __name__ == '__main__':
	listener()
