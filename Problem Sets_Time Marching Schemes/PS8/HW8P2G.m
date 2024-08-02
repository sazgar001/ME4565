% Problem 2 Part G
clear; close all; clc; 

%% Spatial Discretization for Problem
dx = .2; % spatial step size.   
x = (0:dx:1)'; % Create a column vector of spatial points from 0 to 1.
nX = length(x); % Number of spatial points.

%% Time Discretization
dt = .1; % time step size.     
t = (0:dt:1)'; % Create a column vector of temporal points from 0 to 1.
nT = length(t); % Number of temporal points.

%% Other Parameters
c = .5; % wave speed.
alpha = c*dt/dx; % CFL #
phi_n = zeros(nX, 1); % Initialize the solution vector for time step n.

%% B matrix Backwards Approximation 
B = zeros(nX); % Initialize the B matrix.
B(1, 1) = 1-alpha; % Set the first row of B matrix.
B(1, nX-1) = alpha; % Periodic boundary condition.
for i = 2:nX
    B(i, i-1:i) = [alpha 1-alpha]; % Set the rest of B matrix using backward difference.
end

%% Time marching using Explicit Euler
phi_np1 = zeros(nX, 1); % Initialize the solution vector for time step n+1.
for n = 1:nT-1
    % b vector (does change with time)
    b = 10*exp(-(x-.5).^2/.1^2)*sin(2*pi*t(n)); % Define the source term.

    % Explicit Euler
    phi_np1 = B*phi_n + b; % Compute phi at time step n+1 using explicit Euler.
    phi_n = phi_np1; % Update the solution for the next time step.

    % Plot point
    plot(x, phi_n); % Plot the current solution.
    axis([0 1 -10 10]); % Set the axes limits.
    title('$$\phi(x)$$ vs. $$x$$', 'Interpreter', 'latex'); % Set the title with Greek letter using LaTeX.
    xlabel('$$x$$', 'Interpreter', 'latex'); % Set the x-axis label using LaTeX.
    ylabel('$$\phi(x)$$', 'Interpreter', 'latex'); % Set the y-axis label using LaTeX.
    drawnow; % Update the plot.
end
