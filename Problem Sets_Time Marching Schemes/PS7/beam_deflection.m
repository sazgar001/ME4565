function y = beam_deflection(x, q)
    EI = 1; % Given in the problem statement
    N = length(x);
    dx = x(2) - x(1);
    
    % Initialize coefficient matrix A and load vector b
    A = zeros(N, N);
    b = (q * dx^4 / EI) * ones(N, 1);  % Uniform distributed load
    
    % Populate interior points with fourth derivative coefficients
    for i = 3:N-2
        A(i, i-2:i+2) = [1 -4 6 -4 1];
    end
    
    % Boundary conditions for deflection at the ends
    A(1, 1) = 1;
    A(N, N) = 1;
    
    % Boundary conditions for second derivative (moment) at the ends
    A(2, 1:5) = [2 -5 4 -1 0] / dx^2;  % Approximate y''(0) = 0
    A(N-1, N-4:N) = [0 -1 4 -5 2] / dx^2;  % Approximate y''(L) = 0
    
    % Solve for deflection
    y = A\b;
end