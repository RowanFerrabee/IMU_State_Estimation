from scipy.io import loadmat
import numpy as np
import matplotlib.pyplot as plt
from read_capture_data import *

def main():
	data = loadmat('readable_capture_data.mat');

	normal = read_capture_data(data['normal_data']);
	insuf_depth = read_capture_data(data['insuf_depth_data']);

	n_samples = 1000
	s = np.linspace(0, 1, n_samples)


	normal_start = 435
	normal_end = 726
	normal_s_map = np.linspace(normal_start, normal_end, n_samples).astype(int)

	insuf_depth_start = 133
	insuf_depth_end = 345
	insuf_depth_s_map = np.linspace(insuf_depth_start, insuf_depth_end, n_samples).astype(int)

	hip_height_idx = 2
	plt.subplot(121)
	plt.plot(s, normal.position[normal_s_map, hip_height_idx])
	plt.plot(s, insuf_depth.position[insuf_depth_s_map, hip_height_idx])
	plt.xlabel("Squat Path Variable, S (unitless)")
	plt.ylabel("Hip Height (m)")
	plt.legend(["Baseline","Insufficient Depth"])
	plt.title("Normal Vs Insufficient Depth Hip Height")

	plt.subplot(122)

	r_hip_idx = 14
	r_knee_idx = 15
	r_ankle_idx = 16
	l_hip_idx = 18
	l_knee_idx = 19
	l_ankle_idx = 20

	angle_diff = normal.joint_angles[normal_s_map,:]-insuf_depth.joint_angles[insuf_depth_s_map,:]

	plt.plot(s, angle_diff[:, 3*r_hip_idx+2],'r')
	plt.plot(s, angle_diff[:, 3*r_knee_idx+2],'g')
	plt.plot(s, angle_diff[:, 3*r_ankle_idx+2],'b')
	plt.plot(s, angle_diff[:, 3*l_hip_idx+2],'m')
	plt.plot(s, angle_diff[:, 3*l_knee_idx+2],'y')
	plt.plot(s, angle_diff[:, 3*l_ankle_idx+2],'c')
	plt.xlabel("Squat Path Variable, S (unitless)")
	plt.ylabel("Joint Angle Error (deg)")
	plt.legend(["Right Hip","Right Knee","Right Ankle","Left Hip","Left Knee","Left Ankle"])
	plt.title("Error (Difference in Joint Angles)");

	plt.show()

if __name__ == '__main__':
	main()