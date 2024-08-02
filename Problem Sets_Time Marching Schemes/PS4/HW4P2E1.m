clear; close all; clc;

% Problem 2 Part E
% From Problem 2 Part B1 UPDATED Explicit Euler Method Script

% Initial conditions
x0 = 1; % Initial condition for x at t=0
y0 = 0; % Initial condition for y or dx/dt at t = 0

% Time step
dt = 0.1; % Time step size
t_final = 3; % Final time value
t = 0:dt:t_final; % vector of time pts from 0 to final time with steps of dt

x = zeros(length(t), 1); % Preallocate a column vector for x values with the same length as t
y = zeros(length(t), 1); % Preallocate a column vector for y values with the same length as t
x(1) = x0; % Set the first element of the x vector to the initial condition x0
y(1) = y0; % Set the first element of the y vector to the initial condition y0

% Explicit Euler solver loop
for n = 1:(length(t)-1) % Iterate through every time step except for the final one.
    % Update the state using the explicit Euler method
    y(n+1) = y(n) + dt * (x(n) - 2 * x(n)^3);  % Calculate y at the next time step
    x(n+1) = x(n) + dt * y(n);                 % Calculate x at the next time step based on y
end

% Compute the analytical solution using the same time vector
x_analytic = sech(t); 

% Plot the numerical solution
plot(t, x, 'r', 'LineWidth', 2); % Replace 'x' with x_trajectory for RK2 method
hold on;

% Plot the analytical solution
plot(t, x_analytic, 'k--', 'LineWidth', 2);

% Add labels, title, and legend to the plot
xlabel('Time t');
ylabel('Solution x(t)');
title('Euler Explicit Method Solution and Analytical Solution');
legend('Numerical Solution', 'Analytical Solution sech(t)');
hold off; % Release the plot hold
