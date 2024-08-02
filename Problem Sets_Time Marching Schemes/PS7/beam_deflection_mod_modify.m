% Define the function beam_deflection_mod_modify
function y = beam_deflection_mod_modify(x, q, EI_function)
    N = length(x); % Calculate the number of nodes
    A = zeros(N,N); % Initialize matrices A and b with zeros
    b = zeros(N,1);
    
    EI_values = EI_function(x); % Compute EI values at each node using the provided function
    
    % Boundary conditions for deflection at the ends (y=0)
    A(1,1) = 1;
    A(N,N) = 1;

    % Boundary conditions for moment at the ends (y''=0), using second order accurate differences
    A(2,1:3) = [1, -2, 1];
    A(N-1,N-2:N) = [1, -2, 1];
    
    for i = 3:N-2
        h1 = x(i) - x(i-1);
        h2 = x(i+1) - x(i);
        
        % Average EI for the interval
        EI_avg = (EI_values(i-1) + 2*EI_values(i) + EI_values(i+1)) / 4;
        
        % Populate the finite difference coefficients into matrix A
        A(i, i-1:i+1) = EI_avg * [-1/h1/h2, ...
                                   (1/h1 + 1/h2), ...
                                   -1/h1/h2];
    end
    
    % Compute load vector b for interior nodes
    for i = 3:N-2
        h1 = x(i) - x(i-1);
        h2 = x(i+1) - x(i);
        b(i) = q * ((h1 + h2) / 2); % Trapezoidal rule for load distribution
    end
    
    % Solve the system of equations
    y = A\b;
end
