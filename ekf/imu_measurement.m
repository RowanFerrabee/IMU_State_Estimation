function [meas] = imu_measurement(state, L, g)
    meas = [-L*(state(2).^2)-g*sin(state(1));
            L*state(3)-g*cos(state(1));
            state(2)];
end

