% Homework 4 Problem 2 Part D 
clear; close all; clc;

% Set up the time parameters for the simulation
dt = 0.1; % Time step size
t  = 0:dt:3; % Time vector from 0 to 3 with increments of dt
nt = length(t); % Total number of time steps

% Number of iterations for the Crank-Nicolson solver within each time step
nIter = 10; 

% Initialize solution vectors for x and y with zeros
x_cn = zeros(nt,1); % x at each time step
y_cn = zeros(nt,1); % y (dx/dt) at each time step

% Set initial conditions for x and y
x_cn(1) = 1; % x at t=0
y_cn(1) = 0; % y (dx/dt) at t=0

% Begin the time-stepping loop for Crank-Nicolson method
for n = 1:nt-1
    % Initialize guesses for x and y at the next time step as the current values
    x_np1_guess = x_cn(n); % Initial guess for x at t_(n+1)
    y_np1_guess = y_cn(n); % Initial guess for y at t_(n+1)
    
    % Perform the specified number of iterations to solve for x and y at the next time step
    for j = 1:nIter
        % Calculate the function evaluations at the current and guessed next steps
        f_curr = x_cn(n) - 2 * x_cn(n)^3; % f(x_n, y_n)
        f_next = x_np1_guess - 2 * x_np1_guess^3; % f(x_(n+1), y_(n+1))

        % Apply the Crank-Nicolson formula for y
        y_np1_new = y_cn(n) + (dt/2) * (f_curr + f_next);

        % Apply the Crank-Nicolson formula for x
        x_np1_new = x_cn(n) + (dt/2) * (y_cn(n) + y_np1_new);

        % Update the guess for the next iteration
        x_np1_guess = x_np1_new; 
        y_np1_guess = y_np1_new;
    end
    
    % Update the solution vectors with the values at the end of the iterations
    x_cn(n+1) = x_np1_guess; 
    y_cn(n+1) = y_np1_guess;
end

% Plotting the Crank-Nicolson and analytical solutions for comparison
plot(t, x_cn, 'b-', 'LineWidth', 2); % Plot numerical solution from Crank-Nicolson
hold on; % Hold the plot for multiple series

% Compute and plot the analytical solution using the same time vector
x_analytic = sech(t); 
plot(t, x_analytic, 'k--', 'LineWidth', 2); % Plot analytical solution

% Add labels, title, and legend to the plot
xlabel('Time t'); % Label for the x-axis
ylabel('Solution x(t)'); % Label for the y-axis
title('Crank-Nicolson Iterative Solution vs Analytical Solution'); % Plot title
legend('Crank-Nicolson', 'Analytical sech(t)'); % Legend for the plot
hold off; % Release the plot hold
