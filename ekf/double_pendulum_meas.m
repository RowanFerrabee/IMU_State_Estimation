function [meas] = double_pendulum_meas(state, L, r1, r2, g)
    th1 = state(1);
    th1_dot = state(2);
    th1_ddot = state(3);
    th2 = state(4);
    th2_dot = state(5);
    th2_ddot = state(6);
    
    imu_1_meas = [-r1*(th1_dot.^2)-g*sin(th1);
                  r1*th1_ddot-g*cos(th1);
                  th1_dot];
              
    mid_pt_accel = [-L*th1_ddot*sin(th1)-L*(th1_dot.^2)*cos(th1);
                    -L*(th1_dot.^2)*sin(th1)+L*th1_ddot*cos(th1)];
                
    imu_2_accel = [-r2*th2_ddot*sin(th2)-r2*(th2_dot.^2)*cos(th2);
                   -r2*(th2_dot.^2)*sin(th2)+r2*th2_ddot*cos(th2)] ...
                   + mid_pt_accel;
    
    imu_2_meas = [cos(th2) sin(th2); -sin(th2) cos(th2)] * ...
                  (imu_2_accel + [0; -9.81]);
              
    imu_2_meas = [imu_2_meas; th2_dot];
    
    meas = [imu_1_meas; imu_2_meas];
end

