% Problem 3 Part C
clear; close all; clc;

% Given properties
nZ = 30;               % Number of nodes in z-direction
H = 1;                 % Tank height
Omega_w = 1;           % Wall angular velocity

% Discretization
dz = H / (nZ - 1);     % Step size
z = linspace(0, H, nZ)'; % Height positions array

% Since Omega(z) is constant and equals Omega_w, the solution is a horizontal line
omega_numerical = Omega_w * ones(nZ, 1); % Numerical solution

% Plot the numerical solution
plot(z, omega_numerical, 'b-', 'LineWidth', 2);
hold on; % Hold on for multiple plots on the same figure

% Plot the analytical solution (will overlay with numerical)
omega_analytic = Omega_w * ones(nZ, 1); % Analytical solution
plot(z, omega_analytic, 'r--', 'LineWidth', 2);

% Improve the appearance of the plot
title('Angular Velocity \(\omega(z) = \omega_w\)', 'Interpreter', 'latex', 'FontSize', 14);
xlabel('Height z', 'Interpreter', 'latex', 'FontSize', 12);
ylabel('Angular Velocity \(\omega(z)\)', 'Interpreter', 'latex', 'FontSize', 12);
ylim([0 2]); % Set y-axis limits
yticks(0:0.2:2); % Set y-axis ticks
grid on; % Add grid
set(gca, 'FontSize', 10); % Set axes font size

% Create legend
legend({'Numerical - \(\omega(z) = \omega_w\)', 'Analytical - \(\omega(z) = \omega_w\)'}, ...
       'Interpreter', 'latex', 'FontSize', 10, 'Location', 'best');

% Set figure size
set(gcf, 'Position', [100, 100, 600, 400]); % Set the figure size

% Finalize the plot
hold off; % Release the plot hold
