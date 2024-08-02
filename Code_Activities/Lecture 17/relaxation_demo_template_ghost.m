clear; close all; clc;

%% Set the number of iterations for relaxation method
nIter =  10 ;

%% Create the domain
dx =  0.1; % change dx, be half step to be above the boundary. 
x  = (-dx/2:dx:1+dx/2)'; % modified for ghost point at both ends.
nX = length(x);

%% Create the guess function  
% This should satisfy the boundary conditions
% In this example phi(x=0) = 0; phi'(x=1) = 4;

phi_g = 4*x;

%% Create the derivative matrices
% Don't include any boundary conditions yet.

%%% Second derivative matrix (D2, O(dx^2))
D2 = zeros(nX,nX);

D2(1,1:4) = [2 -5 4 -1]/dx^2; % right sided
for i = 2:nX-1
    D2(i,i-1:i+1) = [1 -2 1]/dx^2; % central
end
D2(nX,nX-3:nX) = [-1 4 -5 2]/dx^2; % left sided

%% Loop through the iterations
for i = 1:nIter
    
    %% Create the A matrix
    % In this case that is (D2 + 2*diag(phi_g))
    
    A = D2-diag(2*phi_g); % The diag function creates a diagonal matrix with the diagonal values matching the input vector

    %% Create the b vector
    
    b = phi_g.^2-D2*phi_g; % so do finite differnce of d^2phig/dx^2m  OR do D2 phi_g
    
    %% Account for the boundary conditions of the correction
    % Since the original B.C. are satisfied by the guess, both B.C. for the correction are zero
    
    % Set zeta(x=0) = 0; -> Dirchilet Boundary Condition
    A(1,:) = 0; % Reset the entire coefficient matrix row to zero   : means all columns 
    A(1,1:2) = [1 1]/2; 
    b(1)   = 0;
    
    % Set zeta'(x=1) = 0; -> Neumman Boundary (right boundary condition)
    A(nX,:) = 0;
    A(nX,nX-1:nX) = [-1 1]/dx; % only accurate to order delta x 
    b(nX) = 0; % still needs to be averaged out to be 0. 
    
    %% Solve the matrix equation to get the correction
    
    zeta = A\b;
    
    %% Incorporate the correction into an updated guess 
    phi_g = phi_g + zeta;
    
    %% Calculate the ODE residual   
    R = D2*phi_g - phi_g.^2; % Based on the ODE you are solving for
    res(i) = mean(abs(R(2:end-1))); % No residual at boundary points, just interior
    
    %% Plot the results
    
    subplot(121);
    hold off
    plot(x,phi_g-zeta,'.-k','MarkerSize',30); % Previous guess
    hold on;
    plot(x,phi_g,'.-r','MarkerSize',10); % New guess
    xlabel('$x$','FontSize',20,'Interpreter','latex')
    ylabel('$\phi(x)$','FontSize',20,'Interpreter','latex')
    
    subplot(122);
    plot(1:i,res,'.k','MarkerSize',20);
    set(gca,'YScale','log')     
    xlabel('Iteration','FontSize',20,'Interpreter','latex')
    ylabel('Residual','FontSize',20,'Interpreter','latex')
    pause
    
end
    