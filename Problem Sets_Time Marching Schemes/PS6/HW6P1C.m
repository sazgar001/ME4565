clear; close all; clc;

%% Define the function and its analytical derivative
phi_fun = @(x) sin(2*pi*x); % Define the function phi(x) = sin(2*pi*x)
dphi_analytic_fun = @(x) 2*pi*cos(2*pi*x); % Define the analytical derivative of phi(x)
delta_x_tilde_values = [0.0001, 0.001, 0.01]; % Define different values of delta_x_tilde

% For loop -> each delta_x_tilde, calculate the derivative and error
for delta_x_tilde = delta_x_tilde_values % Iterate over each delta_x_tilde value
    
    % Generate the non-uniform grid points
    x = (1 - cos(pi*(0:delta_x_tilde:1)))/2; % Generate non-uniform grid points using the cosine distribution
    Nx = length(x); % Calculate the number of elements in the x array
    phi = phi_fun(x)'; % Evaluate phi(x) at each x value and store it as a column vector
    

    D1 = zeros(Nx, Nx); % Initialize a square matrix of size Nx by Nx with all elements set to zero for D1
    h = diff(x); % Calculate the differences between consecutive grid points for non-uniform steps h
    
    % Central difference for interior points with non-uniform spacing
    for i = 2:Nx-1 % Iterate over interior points (excluding boundary points)
        h_minus = x(i) - x(i-1); % Calculate the left spacing
        h_plus = x(i+1) - x(i); % Calculate the right spacing
        D1(i, i-1) = -2/(h_minus*(h_minus+h_plus)); % Set the (i, i-1) element of D1
        D1(i, i) = 2/(h_minus*h_plus); % Set the (i, i) element of D1
        D1(i, i+1) = -2/(h_plus*(h_minus+h_plus)); % Set the (i, i+1) element of D1
    end
    
    % Coefficients for the first point using three-point forward difference formula
    D1(1,1) = (-11/6) / delta_x_tilde; % Set the (1, 1) element of D1
    D1(1,2) = 3 / delta_x_tilde; % Set the (1, 2) element of D1
    D1(1,3) = (-3/2) / delta_x_tilde; % Set the (1, 3) element of D1
    D1(1,4) = (1/3) / delta_x_tilde; % Set the (1, 4) element of D1
    
    % Coefficients for the last point using three-point backward difference formula
    D1(Nx,Nx) = (11/6) / delta_x_tilde; % Set the (Nx, Nx) element of D1
    D1(Nx,Nx-1) = -3 / delta_x_tilde; % Set the (Nx, Nx-1) element of D1
    D1(Nx,Nx-2) = (3/2) / delta_x_tilde; % Set the (Nx, Nx-2) element of D1
    D1(Nx,Nx-3) = (-1/3) / delta_x_tilde; % Set the (Nx, Nx-3) element of D1
    
    % Compute the derivative
    dphi = D1 * phi; % Compute the derivative using the differentiation matrix D1
    
    % Analytical derivative
    dphi_analytic = dphi_analytic_fun(x)'; % Evaluate the analytical derivative at each x value and store it as a column vector
    
    % Calculate the mean-absolute error excluding the first and last point
    mean_abs_error = mean(abs(dphi(2:end-1) - dphi_analytic(2:end-1))); % Calculate the mean absolute error between computed and analytical derivatives, excluding boundary points
    
    % Display results
    fprintf('For delta x tilde = %.4f, the mean-absolute error is %e\n', delta_x_tilde, mean_abs_error); % Print the delta_x_tilde value and the corresponding mean absolute error
end

