clear; close all; clc;

% Set the parameters
A = 0.2; % Amplitude of noise
dx = pi / 40; % Step size
x = 0:dx:2*pi; % Domain including the endpoint for generating signals

% Generate the signals using the noisy_signal function
[phi, phi_noise] = noisy_signal(A, dx);

% Initialize derivatives, leaving out the first and last point
phi_deriv = zeros(1, length(x)-2);
phi_noise_deriv = zeros(1, length(x)-2);

% Compute the central differences for phi and phi_noise
for i = 2:length(x)-1
    phi_deriv(i-1) = (phi(i+1) - phi(i-1)) / (2*dx); % Central difference approximation of derivative for base signal
    phi_noise_deriv(i-1) = (phi_noise(i+1) - phi_noise(i-1)) / (2*dx); % Central difference approximation of derivative for noisy signal
end

% Compute the analytical derivative directly
dphi_dx_analytical = 0.5 * (cos(x(2:end-1)) + 2 * cos(2*x(2:end-1)));

% Calculate the absolute errors
errors_phi = abs(phi_deriv - dphi_dx_analytical);
errors_phi_noise = abs(phi_noise_deriv - dphi_dx_analytical);

% Calculate the average absolute errors
average_error_phi = mean(errors_phi);
average_error_phi_noise = mean(errors_phi_noise);

% Display the results
fprintf('Average absolute error for phi: %f\n', average_error_phi);
fprintf('Average absolute error for phi_noise: %f\n', average_error_phi_noise);

% Function to generate the noisy signal phi_noise based on phi
function [phi, phi_noise] = noisy_signal(A, dx)
    x = 0:dx:2*pi;  % Create the domain over the interval [0, 2π]
    phi = 0.5 * (sin(x) + sin(2*x)); % base signal phi using the given formula
    noise = rand(1, length(x)) * 2 * A - A; % random noise within the specified amplitude range
    phi_noise = phi + noise; % Add the noise to the base signal to create the noisy signal phi_noise
end
