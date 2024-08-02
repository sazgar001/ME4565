% Problem 5 Part C

% Function block_cn_nonlinear with inputs for time vector, mass, stiffness, and damping coefficient
function [x, v, u] = block_cn_nonlinear(t, m, k, Cd)
    % Initialize arrays for positions (x), velocities (v), and background flow (u)
    N = length(t); % Determine the # of time steps based on the length of the time vector
    x = zeros(1, N); % Initialize position array with zeros
    v = zeros(1, N); % Initialize velocity array with zeros
    u = zeros(1, N); % Initialize background flow array with zeros for sin(2*pi*t)
    
    % Calculate the time step size based on the time vector
    dt = t(2) - t(1);
    
    % Calculate the background flow u(t) for each time step
    for i = 1:N 
        u(i) = sin(2 * pi * t(i)); % given in the problem
    end
    
    % Loop through each time step to calculate position and velocity
    for n = 1:N-1
        % Initial guess for v_{n+1} (could be v_n)
        v_guess = v(n);
        
        % Perform 10 iterations within each time step to solve for v_{n+1}
        for iter = 1:10
            % Calculate drag forces at time steps n and n+1
            Fd_n = Cd * (u(n) - v(n)) * abs(u(n) - v(n));
            Fd_np_1 = Cd * (u(n+1) - v_guess) * abs(u(n+1) - v_guess);
            
            % Implicit Crank-Nicolson formula for v_{n+1}
            v_new = v(n) + (dt/(2*m)) * (Fd_n - k*x(n)) + (dt/(2*m)) * (Fd_np_1 - k*x(n));
            
            % Update guess for v_{n+1}
            if abs(v_new - v_guess) < 1e-5 % Convergence criterion
                break;
            end
            v_guess = v_new; % make the v_guess the new value
        end
        
        % Update velocity and position for the next time step
        v(n+1) = v_guess; % based on part b derivation
        x(n+1) = x(n) + dt/2 * (v(n) + v(n+1)); % based on part b derivation 
    end
end
