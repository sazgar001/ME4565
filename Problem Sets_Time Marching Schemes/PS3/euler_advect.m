function [xTraj, yTraj] = euler_advect(t, x0, y0)
%% Create our time step and number of time instances
dt = t(2) - t(1); % Calculation per time step
nT = length(t);   % Get # of time instances

%% Create the trajectory variables
xTraj = zeros(size(t)); % Initialize array for x trajectory
yTraj = zeros(size(t)); % Initialize array for y trajectory 

%% Set the initial condition
xTraj(1) = x0; % Initial x position set
yTraj(1) = y0; % Initial y position set

% Begin time marching 
% Loop over each time, starting from the first time instance
% and ending at the second-to-last time instance (nT-1)
% The for loop will help perform explicit Euler time integration
for n = 1:nT-1
   % Perform the explicit euler steps
   dx_divided_dt = -2 * yTraj(n) / (1 + yTraj(n)^2)^2;  % Calculate x time derivative
   dy_divided_dt = 2 * xTraj(n) / (1 + xTraj(n)^2)^2;    % Calculate y derivative

   xTraj(n+1) = xTraj(n) + dt * dx_divided_dt;  % Explicit Euler Eq for x
   yTraj(n+1) = yTraj(n) + dt * dy_divided_dt;  % Explicit Euler Eq for y
end



