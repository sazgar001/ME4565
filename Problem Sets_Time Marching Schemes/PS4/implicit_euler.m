% Homework 4 Problem 1 Part D
% Define a function to perform the implicit Euler method
function x_implicit = implicit_euler(delta_t)
    
    % Initialize time and x variables
    t = 0; % Start time is set to 0
    x = 1; % Initial condition x(0) = 1 as given
    
    % Iterate until t reaches or exceeds 1
    while t < 1 - delta_t % iterate up to the step before t=1
        t_next = t + delta_t;   % Update time to the next step
        x = (x + delta_t * t_next) / (1 - delta_t); % Update x using the implicit Euler formula
        t = t_next;   % Increment the current time by the time step delta_t
    end
    
    if t < 1     % Handle the last step to reach exactly t=1
        delta_t_last = 1 - t; % Calculate the remaining time step to reach exactly t=1
        
        % Update x for the last time step using the implicit Euler formula
        x = (x + delta_t_last * (t + delta_t_last)) / (1 - delta_t_last);
    end
    
    % Output the approximate value of x at t=1
    x_implicit = x;
end
