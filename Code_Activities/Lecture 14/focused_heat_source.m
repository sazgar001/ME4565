clear; close all; clc;

%% Create the spatial domain
dx = 0.02;
x = 0:dx:1;
Nx = length(x);

%% Create the boundary temperatures (Dirichlet)
phi_R = 1; % 

%% Create the diffusion coefficient
kappa = 0.1;

%% Create the d coefficient to populate matrix A
d = kappa/dx^2;

%% Add heat source
q = 0.2;

%% Create the coefficient matrix A

A = zeros( Nx  , Nx  );

% Left BC (first row)
A(1, 1) = -1;
A(1, 2) = 1;

% Interior coefficients
for i = 2:Nx-1
    A( i , i-1 ) = 1;  % phi_i-1
    A( i , i   ) = -2; % phi_i
    A( i , i+1 ) = 1;  % phi_i+1
end

% Right BC (last row)
A(Nx, Nx) = 1; % Nx representing 6 column


%% Create the b vector
b = zeros(Nx,1);

b(1) = 0;  % Left boundary condition b-value

b(2:end-1) = (-1*q*dx*dx)/kappa;   % Interior b-values

b(Nx) = 1;   % Right boundary condition b-value

%% Solve the system of equations A*phi=b
phi = A\b;

%% Plot the steady state temperature profile
plot(x,phi,'.-k','MarkerSize',20,'LineWidth',3);
xlabel('$$x$$','FontSize',20,'Interpreter','latex')
ylabel('$$\phi(x)$$','FontSize',20,'Interpreter','latex')

