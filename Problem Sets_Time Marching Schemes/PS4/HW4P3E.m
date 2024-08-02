% Homework 4 Problem 3 Part E 
clear; close all; clc;

% Define all parameters
R1 = 2; % Initial radius
R2 = 6; % Final radius
Omega1 = 1; % Initial angular velocity
Omega2 = 1/3; % Target angular velocity at R2
dr = 0.01; % Step size for the radius
r = R1:dr:R2;
OmegaGuess = -1; % Setting an initial value to be replaced once we iterate

% Boundary initial conditions
v1p_lower = -1;
v1p_upper = 1;

% Run the loop for exactly 100 iterations
for iter = 1:100
    % Velocity profile and bisecting function
    v1 = 2; % Guess for v1 initial condition
    v1p = (v1p_upper + v1p_lower)/2; % Compute midpoint for v1p search
    vtheta = tc_rk2(r, v1, v1p); % Compute the numerical solution from function.
    OmegaGuess = vtheta(end)/R2; % Calculate Omega at the final radius of R2
    
    % Adjusting bounds based on the comparison of OmegaGuess and Omega2
    if OmegaGuess < Omega2
        v1p_lower = v1p; % Update lower bound for v1p
    else
        v1p_upper = v1p; % Update upper bound for v1p
    end
end

% The value of v1’ leading to the solution
v1p_solution = (v1p_lower + v1p_upper) / 2;

% After 100 iterations, display the solution bounds of v1'
fprintf('After 100 iterations:\n');
fprintf('Leading solution lower bound of v1'': %.6f\n', v1p_lower);
fprintf('Leading solution upper bound of v1'': %.6f\n', v1p_upper);
fprintf('The value of v1’ leading to the solution is approximately: %.6f\n', v1p_solution);

% Plotting Graph
vtheta_analytic = (1/(R2^2-R1^2))*(R2^2*Omega2*(r-(R1^2./r)) - R1^2*Omega1*(r-(R2^2./r)));
plot(r, vtheta_analytic, 'k', 'LineWidth', 2);
hold on;
plot(r, vtheta, 'b.', 'MarkerSize', 10); % Plot numerical solution with blue dots
title('Tangential Velocity vs Radius for Analytic and Runge-Kutta Solutions');
xlabel('Radius (r)');
ylabel('Tangential Velocity v_{\theta}(r)');
legend({'Analytic Solution', 'Runge-Kutta 2nd Order Numerical Solution'}, 'Location', 'best');
grid on; % Added grid for better visualization
hold off;
