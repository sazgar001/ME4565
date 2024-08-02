% Problem 5 Part A 

% Function block_cn_linear with inputs for time vector, mass, stiffness, and damping coefficient

function [x, v, u] = block_cn_linear(t, m, k, Cd)

    % Initialize arrays for positions (x), velocities (v), and background flow (u)
    N = length(t); % Determine the # of time steps based on the length of the time vector
    x = zeros(1, N); % Initialize position array with zeros
    v = zeros(1, N); % Initialize velocity array with zeros
    u = zeros(1, N); % Initialize background flow array with zeros
    
    % Calculate the time step size based on the time vector
    dt = t(2) - t(1); % Used from Problem set 3
    
    % Set initial conditions for position and velocity aka x'
    x(1) = 0; % Initial position
    v(1) = 0; % Initial velocity
    
    % Calculate the background flow u(t) for each time step
    for i = 1:N
        u(i) = sin(2 * pi * t(i)); % Using u(t) = sin(2*pi*t)
    end
    
    % Loop through each time step to calculate position and velocity
    for n = 1:N-1
        u_n = sin(2 * pi * t(n)) + sin(2 * pi * t(n+1)); % Calculate the combined effect for the current 
                                                         % and next time steps for the driving force
        
        % Crank-Nicolson method to update position
        x(n+1) = x(n) + (dt / 2) * (v(n) + v(n+1)); % Derivation of x_n+1 from Question 4 Part a
        
        % Crank-Nicolson method to update velocity
        v(n+1) = (v(n)*(1 - (k*dt^2)/(4*m)) + (dt/(2*m))*Cd*u_n - (dt*k/m)*x(n)) / (1 + (k*dt^2)/(4*m));
    end
end

% Define the inputs as follows in the MATLAB command window in order to
% to make sure function works. 
% t = linspace(0, 10, 100); % Creates a vector of 100 time points from 0 to 10
% m = 1; % Mass of the block
% k = 20; % Spring constant
% Cd = 0.1; % Damping coefficient

% On command window, I have to type the function with these inputs
% [x, v, u] = block_cn_linear(t, m, k, Cd);