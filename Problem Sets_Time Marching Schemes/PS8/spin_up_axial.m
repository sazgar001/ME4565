function t_s = spin_up_axial(dt, H)

% This is for 4A -> function named spin_up_axial with inputs dt (time step) and H (height)

%% Spatial Discretization
nZ = 51; % Number of vertical grid points
dz = H/(nZ-1); % Vertical spacing between grid points
z = (0:dz:H)'; % Vertical grid, from 0 to H, spaced by dz

%% Temporal Discretization
t = 0; % Start time
t_max = 60; % Maximum time to run the simulation

%% Various Problem Parameters
nu = .01; % Kinematic viscosity
alpha = nu*dt; % Alpha parameter for numerical scheme, scaled by time step
omega_w = 1; % Angular velocity at the wall
omega_state = omega_w; % Steady state angular velocity, set equal to wall velocity

%% Current State Angular Velocity
omega_n = zeros(nZ, 1); % Initialize angular velocity at all grid points to zero

%% Initial Condition
omega_n(1) = omega_w; % Set angular velocity at the first grid point (wall) to omega_w
omega_n(nZ) = omega_w; % Set angular velocity at the last grid point (wall) to omega_w

%% Second Derivative Matrix
D2 = zeros(nZ); % Initialize D2 matrix for calculating second derivatives
for i = 2:nZ-1
    D2(i, i-1:i+1) = [1 -2 1]/dz^2; % Populate D2 matrix with coefficients for finite difference approximation of second derivatives
end

%% A Matrix
A = zeros(nZ); % Initialize A matrix
A = -alpha*D2 + eye(nZ); % Define A matrix, incorporating diffusion term and identity for implicit scheme

%% Boundary Condition
A(nZ, :) = 0; % Set last row of A matrix to zero for boundary condition
A(nZ, nZ) = 1; % Set last element of A matrix to 1 for Dirichlet boundary condition at z=H
A(1, :) = 0; % Set first row of A matrix to zero for boundary condition
A(1, 1) = 1; % Set first element of A matrix to 1 for Dirichlet boundary condition at z=0

%% Implicit Euler Time Marching
while any(omega_n < .99*omega_state) && t < t_max
    % Loop until the solution is within 99% of the steady state or the maximum time is reached

    % b matrix
    b = zeros(nZ, 1); % Initialize b matrix
    b = omega_n; % Set b matrix equal to current state angular velocity

    % Next State Angular Velocity
    omega_np1 = A\b; % Calculate next state angular velocity using implicit Euler method
    omega_n = omega_np1; % Update current state angular velocity

    % Update time
    t = t + dt; % Increase time by time step
end

%% output spin up time
t_s = t; % Return the spin-up time

end
