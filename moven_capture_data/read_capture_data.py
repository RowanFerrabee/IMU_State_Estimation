class CaptureData:
	def __init__(self):
		self.sensor_names = []
		self.segment_names = []
		self.joint_names = []
		self.time = []
		self.position = []
		self.orientation = []
		self.joint_angles = []
		self.joint_angles_xzy = []
		self.sensor_orientation = []
		self.sensor_acceleration = []
		self.sensor_angular_velocity = []

def read_capture_data(matlab_struct):
	data = CaptureData()
	data.segment_names = [item[0][0] for item in matlab_struct['segment_names'][0][0]]
	data.joint_names = [item[0][0] for item in matlab_struct['joint_names'][0][0]]
	data.sensor_names = [item[0][0] for item in matlab_struct['sensor_names'][0][0]]
	data.time = [item[0] for item in matlab_struct['time'][0][0]]
	data.position = matlab_struct['position'][0][0]
	data.orientation = matlab_struct['orientation'][0][0]
	data.joint_angles = matlab_struct['joint_angles'][0][0]
	data.joint_angles_xzy = matlab_struct['joint_angles_xzy'][0][0]
	data.sensor_orientation = matlab_struct['sensor_orientation'][0][0]
	data.sensor_acceleration = matlab_struct['sensor_acceleration'][0][0]
	data.sensor_angular_velocity = matlab_struct['sensor_angular_velocity'][0][0]
	return data