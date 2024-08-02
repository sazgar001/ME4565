clear; close all; clc;

%% Plot the analytical solution
t_analytic = 0:.01:1; % Define time points for the analytical solution
x_analytic = exp(-0.5 * t_analytic.^2); % Calculate analytical solution
plot(t_analytic, x_analytic, 'k', 'LineWidth', 2); % Plot the analytical solution
hold on; % Hold the plot for further additions
set(gca, 'FontSize', 16, 'TickLabelInterpreter', 'latex') % Set plot properties
xlabel('$$t$$', 'FontSize', 24, 'Interpreter', 'latex') % Set x-axis label
ylabel('$$x(t)$$', 'FontSize', 24, 'Interpreter', 'latex') % Set y-axis label

%% Perform Explicit Euler Solver
dt = 0.1; % Set the time step
x_n = 1; % Set the initial condition 
t = 0:dt:1; % Create a list of times for approximating x

for n = 1:length(t)-1 % Loop over each time step
    t_n = t(n); % Current time
    
    % Explicit Euler step to get the next state
    x_np1 = x_n - dt * t_n * x_n;

    % Plot the step
    plot(t(n+1), x_np1, '.r', 'MarkerSize', 10);

    % Connect the dots with a red line
    plot([t_n, t(n+1)], [x_n, x_np1], '-r', 'LineWidth', 1);

    % Update the x_n (current state) values
    x_n = x_np1;
end

% Add legend with smaller font size
legend('Analytical Solution', 'Explicit Euler Method', 'Interpreter', 'latex', 'FontSize', 12);
title({'Analytical Solution & Euler Approximation x(t) vs t plot'}, 'FontSize', 14, 'Interpreter', 'latex');

% Display the approximate value of x(t=1)
disp(['Approximate value of x(t=1) using Euler method: ', num2str(x_n)]);

