% Extended Kalman filter example
clear;clc;
rng('default');

%% Create AVI object
makemovie = 1;
if(makemovie)
    vidObj = VideoWriter('ekf_no_change_kidnapped.avi');
    vidObj.Quality = 100;
    vidObj.FrameRate = 8;
    open(vidObj);
end

% Discrete time step
dt = 0.05;

% Initial State
% x0 = [0 0 0]';
L = 1;
g = 9.81;

% Kidnapped
x0 = [0.03 -0.01 0]';

% Prior
mu = [0 0 0]';  % mean (mu)
S = 0.01*eye(3); % covariance (Sigma)

% Discrete motion model
Ad = [ 1 dt 0 ; 0 1 dt; 0 0 1];

cov_theta_dddot = .001;      % TODO: Play with this
cov_motion_dist = .000001;
cov_measurements = .0001;       % TODO: Play with this

% Motion model disturbances
R_fake = [cov_motion_dist 0 0; 0 cov_motion_dist 0 ; 0 0 cov_theta_dddot];

R_act = cov_motion_dist*eye(3);
[RE_act, Re_act] = eig (R_act);

% Measurement model disturbances
Q = cov_measurements*eye(3);
[QE, Qe] = eig (Q);

% Simulation Initializations
Tf = 5;
T = 0:dt:Tf;
n = length(Ad(1,:));
x = zeros(n,length(T));
x(:,1) = x0;
m = length(Q(:,1));
y = zeros(m,length(T));
mup_S = zeros(n,length(T));
mu_S = zeros(n,length(T));

% True system inputs
torque = 10*sin(3*T-pi/2);
J = 5;
use_true_system = 1;

%% Main loop
for t=2:length(T)
    %% Simulation
    % Select a motion disturbance
    e = RE_act*sqrt(Re_act)*randn(n,1);
    % Update state
    x(:,t) = Ad*x(:,t-1);
    if (use_true_system)
        x(3,t) = torque(t)/J; % Set angular accel directly
    end
    x(:,t) = x(:,t) + e;

    % Take measurement
    % Select a measurement disturbance
    d = QE*sqrt(Qe)*randn(m,1);
    % Determine measurement
    y(:,t) = imu_measurement(x(:,t), L, g) + d;

    %% Extended Kalman Filter Estimation
    % Prediction update
    mup = Ad*mu;
    if (use_true_system)
        R = R_fake;
    else
        R = R_act;
    end
    Sp = Ad*S*Ad' + R;

    % Linearization of motion model
    Ht = [-g*cos(mup(1)) -2*L*mup(2) 0; g*sin(mup(1)) 0 L; 0 1 0];

    % Measurement update
    K = Sp*Ht'*inv(Ht*Sp*Ht'+Q);
    mu = mup + K*(y(:,t)-imu_measurement(mup, L, g));
    S = (eye(n)-K*Ht)*Sp;

    % Store results
    mup_S(:,t) = mup;
    mu_S(:,t) = mu;
%     K_S(:,t) = K;


    %% Plot results
    figure(1); clf; hold on;
    plot(x(1,2:t), x(2,2:t), 'ro--')
    plot(mu_S(1,2:t), mu_S(2,2:t), 'bx--')
    mu_pos = [mu(1) mu(2)];
    S_pos = [S(1,1) S(1,2); S(2,1) S(2,2)];
    error_ellipse(S_pos, mu_pos, 0.75);
    error_ellipse(S_pos, mu_pos, 0.95);
    title('No Change, Kidnap (0.03, -0.01)')
    legend(["True State", "Belief"]);
    xlabel("Theta (rad)");
    ylabel("Omega (rad/s)");
    axis([-0.5 0.4 -0.9 0.9]);
    if (makemovie) writeVideo(vidObj, getframe(gca));end

end
if (makemovie) close(vidObj); end

