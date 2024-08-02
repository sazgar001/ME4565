clear; close all; clc;

% Problem 2 Part F
% From Problem 2 Part D UPDATED Crank-Nicolson Script

% Time steps to analyze
time_steps = [0.1, 0.01, 1e-3, 1e-4, 1e-5];
errors = zeros(size(time_steps)); % Initialize error storage

% Analytical solution at t=3
x_analytic_at_3 = sech(3);

% Number of iterations for the Crank-Nicolson solver within each time step
nIter = 10; 

% Loop over each time step
for i = 1:length(time_steps)
    dt = time_steps(i);
    t = 0:dt:3; % Update time vector
    nt = length(t); % Update number of time steps
    
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
    
    % Calculate absolute error at t=3
    errors(i) = abs(x_cn(end) - x_analytic_at_3); % 4.1162e-11
end

% Plot errors on a log-log plot
figure;
loglog(time_steps, errors, '-o');
xlabel('\Delta t (s)');
ylabel('Absolute Error at t=3');
title('Crank-Nicolson Method Error Analysis');
grid on;
