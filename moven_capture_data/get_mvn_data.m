function [new_struct] = get_mvn_data(orig_struct)

    frames = orig_struct.mvnx.subject.frames.frame;
    num_frames = length(frames);
    num_joints = length(orig_struct.mvnx.subject.joints.joint);
    num_sensors = length(orig_struct.mvnx.subject.sensors.sensor);
    num_segments = str2num(orig_struct.mvnx.subject.Attributes.segmentCount);

    new_struct = struct();
    new_struct.segment_names = cell(num_segments,1);
    new_struct.joint_names = cell(num_joints,1);
    new_struct.sensor_names = cell(num_sensors,1);

    new_struct.time = zeros(num_frames, 1);
    new_struct.position = zeros(num_frames, 3*num_segments);
    new_struct.orientation = zeros(num_frames, 4*num_segments);
    new_struct.joint_angles = zeros(num_frames, 3*num_joints);
    new_struct.joint_angles_xzy = zeros(num_frames, 3*num_joints);
    new_struct.sensor_orientation = zeros(num_frames, 4*num_sensors);
    new_struct.sensor_acceleration = zeros(num_frames, 3*num_sensors);
    new_struct.sensor_angular_velocity = zeros(num_frames, 3*num_sensors);
    
    for i = 1:num_segments
        new_struct.segment_names{i} = orig_struct.mvnx.subject.segments.segment{i}.Attributes.label;
    end
    for i = 1:num_joints
        new_struct.joint_names{i} = orig_struct.mvnx.subject.joints.joint{i}.Attributes.label;
    end
    for i = 1:num_sensors
        new_struct.sensor_names{i} = orig_struct.mvnx.subject.sensors.sensor{i}.Attributes.label;
    end

    for i = 1:num_frames
        if (strcmp(frames{i}.Attributes.type, 'normal'))
            new_struct.time(i) = str2double(frames{i}.Attributes.time);
            
            position_strings = split(frames{i}.position.Text, ' ');
            if (length(position_strings) == 3*num_segments)
                new_struct.position(i,:) = str2double(position_strings)';
            end
            
            orientation_strings = split(frames{i}.orientation.Text, ' ');
            if (length(orientation_strings) == 4*num_segments)
                new_struct.orientation(i,:) = str2double(orientation_strings)';
            end
            
            joint_angle_strings = split(frames{i}.jointAngle.Text, ' ');
            if (length(joint_angle_strings) == 3*num_joints)
                new_struct.joint_angles(i,:) = str2double(joint_angle_strings)';
            end
            
            joint_angles_xzy_strings = split(frames{i}.jointAngleXZY.Text, ' ');
            joint_angles_xzy_strings = joint_angles_xzy_strings(~strcmp(joint_angles_xzy_strings,''));
            if (length(joint_angles_xzy_strings) == 3*num_joints)
                new_struct.joint_angles_xzy(i,:) = str2double(joint_angles_xzy_strings)';
            end
            
            sensor_orientation_strings = split(frames{i}.sensorOrientation.Text, ' ');
            if (length(sensor_orientation_strings) == 4*num_sensors)
                new_struct.sensor_orientation(i,:) = str2double(sensor_orientation_strings)';
            end
            
            sensor_acceleration_strings = split(frames{i}.sensorAcceleration.Text, ' ');
            if (length(sensor_acceleration_strings) == 3*num_sensors)
                new_struct.sensor_acceleration(i,:) = str2double(sensor_acceleration_strings)';
            end
            
            sensor_angular_velocity_strings = split(frames{i}.sensorAngularVelocity.Text, ' ');
            if (length(sensor_angular_velocity_strings) == 3*num_sensors)
                new_struct.sensor_angular_velocity(i,:) = str2double(sensor_angular_velocity_strings)';
            end
        end
    end

end

