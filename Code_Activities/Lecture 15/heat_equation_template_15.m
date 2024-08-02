clear; close all; clc;

%% Create the spatial domain
dx = 0.02;
x = (0:dx:1)'; % x changing row vector to column red vector
Nx = length(x);

%% Create the boundary temperatures (Dirichlet)
%phi_R = ;

%% Create the diffusion coefficient
kappa = 0.1;

%% Create the d coefficient to populate matrix A
d = kappa/dx^2; %i didnt use this
sigma = 0.2;

%% Add heat source
q = sin(2*pi*x); % all scalar no need for a dot

%% Create the coefficient matrix A

A = zeros( Nx  , Nx  );

% Left BC (first row) % Want to say phi1=0
%A(1, 1) = -2; % first row first column
%A(1, 2) = 1;
%A(1, Nx-1)= 1;   % end-1 is also acceptable


A(1,1) = 1; % just to set it to 0

% Interior coefficients
for i = 2:Nx-1 % Nx 6-1 gives 5 ; 2 to 5 interior
    A( i , i-1 ) = 1;  % phi_i-1
    A( i , i   ) = -2; % phi_i
    A( i , i+1 ) = 1;  % phi_i+1
end

% Right BC (last row)
A(Nx, 2) = 1;  % can hardcode the 2. 
A(Nx, Nx-1) = 1;
A(Nx, Nx) = -2; % Nx representing 6 column  


%% Create the b vector
b = zeros(Nx,1);
b(1)=0; % just to set it to 0
%b(1) = -q(1)*dx^2/kappa;  % Left boundary condition b-value

b(2:end-1) = -q(2:end-1)*dx^2/kappa;   % Interior b-values

b(Nx) = -q(Nx)*dx^2/kappa;   % Right boundary condition b-value or phi_R

%% Solve the system of equations A*phi=b
phi = A\b;

%% Plot the steady state temperature profile
plot(x,phi,'.-k','MarkerSize',20,'LineWidth',3);
xlabel('$$x$$','FontSize',20,'Interpreter','latex')
ylabel('$$\phi(x)$$','FontSize',20,'Interpreter','latex')

