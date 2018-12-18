clc;
clear;

%% Load Data
load capture_structs;

%% Extract Data for Writing

normal_data = get_mvn_data(normal);
clear normal;
disp("Normal");

heel_off_data = get_mvn_data(heel_off);
clear heel_off;
disp("Heel Off");

knee_ahead_data = get_mvn_data(knee_ahead);
clear knee_ahead;
disp("Knee Ahead");

knee_coll_data = get_mvn_data(knee_coll);
clear knee_coll;
disp("Knee Coll");

insuf_depth_data = get_mvn_data(insuf_depth);
clear insuf_depth;
disp("Insuf Depth");

%% Save Readable Data

save readable_capture_data;