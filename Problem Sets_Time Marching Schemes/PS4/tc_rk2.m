% Homework 4 Problem 3 Part C
% Define a function to solve the initial value problem using the Runge-Kutta 2-step method
function v_theta = tc_rk2(r, v1, v1p)
    % r - array setting for interval and step size Delta r
    % v1 - initial condition for v0 at r = R1
    % v1p - initial condition for the derivative of v0 at r = R1, denoted as u
    % v_theta - approximated velocity profile vθ(r) -> for output
    
    % Calculate the step size by subtracting the second element of r from the first
    dr = r(2) - r(1);
    
    % Initialize the array for v_theta, which will hold the solution v0 at each step
    v_theta = zeros(size(r)); 
    % Initialize the array for u, which is the derivative of v0 with respect to r
    u = zeros(size(r)); 
    
    % Set the first element of v_theta to the initial condition v1
    v_theta(1) = v1;
    % Set the first element of u to the initial condition v1p
    u(1) = v1p;
    
    % Loop over the array r, stopping one element before the end
    for i = 1:length(r)-1

        k1v0 = u(i);         % Compute the slope k1 for v0 at the current step
        k1u = v_theta(i)/(r(i)^2) - u(i)/r(i);  % Compute the slope k1 for u at the current step based on the ODE
        v0_half = v_theta(i) + 0.5 * dr * k1v0; % Estimate v0 at the halfway point of the current step
        u_half = u(i) + 0.5 * dr * k1u;   % Estimate u at the halfway point of the current step
        r_half = r(i) + 0.5 * dr;         % Calculate the radius at the halfway point of the current step
        
        % Compute the slope k2 for v0 at the halfway point
        k2v0 = u_half;
        % Compute the slope k2 for u at the halfway point based on the ODE
        k2u = v0_half/(r_half^2) - u_half/r_half;
        
        % Use the slope k2 to estimate the next value of v0
        v_theta(i+1) = v_theta(i) + dr * k2v0;
        % Use the slope k2 to estimate the next value of u
        u(i+1) = u(i) + dr * k2u;
    end
end
