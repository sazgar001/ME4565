clear; close all; clc;

% Define time steps to analyze
time_steps = [0.1, 0.01, 1e-3, 1e-4, 1e-5];
errors = zeros(size(time_steps)); % Initialize error storage

% Loop over each time step
for i = 1:length(time_steps)
    dt = time_steps(i);
    t = 0:dt:3; % Update time vector based on current dt
    nT = length(t); % Update number of time steps
    
    % Initialize x and y for RK2 method
    x = zeros(1, nT);
    y = zeros(1, nT);
    x(1) = 1; % initial condition for x
    y(1) = 0; % initial condition for y (dx/dt at t=0)
    
    % Perform RK2 Implementation
    for n = 1:nT-1
        % Calculate slopes at the current position
        k1x = y(n);
        k1y = x(n) - 2*x(n)^3;

        % Calculate the half step position
        x_1h = x(n) + (dt/2)*k1x;
        y_1h = y(n) + (dt/2)*k1y;

        % Calculate slopes at the half step position
        k2x = y_1h;
        k2y = x_1h - 2*x_1h^3;

        % Calculate the full step position    
        x(n+1) = x(n) + dt*k2x;
        y(n+1) = y(n) + dt*k2y;
    end
    
    % After RK2 calculation, compute the absolute error at t=3
    errors(i) = abs(x(end) - sech(3)); % 1.6938e-11
end

% Plotting the errors on a log-log plot
figure;
loglog(time_steps, errors, '-o'); % declaration of log log plot
xlabel('Δt (s)'); % x-axis label
ylabel('Absolute Error at t=3'); % y-axis label
title('Error Analysis for Runge-Kutta Method'); % title label
grid on;