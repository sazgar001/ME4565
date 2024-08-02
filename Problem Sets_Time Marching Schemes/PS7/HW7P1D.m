% Problem 1 Part D 
clear; close all; clc; 

%% Parameters
dx = 0.01; % Step size
L = 1; % Length of the domain
x = 0:dx:L; % Discretized spatial domain
nX = length(x); % Number of spatial points
k = 1; % Thermal conductivity
U = 4; % Convection coefficient
sigma = 0.2; % Width parameter of the heat source

%% Initialize the derivative matrices D1 and D2 with the correct shape
D1 = zeros(nX, nX); % First derivative matrix
D2 = zeros(nX, nX); % Second derivative matrix

%% Fill in the central differencing scheme for D1 and D2
for i = 2:nX-1
    D1(i, i-1:i+1) = [-1, 0, 1] / (2 * dx); % Central difference for first derivative
    D2(i, i-1:i+1) = [1, -2, 1] / (dx^2); % Central difference for second derivative
end

%% Initialize variables to store the results
maxTemp = -inf; % Initialize maximum temperature
bestX0 = 0; % Initialize optimal heat source position
phi_best = zeros(nX, 1); % Initialize best temperature profile

%% Loop over source positions
for x0 = 0:0.01:1
    % Heat source as a column vector
    q = 6 * exp(-(x - x0).^2 / (2 * sigma^2)).'; % Gaussian heat source profile
    
    % Create matrix A for the current x0 with the correct size
    A = U * D1 - k * D2; % Define the coefficient matrix A
    
    % Apply boundary conditions
    A(1, :) = 0; % Dirichlet boundary condition at x=0
    A(end, :) = 0; % Boundary condition at x=L
    A(1, 1) = 1; % Boundary condition for the first equation
    A(end, end) = 1; % Boundary condition for the last equation

    % Adjust the vector b for the source term and boundary conditions
    b = q; % 'q' is now a column vector due to the transpose
    b(1) = 0; % Dirichlet boundary condition at x=0
    b(end) = 1; % Boundary condition at x=L
    
    % Solve the system
    phi = A\b; % Solve the linear system
    
    % Check if we have a new maximum at x=0.5 
    tempAtCenter = phi(round(nX/2)); % Temperature at the center of the domain
    if tempAtCenter > maxTemp
        maxTemp = tempAtCenter; % Update maximum temperature
        bestX0 = x0; % Update optimal heat source position
        phi_best = phi; % Update best temperature profile
    end
end

% Plotting the profile
plot(x, phi_best, 'k', 'LineWidth', 2); % Plot temperature profile
hold on; 
plot(0.5, maxTemp, 'ro', 'MarkerSize', 8, 'LineWidth', 2); % Mark maximum temperature at center
hold off;
xlabel('x'); % Label x-axis
ylabel('\phi(x)'); % Label y-axis
title(['Temperature Profile with Optimal Heat Source Position at x_0 = ', num2str(bestX0)]); % Set title
legend('phi(x)', 'Max phi @ center', 'Location', 'NorthWest'); % Add legend
grid on; % Add grid to the plot
