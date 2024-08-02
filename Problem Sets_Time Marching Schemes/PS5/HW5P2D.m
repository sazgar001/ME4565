clear; close all; clc;
% Set the parameters
A = 0.1; % Amplitude of noise is now set to 0.1
dx = pi/40; % Step size
gap_multipliers = 1:8; % i values from 1 to 8
errors_phi = zeros(1, length(gap_multipliers));
errors_phi_noise = zeros(1, length(gap_multipliers));

% Loop over each gap size
for i = gap_multipliers
    current_dx = i * dx;
    x = 0:current_dx:2*pi; % Adjust domain for current gap size

    % Generate the signals using the noisy_signal function
    [phi, phi_noise] = noisy_signal(A, current_dx);

    % Compute the central differences for phi and phi_noise
    % Initialize derivatives, considering the gap size
    phi_deriv = zeros(1, length(x)-2*i);
    phi_noise_deriv = zeros(1, length(x)-2*i);

    for k = i+1:length(x)-i
        phi_deriv(k-i) = (phi(k+i) - phi(k-i)) / (2*current_dx); % Central difference
        phi_noise_deriv(k-i) = (phi_noise(k+i) - phi_noise(k-i)) / (2*current_dx); % Central difference
    end

    % Analytic derivative of phi
    analytic_deriv = 0.5 * (cos(x(i+1:end-i)) + 2*cos(2*x(i+1:end-i)));

    % Calculate the absolute errors for phi and phi_noise
    errors_phi(i) = mean(abs(phi_deriv - analytic_deriv));
    errors_phi_noise(i) = mean(abs(phi_noise_deriv - analytic_deriv));
end

% Plotting the average absolute error as a function of gap size
figure;
plot(gap_multipliers*dx, errors_phi, 'b-o', 'LineWidth', 2);
hold on;
plot(gap_multipliers*dx, errors_phi_noise, 'r-o', 'LineWidth', 2);
hold off;
xlabel('Gap size (i * \Delta x)');
ylabel('Average Absolute Error');
title('Average Absolute Error vs. Gap Size');
% Set the legend below the graph and make it horizontal
legend('Error for \phi', 'Error for \phi_{noise}', 'Location', 'southoutside', 'Orientation', 'horizontal');
grid on;

% Function to generate the noisy signal phi_noise based on phi
function [phi, phi_noise] = noisy_signal(A, dx)
    x = 0:dx:2*pi;  % Create the domain over the interval [0, 2π]
    phi = 0.5 * (sin(x) + sin(2*x)); % Generate the base signal phi
    noise = rand(1, length(x)) * 2 * A - A; % Generate random noise
    phi_noise = phi + noise; % Create the noisy signal phi_noise
end
