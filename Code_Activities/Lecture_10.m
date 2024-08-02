clear; close all; clc;

%Initial Conditions
v_0 = 10;
dt = 0.01;
t = 0:dt:1;
R = 1;
nT = length(t);

% Analytic Equation
V = v_0*exp(-t);

% Create solution variable
theta = zeros(4,nT);

% Set the initial condition
theta(:,1) = [0, -pi/16, -pi/8, -3*pi/16];

for i = 1:nT-1

    % Grab the current state
    theta_n = theta(:,n);
    V_n = V(n)*ones(4,1);

    % Determine n+1 state -> Euler Method
    theta_np1 = theta_n + dt*V_n/R;

    % Save the n+1 state into your solution variable
    theta(:, n+1) = theta_np1;

    % Plot the n+1 position
    plot(R*cos(theta(:,n+1)), R*sin(theta(:,n+1)), '.r','MarkerSize',30);
    axis([-1 1 -1 1])
    drawnow;
end

% creating time vector inside the function - when do I stop?





