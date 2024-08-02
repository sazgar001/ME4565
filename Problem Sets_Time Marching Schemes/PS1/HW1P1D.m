% Problem 1 Part d

clear; close all; clc;

% If we let gravity be g=10, the viscosity be nu= 0.1, and the film 
% thickness be W = 0.1. Determine the wall velocity needed to have zero
% net volume flux and plot the velocity profile.

g = 10; % acceleration due to gravity (m/s^2)
viscosity = 0.1; % viscosity (Pa·s)
W = 0.1; % film thickness (m)
x = linspace(0,W,100); %smoother plot and to declare x variable
% Calculate wall velocity from Part C
wallVelocity =  -(g * W^2) / (3 * viscosity); % Wall velocity [m/s]

% Calculate the velocity profile from Part A
velocityProfile = wallVelocity + (g/viscosity) .* (W .* x - (.5 * x.^2)); %Velocity Profile [m/s]

% Plot the velocity profile
plot(x, velocityProfile);
xlabel('Distance along the film (m)');
ylabel('Velocity (m/s)');
title('Velocity Profile in a Fluid Film');