clc;
clear;

%% Save or Load Data
%normal = xml2struct('Normal.xml');
%heel_off = xml2struct('HeelOffGround.xml');
%knee_ahead = xml2struct('KneeAheadToes.xml');
%knee_coll = xml2struct('KneeColl.xml');
%insuf_depth = xml2struct('InsufficientDepth.xml');

%save capture_structs;
load capture_structs;

%% Parse Data
normal_data = get_mvn_data(normal);
insuf_depth_data = get_mvn_data(insuf_depth);

%% Plot Position
segment = 1;

figure();
hold on;
plot(normal_data.time, normal_data.position(:,(segment-1)*3+3));
plot(insuf_depth_data.time, insuf_depth_data.position(:,(segment-1)*3+3));
title("Normal "+normal_data.segment_names{segment}+" Position vs Insuf Depth "+insuf_depth_data.segment_names{segment}+" Position");
legend(["Normal","Insuf Depth"])
xlabel("Time (ms)")
ylabel("Z Position (m)")
hold off;

%% Plot Accel
sensor = 6;

figure();
hold on;
plot(normal_data.time, normal_data.sensor_acceleration(:,(sensor-1)*3+1));
plot(normal_data.time, normal_data.sensor_acceleration(:,(sensor-1)*3+2));
plot(normal_data.time, normal_data.sensor_acceleration(:,(sensor-1)*3+3));
title("Accel Data For "+normal_data.sensor_names{sensor});
legend(["X","Y","Z"])
xlabel("Time (ms)")
ylabel("Accel Data (m/s/s)")
hold off;

%% Plot Gyro
figure();
hold on;
plot(normal_data.time, normal_data.sensor_angular_velocity(:,(sensor-1)*3+1));
plot(normal_data.time, normal_data.sensor_angular_velocity(:,(sensor-1)*3+2));
plot(normal_data.time, normal_data.sensor_angular_velocity(:,(sensor-1)*3+3));
title("Gyro Data For "+normal_data.sensor_names{sensor});
legend(["X","Y","Z"])
xlabel("Time (ms)")
ylabel("Gyro Data (rad/s)")
hold off;