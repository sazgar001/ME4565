% Problem 4 Part D

clear; close all; clc;

%% Load Geometric Discretization in r spatial
r = load('r_nodes-1.mat').r; % Loads radial positions from a .mat file 
nR = length(r); % Calculates the number of radial positions.

%% Guess dt For Stability
dt_lower = 0; % Initializes the lower bound for the time step guess.
dt_upper = 60; % Initializes the upper bound for the time step guess.

%% Wall Angular Velocity
omega_w = 0; % Sets the angular velocity of the wall to 0.

%% Initial Angular Velocity
omega_ini = zeros(nR, 1); % Initializes the angular velocity array with zeros.
omega_ini(10) = 1; % Sets the angular velocity at the 10th radial position to 1.

%% Current Guess and Guess History
old_dt_guess = -1; % Sets a placeholder value for the initial previous guess.
station_dt_guess = (dt_lower + dt_upper)/2; % Calculates the initial guess for dt.

while ~ismembertol(station_dt_guess, old_dt_guess, 10^-3)
    % Loops until the current guess for dt is within a tolerance of the previous guess, indicating that a stable dt has been found.

    % Determine Angular Velocity
    [omega, t_s] = spin_up_radial(station_dt_guess, r, omega_ini, omega_w); % Calls the function 'spin_up_radial' with the current dt guess to compute the angular velocity profile.
   
    % Change Guess Bounds and Update Previous Guess
    if any(omega > 1)
        dt_upper = station_dt_guess; % If any angular velocity exceeds 1, decrease the upper bound for dt.
    else
        dt_lower = station_dt_guess; % If all angular velocities are below 1, increase the lower bound for dt.
    end

    % Update Guess and Guess History
    old_dt_guess = station_dt_guess; % Updates the previous dt guess.
    station_dt_guess = (dt_lower + dt_upper)/2; % Calculates a new dt guess as the midpoint between the current bounds.
end

disp(station_dt_guess); % Displays the determined stable time step.