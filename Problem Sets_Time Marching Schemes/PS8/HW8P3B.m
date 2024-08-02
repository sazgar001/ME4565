% Problem 3 Part B
clear; close all; clc;
% Given properties
nR = 30;               % Number of nodes including ghost point
R = 1;                 % Tank radius
Omega_w = 1;           % Wall angular velocity

% Discretization
dr = R / (nR - 1);     % Step size
r = linspace(0, R, nR)'; % Radial positions array

% Initialize the matrix A and vector b for the system A*omega = b
A = zeros(nR);         % Matrix A will hold the finite difference coefficients
b = zeros(nR, 1);      % Vector b is the right-hand side of the equation

% Fill in the finite difference coefficients into matrix A
for i = 2:nR-1
    A(i, i-1) = 1/dr^2 - 1/(2*dr*r(i));
    A(i, i) = -2/dr^2;
    A(i, i+1) = 1/dr^2 + 1/(2*dr*r(i));
end

% Neumann boundary condition at r=0 using ghost point
A(1, 1) = -3/(2*dr);
A(1, 2) = 2/dr;
A(1, 3) = -1/(2*dr);

% Dirichlet boundary condition at r=R
A(nR, nR) = 1;
b(nR) = Omega_w;

% Solve the system
omega = A\b;

% Plot the result
plot(r, omega, 'LineWidth', 2);
title('Angular Velocity \Omega(r) = \Omega_w');
xlabel('Radius r');
ylabel('Angular Velocity \Omega(r)');

% Set y-axis limits and ticks
ylim([0 2]); % Set the y-axis limits from 0 to 2
yticks(0:0.2:2); % Set the y-ticks from 0 to 2 with an interval of 0.2

grid on;
hold on;

% Analytical solution
omega_analytic = Omega_w * ones(nR, 1);
plot(r, omega_analytic, '--', 'LineWidth', 2);
legend('Numerical', 'Analytical');
