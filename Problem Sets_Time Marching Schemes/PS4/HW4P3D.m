% Homework 4 Problem 3 Part D

clear; close all; clc;

% Define the spatial domain
R1 = 2; % Given in problem
R2 = 6; % Given in problem
delta_r = 0.01; % 
r = R1:delta_r:R2; % Create an array from R1 to R2 with spacing delta_r

% Define initial conditions
v1 = 2; % Initial velocity at R1
v1_prime = 0; % Initial derivative of velocity at R1

% Call Runge-Kutta function to solve for the velocity profile
v_theta = tc_rk2(r, v1, v1_prime);

% Plot the velocity profile as a function of r
figure; % Create a new figure
plot(r, v_theta, 'LineWidth', 2); % Plot v_theta against r
xlabel('Radius r'); % Label x-axis
ylabel('Velocity profile v_{\theta}(r)'); % Label y-axis
title('Velocity Profile v_{\theta}(r) as a function of r'); % Title for the plot
grid on; % Turn on the grid for the plot

% Find the value of Omega2 at R2
% Assuming that Omega is proportional to the velocity at the boundary,
% we take the last value of the velocity profile as Omega2
Omega2 = v_theta(end);

% Display the value of Omega2
fprintf('The value of Omega2 for the obtained solution is: %.4f\n', Omega2);
