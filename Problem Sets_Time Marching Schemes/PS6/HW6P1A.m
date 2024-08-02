clear; close all; clc; 
% Problem Set 6 Question 1 Part A
% This code I modified from matrix_fd_nonuniform_template.m

%% Defining stuff
phi_fun = @(x) sin(2*pi*x); % Define the function phi(x)
dphi_analytic_fun = @(x) 2*pi*cos(2*pi*x); % Define the analytical derivative of phi(x)
delta_x_values = [0.0001, 0.001, 0.01]; % Define the range of delta x values

%% For Loop Portion
for delta_x = delta_x_values % Create the spatial domain with the given resolution
    x = 0:delta_x:1; % Create a vector 'x' with points from 0 to 1 with step size 'delta_x'
    Nx = length(x); % Calculate the number of points in the domain
    phi = phi_fun(x)'; % Evaluate the function phi(x) at each point in 'x' and transpose to a column vector
    
    % Create the differentiation matrix D1 for a uniform grid and forward difference
    D1 = zeros(Nx, Nx); % Initialize the differentiation matrix D1 with zeros
    
    for i = 1:Nx-1
        D1(i, i) = -1/delta_x; % Assign the element (i, i) as -1/delta_x
        D1(i, i+1) = 1/delta_x; % Assign the element (i, i+1) as 1/delta_x
    end

    %% Handle the boundary condition at the end
    D1(Nx, Nx-1) = -1/delta_x; % Assign the element (Nx, Nx-1) as -1/delta_x
    D1(Nx, Nx) = 1/delta_x; % Assign the element (Nx, Nx) as 1/delta_x
    

    dphi = D1 * phi; % Calculate the derivative using the D1 matrix multiplication
    dphi_analytic = dphi_analytic_fun(x)'; % Evaluate the analytical derivative at each point in 'x' and transpose it to a column vector
    
    % Calculate the mean-absolute error
    mean_abs_error = mean(abs(dphi(1:Nx-1) - dphi_analytic(1:Nx-1))); % Calculate the mean absolute error between numerical and analytical derivatives
    
    % Output the mean-absolute error for the three levels
    fprintf('For delta x = %f, the mean-absolute error is %f\n', delta_x, mean_abs_error); % Display the mean absolute error for the current delta_x
    
end
