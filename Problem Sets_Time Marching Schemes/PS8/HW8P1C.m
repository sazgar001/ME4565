% Problem 1 Part C 
clear; close all; clc;

% Sets the number of iterations for the relaxation method to 10.
nIter =  10;

% Creates the spatial domain for the problem with a specified step size, and makes 'x' a column vector.
dx =  pi/30;
x  = (0:dx:pi)'; 
nX = length(x);

% Initializes the guess for the solution ('phi_g') that satisfies the given boundary conditions at x=0 and x=pi.
phi_g = -2/pi*x + ones(nX,1);

% Initializes the first and second derivative matrices, D1 and D2, without including boundary conditions yet.
D1 = zeros(nX,nX); % First derivative matrix with central difference, except at boundaries.
D2 = zeros(nX,nX); % Second derivative matrix with central difference, except at boundaries.

% Defines derivative approximations at the left boundary using forward difference.
D1(1, 1:3) = [-3 4 -1]/dx/2;
D2(1, 1:4) = [2 -5 4 -1]/dx^2;

% Sets up central difference approximations for interior points.
for i = 2:nX-1
    D1(i, i-1:i+1) = [-1 0 1]/dx/2;
    D2(i, i-1:i+1) = [1 -2 1]/dx^2;
end

% Defines derivative approximations at the right boundary using backward difference.
D1(nX, nX-2:nX) = [1 -4 3]/dx/2;
D2(nX, nX-3:nX) = [-1 4 -5 2]/dx^2;

% Iterates through the relaxation process to solve the BVP.
for i = 1:nIter
    
    % Constructs the 'A' matrix from the differential operators and the current guess, according to the specific problem.
    A = D2 + diag(2*D1*phi_g)*D1 + (ones(nX, 1) + diag(2*phi_g));
    
    % Constructs the 'b' vector, representing the right-hand side of the differential equation.
    b = ones(nX, 1) - D2*phi_g - (D1*phi_g).^2 - phi_g - phi_g.^2;
    
    % Modifies the 'A' matrix and 'b' vector to incorporate boundary conditions for the correction.
    A(1,:) = 0; A(1, 1) = 1; b(1) = 0; % Boundary condition at x=0.
    A(nX, :) = 0; A(nX, nX) = 1; b(nX) = 0; % Boundary condition at x=pi.
    
    % Solves the linear system A*zeta = b to find the correction 'zeta'.
    zeta = A\b;
    
    % Updates the guess by adding the correction 'zeta'.
    phi_g = phi_g + zeta;
    
    % Calculates the residual of the ODE to monitor convergence.
    R = D2*phi_g + (D1*phi_g).^2 + phi_g + phi_g.^2 - 1;
    res(i) = mean(abs(R(2:end-1))); % Ignores boundary points.
    
    % Plots the current guess and the updated guess for visualization, as well as the convergence of the residual.
    subplot(121);
    hold off
    plot(x,phi_g-zeta,'.-k','MarkerSize',30); % Previous guess
    hold on;
    plot(x,phi_g,'.-r','MarkerSize',10); % Updated guess
    xlabel('$x$','FontSize',20,'Interpreter','latex')
    ylabel('$\phi(x)$','FontSize',20,'Interpreter','latex')
    
    subplot(122);
    plot(1:i,res,'.k','MarkerSize',20);
    set(gca,'YScale','log')     
    xlabel('Iteration','FontSize',20,'Interpreter','latex')
    ylabel('Residual','FontSize',20,'Interpreter','latex')
    pause % Pauses the execution at each iteration to allow visualization of the plots.
end