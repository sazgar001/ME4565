clear; close all; clc;

%% Create the spatial domain
dx = 0.02;
x = 0:dx:1;
Nx = length(x);

%% Create the boundary temperatures (Dirichlet)
phi_L = 1;  

%% Create the diffusion coefficient
kappa = 0.1;

%% Create the d coefficient to populate matrix A
d = kappa/dx^2; %i didnt use this
sigma = 0.2;

%% Add heat source
q = exp((-1*(x-0.25).^2)/2*sigma^2);

%% Create the coefficient matrix A

A = zeros( Nx  , Nx  );

% Left BC (first row)
A(1, 1) = 1; % first row first column

% Interior coefficients
for i = 2:Nx-1 % Nx 6-1 gives 5 ; 2 to 5 interior
    A( i , i-1 ) = 1;  % phi_i-1
    A( i , i   ) = -2; % phi_i
    A( i , i+1 ) = 1;  % phi_i+1
end

% Right BC (last row)
A(Nx, Nx) = 1; % Nx representing 6 column
A(Nx, Nx-1) = -1;

%% Create the b vector
b = zeros(Nx,1);

b(1) = phi_L;  % Left boundary condition b-value

b(2:end-1) = -q(2:end-1)*dx^2/kappa;   % Interior b-values

b(Nx) = 0;   % Right boundary condition b-value or phi_R

%% Solve the system of equations A*phi=b
phi = A\b;

%% Plot the steady state temperature profile
plot(x,phi,'.-k','MarkerSize',20,'LineWidth',3);
xlabel('$$x$$','FontSize',20,'Interpreter','latex')
ylabel('$$\phi(x)$$','FontSize',20,'Interpreter','latex')

