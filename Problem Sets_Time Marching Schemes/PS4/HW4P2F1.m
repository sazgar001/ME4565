clear; close all; clc;

% From Problem 2 Part B and E UPDATED Explicit Euler Script
% Array of time steps

time_steps = [0.1, 0.01, 1e-3, 1e-4, 1e-5];

% Initialize array to store errors
errors = zeros(size(time_steps));

% Analytical solution at t=3
x_analytic_at_3 = sech(3);

% Loop over each time step
for i = 1:length(time_steps) 
    dt = time_steps(i);
    t = 0:dt:3; % Update time vector based on current time step
    nT = length(t); % Update number of time steps
    
    % Initialize x and y for this dt
    x = zeros(nT, 1);
    y = zeros(nT, 1);
    x(1) = 1; % initial condition for x
    y(1) = 0; % initial condition for y (dx/dt at t=0)
    
    % Explicit Euler solver loop for the current dt
    for n = 1:(nT-1)
        y(n+1) = y(n) + dt * (x(n) - 2 * x(n)^3);
        x(n+1) = x(n) + dt * y(n);
    end
    
    % Compute the absolute error at t=3
    errors(i) = abs(x(end) - x_analytic_at_3); %  2.5390e-05
end

% Plot the absolute errors against time steps on a log-log plot
figure;
loglog(time_steps, errors, '-o'); % log log plot for errors
xlabel('\Delta t (s)'); % x-axis label
ylabel('Absolute Error at t=3'); % y-axis label
title('Error as a Function of Time Step (Explicit Euler)'); % title label
grid on;
