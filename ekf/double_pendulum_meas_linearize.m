function [ Ht ] = double_pendulum_meas_linearize(x_value)
    % x_value = [0,0,0,0,0,0];

    x_sym = sym('x', [6,1], 'real');

    y_of_x = double_pendulum_meas(x_sym);
    
    jacobian(y_of_x, x_sym)

    y_by_x_fn = matlabFunction( jacobian(y_of_x, x_sym) );

    Ht = y_by_x_fn(x_value(1), x_value(2), x_value(3), ...
                   x_value(4), x_value(5), x_value(6));

end