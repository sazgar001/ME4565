% Problem 1 Part C
clear; close all; clc;

% Set up the domain and parameters
dx = 0.01;  % Spatial step size
x = 0:dx:1; % Spatial domain from 0 to 1
nX = length(x); % Number of points in the spatial domain
k = 1;      % Diffusion coefficient
U_values = [0, 2, 4]; % Advection velocities to consider

% Initialize the solutions matrix
phi_solutions = zeros(nX, length(U_values));

% Create the plot
figure; hold on; grid on;
colors = ['b', 'r', 'g']; % Colors for each plot line

% Loop over each advection velocity
for idx = 1:length(U_values)
    U = U_values(idx); % Current advection velocity
    
    % System of equations matrix and vector
    A = zeros(nX, nX); % Coefficient matrix
    b = zeros(nX, 1);  % Right-hand side vector
    
    % Fill in the matrix A based on finite difference approximation and advection term
    for i = 2:nX-1
        A(i, i-1) = -U/(2*dx) + k/dx^2;
        A(i, i)   = -2*k/dx^2;
        A(i, i+1) = U/(2*dx) + k/dx^2;
    end

    % Apply the Dirichlet boundary conditions
    A(1,1) = 1;     % phi(0) = 0
    A(nX,nX) = 1;   % phi(1) = 1
    b(1) = 0;       % corresponding b value for phi(0)
    b(nX) = 1;      % corresponding b value for phi(1)
    
    % Solve the system of linear equations
    phi_solutions(:, idx) = A\b;
    
    % Plot the current solution
    plot(x, phi_solutions(:, idx), [colors(idx) '.-'], 'MarkerSize', 20, 'LineWidth', 2);
end

% Configure the plot
xlabel('x', 'FontSize', 14);
ylabel('\phi(x)', 'FontSize', 14);
title('Advection-Diffusion Steady State Profile for Different U values', 'FontSize', 16);
legend('U=0', 'U=2', 'U=4', 'Location', 'south');
hold off;
