function y = beam_deflection_mod(x, q, EI_function)
 
    N = length(x); % Calculate the number of nodes
    dx = x(2) - x(1); % Calculate the step size between adjacent nodes
    
    % Initialize matrices A and b with zeros
    A = zeros(N,N);
    b = zeros(N,1);
    
    % Compute EI values at each node using the provided function
    EI_values = EI_function(x);

    % Interior nodes (central difference for the fourth derivative)
    for i = 3:N-2
        EI_avg = (EI_values(i-1) + 2*EI_values(i) + EI_values(i+1)) / 4; % Average EI value using central differencing
        A(i, i-2:i+2) = EI_avg * [1 -4 6 -4 1]; % Populate matrix A with coefficients for fourth derivative
    end
    
    % Applying the boundary conditions
    A(1,1) = 1; % y(0) = 0
    A(N,N) = 1; % y(L) = 0
    A(2,1:3) = EI_values(2) * [1 -2 1]; % y''(0) = 0
    A(N-1,N-2:N) = EI_values(N-1) * [1 -2 1]; % y''(L) = 0
    
    % Distributed load applied to the interior nodes
    b(3:N-2) = q * dx^4;
    y = A\b; % Solve the system of equations for y
end
