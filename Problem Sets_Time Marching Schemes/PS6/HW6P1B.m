clear; close all; clc;

%% Defining the function and its derivative
phi_fun = @(x) sin(2*pi*x); % Define the function phi(x) = sin(2*pi*x)
dphi_analytic_fun = @(x) 2*pi*cos(2*pi*x); % Define the analytical derivative of phi(x)
delta_x_values = [0.0001, 0.001, 0.01]; % Define different values of delta_x

%% For loop for each delta_x, calculate the derivative and error
for delta_x = delta_x_values % Iterate over each delta_x value
    x = 0:delta_x:1; % Generate an array of x values from 0 to 1 with step delta_x
    Nx = length(x); % Calculate the number of elements in the x array
    phi = phi_fun(x)'; % Evaluate phi(x) at each x value and store it as a column vector
    D1 = zeros(Nx, Nx); % Initialize a square matrix of size Nx by Nx with all elements set to zero
    
    % Central difference for interior points
    for i = 2:Nx-1 % Iterate over interior points (excluding boundary points)
        D1(i, i-1) = -1/(2*delta_x); % Set the (i, i-1) element of D1
        D1(i, i+1) = 1/(2*delta_x); % Set the (i, i+1) element of D1
    end
    
    % Second-order forward difference for the first point
    D1(1,1) = -3/(2*delta_x); % Set the (1, 1) element of D1
    D1(1,2) = 4/(2*delta_x); % Set the (1, 2) element of D1
    D1(1,3) = -1/(2*delta_x); % Set the (1, 3) element of D1
    
    % Second-order backward difference for the last point
    D1(Nx,Nx) = 3/(2*delta_x); % Set the (Nx, Nx) element of D1
    D1(Nx,Nx-1) = -4/(2*delta_x); % Set the (Nx, Nx-1) element of D1
    D1(Nx,Nx-2) = 1/(2*delta_x); % Set the (Nx, Nx-2) element of D1
    
    dphi = D1 * phi; % Compute the derivative using the differentiation matrix D1
    dphi_analytic = dphi_analytic_fun(x)'; % Evaluate the analytical derivative at each x value and store it as a column vector
    mean_abs_error = mean(abs(dphi(2:Nx-1) - dphi_analytic(2:Nx-1))); % Mean absolute error excluding the boundary points
    
    % Display results
    fprintf('For delta x = %.4f, the mean-absolute error is %e\n', delta_x, mean_abs_error); % Print the delta_x value and the corresponding mean absolute error
end
