% Problem 4 Part E
clear; close all; clc;

%% Define the parameters
R_values = 0.1:0.1:1.0; % Range of tank radii
dt = 4e-5; % Time step
omega_w = 1; % Angular velocity at the wall
nZ = 51; % Number of vertical grid points
H = 1; % Height of the tank (assuming constant height for all radii)
ts_values = zeros(length(R_values), 1); % Initialize an array to store spin-up times

%% Loop over each radius
for idx = 1:length(R_values)
    R = R_values(idx);
    dz = H / (nZ - 1); % Vertical spacing between grid points
    z = linspace(0, H, nZ)'; % Vertical grid, from 0 to H
    
    % Initialize angular velocity profile for current radius
    omega_n = zeros(nZ, 1); % Current state angular velocity
    omega_n(1) = omega_w; % Set angular velocity at the wall to omega_w
    omega_n(end) = omega_w; % Set angular velocity at the top to omega_w (if it's the same as the wall)
    
    % Second Derivative Matrix for non-uniform grid scaled by radius
    D2 = zeros(nZ); % Initialize D2 matrix
    for i = 2:nZ-1
        r = R * (z(i) / H); % Scale the position by the radius
        D2(i, i-1:i+1) = [1 -2 1] / (dz^2 * r); % Scale coefficients by the non-uniform grid
    end
    
    % Define the A matrix for the implicit scheme
    nu = .01; % Kinematic viscosity
    alpha = nu * dt / (R^2); % Alpha parameter for numerical scheme
    A = -alpha * D2 + eye(nZ); % Define A matrix
    
    % Set boundary conditions in A matrix for top and bottom of the tank
    A(nZ, :) = 0;
    A(nZ, nZ) = 1;
    A(1, :) = 0;
    A(1, 1) = 1;
    
    %% Time loop
    t = 0; % Start time
    omega_state = omega_w; % Steady state angular velocity, set equal to wall velocity
    while any(abs(omega_n - omega_state) > 0.01 * omega_state) && t < 60
        % Implicit Euler Time Marching
        b = omega_n; % Set b equal to current state angular velocity
        omega_n = A\b; % Solve for next state
        t = t + dt; % Increase time by time step
    end
    
    % Record the spin-up time for the current radius
    ts_values(idx) = t;
    
    % Display the current radius and the computed spin-up time
    disp(['Radius: ', num2str(R), ' - Spin-up time: ', num2str(t)]);
end

% Plot spin-up time as a function of tank radius
figure;
plot(R_values, ts_values, 'o-');
xlabel('Radius (R)');
ylabel('Spin-up time (ts)');
title('Spin-up time vs. Tank Radius');
grid on;

% Ensure the figure stays open at the end of the script
disp('Plotting completed.');


