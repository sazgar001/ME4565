clear; close all; clc; % Clear workspace, close all figures, and clear command window

%% Define our dependent variable properties
% no need to iterate
dx =  pi/200; % Step size in x direction
x = 0:dx:pi/2; % Define x values from 0 to pi/2 with step size dx
nX = length(x); % Number of points in x direction

%% Set the shooting method properties
nIter = 10; 
g_guess_lower = 0;
g_guess_upper = 10;
f_end_target = pi/2;

%% Plot the analytic function
% no need to iterate
f = sin(x) + cos(x) - 1; % Define the analytical function
plot(x,f, 'k', 'LineWidth',2); % Plot the analytical function
hold on; % Hold the current plot for overlaying

for iter = 1:nIter % 1 to number of iterations
    %% Calculate the initial slope guess (binary search)
    g_ini_guess = (g_guess_lower + g_guess_upper)/2;
    % Binary search - not just taking guess value midway between bounds
    % it updates our boundaries based on result. end of code mentions
    % need to evaluate final state and update the guess range

%% Creating our RK2 variables -> we want to reset each time run code
f_profile = zeros(nX, 1); % Initialize array to store f values
g_profile = zeros(nX, 1); % Initialize array to store g values

%% Set the initial conditions
f_profile(1) = 0; % Initial condition for f
g_profile(1) = g_ini_guess; %-> this should update for each iteration initial condition g

%% Perform the RK2 time marching scheme

    for n = 1:nX-1
    
        % Grab the current state 
        f_n = f_profile(n); % Current value of f
        g_n = g_profile(n); % Current value of g
        x_n = x(n); % Current value of x
    
        % Calculate the slopes at the current state
        dfdx_n = g_n; % Slope of f at current state
        dgdx_n = x_n - 1 - f_n; % Slope of g at current state
    
        % Perform the half step
        f_h = f_n + dx/2*dfdx_n; % Estimate of f at the half step
        g_h = g_n + dx/2*dgdx_n; % Estimate of g at the half step
        x_h = x_n + dx/2; % Updated x value at the half step
    
        % Calculate the slopes at the half state
        dfdx_h = g_h; % Slope of f at the half step
        dgdx_h = x_h - 1 - f_h; % Slope of g at the half step
    
        % Calculate the full step
        f_np1 = f_n + dx*dfdx_h; % Estimate of f at the next step
        g_np1 = g_n + dx*dgdx_h; % Estimate of g at the next step
    
        % Save the next step
        f_profile(n+1) = f_np1; % Store the updated value of f
        g_profile(n+1) = g_np1; % Store the updated value of g
    
    end
    
    plot(x,f_profile,'.-') % Plot the numerical solution
    title (['df/dx(x=0) =' num2str(g_ini_guess)])
    %% Evaluate the final state and update the guess range

    if f_profile(end) > f_end_target %overestimate the value
        g_guess_upper = g_ini_guess; % set upper bound to initial guess
    elseif f_profile(end) < f_end_target %underestimate the value
        g_guess_lower = g_ini_guess;
    else 
        break  % g_ini_guess is actual initial guess that we suppose to be using
    end
    pause

end

