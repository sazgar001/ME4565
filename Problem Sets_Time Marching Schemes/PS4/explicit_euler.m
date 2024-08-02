% Homework 4 Problem 1 Part C
% Define a function to perform the explicit Euler method
function x_explicit = explicit_euler(delta_t)
   
    % Initialize time and x variables
    t = 0; % Start time is set to 0
    x = 1; % Initial condition x(0) = 1 as given

    % Iterate until t reaches or exceeds 1
    while t < 1
        t_next = t + delta_t; % Calculate tentative next time to check for overshoot
        if t_next > 1 % Check if the next time step goes past t=1
            delta_t = 1 - t;  % Adjust delta_t for the final step to end exactly at t=1
        end

        % Update x using the explicit Euler formula: x_n+1 = x_n + delta_t * f(t_n, x_n)
        x = x + delta_t * (x + t); % Here, f(t_n, x_n) = x_n + t_n
        t = t + delta_t; % Update the time by the adjusted delta_t
                         % Increment current time by the time step delta_t
    end
    x_explicit = x;  % Output the approximate value of x at t=1
end

