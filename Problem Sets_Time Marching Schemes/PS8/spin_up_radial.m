function [omega, t_s] = spin_up_radial(dt, r, omega_ini, omega_w)

%% Understanding our function values
% inputs: time step 'dt', radial positions 'r', angular velocity 'omega_ini', and wall angular velocity 'omega_w'.
% The function returns the final angular velocity 'omega' and the spin-up time 't_s'.

%% Spatial Discretization
nR = length(r); % Calculates the number of radial positions.

%% Temporal Discretization
t = 0; % Initializes the time variable.
t_max = 60; % Sets the maximum simulation time.

%% Parameters
nu = .01; % Viscosity coefficient.
beta = nu*dt; % Pre-computed parameter for efficiency, incorporating the time step and viscosity.
omega_ss = omega_w; % Sets the steady state angular velocity equal to the wall angular velocity.

%% Current State Angular Velocity and initial condition
omega_n = omega_ini; % Initializes the angular velocity with the given initial condition.

%% A Matrix and the boundaries
A = eye(nR); % Initializes matrix A as an identity matrix of size nR.
A(1, :) = 0; % Sets the first row of A to zeros for boundary conditions.
A(1, 1:2) = [-1 1]/(r(2) - r(1)); % Applies a forward difference scheme for the inner boundary.
A(nR, :) = 0; % Sets the last row of A to zeros for boundary conditions.
A(nR, nR) = 1; % Ensures the outer boundary's angular velocity is unchanged (Dirichlet condition).

%% First and Second Derivative Matrix
D1 = zeros(nR); % Initializes the first derivative matrix.
D2 = zeros(nR); % Initializes the second derivative matrix.
for i = 2:nR-1
    dr = r(i) - r(i-1); % Calculates the differential radial distance.
    alpha = (r(i+1) - r(i))/(r(i) - r(i-1)); % Computes the non-uniform grid scaling factor.
    % Sets the coefficients for the first derivative central difference scheme.
    D1(i, i-1:i+1) = [-alpha/(1+alpha) (alpha-1)/alpha 1/(alpha+alpha^2)]/dr;
    % Sets the coefficients for the second derivative central difference scheme.
    D2(i, i-1:i+1) = [2/(1+alpha) -2/alpha 2/(alpha+alpha^2)]/dr^2;
end

%% B Matrix and its boundaries
B = zeros(nR); % Initializes matrix B.
B = beta*D2 + 3*beta*diag(1./r)*D1 + eye(nR); % Constructs B using the discretized viscous term and identity.
B(1, :) = 0; % Sets the first row of B to zeros for boundary conditions.
B(nR, :) = 0; % Sets the last row of B to zeros for boundary conditions.

% Explicit Euler Scheme for Time Marching
while any(omega_n <= .99*omega_ss) && max(abs(omega_n)) < 10 && t < t_max
    % Continues the loop until the angular velocity is near steady state, below a max value, or time exceeds max.

    b = zeros(nR, 1); % Initializes the source term vector for b matrix.
    b(1) = 0; % Sets the inner boundary condition.
    b(nR) = omega_w; % Sets the outer boundary angular velocity to the wall velocity.

    % Next State Angular Velocity
    omega_np1 = A\(B*omega_n + b); % Computes the next angular velocity state using the explicit Euler method.
    omega_n = omega_np1; % Updates the current angular velocity state.

    % Update time
    t = t + dt; % Increments the time by the time step.
end

% Output Angular Velocity and Spin Up Time
omega = omega_n; % Outputs the final angular velocity.
t_s = t; % Outputs the total spin-up time.
end
