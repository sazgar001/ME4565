clear; close all; clc;

%% Set Time parameters
dt = 0.1; % Define the time step size
t  = 0:dt:3; % Define the time vector from 0 to 3 with steps of dt
nT = length(t); % Determine the number of time steps

%% Set Initial conditions
t_n = t(1); % Current time
x_n = 1; % Initial condition for x(t=0)
y_n = 0; % Initial condition for dx/dt(t=0), assuming y = dx/dt

% Initialize arrays to store the trajectory for plotting
x_trajectory = zeros(1, nT); % Array to store x values
x_trajectory(1) = x_n; % Set initial condition

y_trajectory = zeros(1, nT); % Array to store y values
y_trajectory(1) = y_n; % Set initial condition

%% Perform RK2 Implementation
for n = 1:nT-1
    % Calculate slopes at the current position
    k1x = y_n; % First slope for x, which is y because y = dx/dt
    k1y = x_n - 2*x_n^3; % First slope for y, which is the second derivative of x (ODE)
    
    % Calculate the half step position
    x_1h = x_n + (dt/2)*k1x; % Half-step for x
    y_1h = y_n + (dt/2)*k1y; % Half-step for y
    t_h = t_n + dt/2; % Half-step for time

    % Calculate slopes at the half step position
    k2x = y_1h; % Second slope for x, using values at the half step
    k2y = x_1h - 2*x_1h^3; % Second slope for y, using values at the half step

    % Calculate the full step position    
    x_np1 = x_n + dt*k2x; % Next position for x using the second slope
    y_np1 = y_n + dt*k2y; % Next position for y using the second slope
    t_np1 = t_n + dt; % Next time step

    % Store the computed values for plotting
    x_trajectory(n+1) = x_np1;
    y_trajectory(n+1) = y_np1;
    
    % Update position and time for the next iteration
    x_n = x_np1; % Update x to the new value
    y_n = y_np1; % Update y to the new value
    t_n = t_np1; % Update time to the new value
end

% Plot the x trajectory versus time
figure; % Create a new figure window
plot(t, x_trajectory, 'b-', 'LineWidth', 2); % Plot x versus t
xlabel('Time t', 'FontSize', 14); % Label the x-axis
ylabel('Position x(t)', 'FontSize', 14); % Label the y-axis
title('Position x(t) vs. Time using RK2 Method', 'FontSize', 16); % Title for the plot
grid on; % Turn on the grid
