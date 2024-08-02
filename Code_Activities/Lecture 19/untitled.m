clear; close all; clc;

%% Create spatial domain
dx = 1/23; % Start with 1/7, then try 1/14, 1/21, 1/23, ... resolution
x = (0:dx:1)';
Nx = length(x);

%% Create time span
dt = 0.02;
t = 0:dt:2;
Nt = length(t);

%% Set the diffusion coefficient
kappa = 0.05;

%% Compute parameter beta
beta = (kappa*dt)/dx^2;

%% Create the A matrix
A = zeros(Nx,Nx);

% Left boundary condition
A(1,1)=1;

for i = 2:Nx-1 % Sets the coef. for the FDE
    A(i,i)=1; % as i varies for each row, we put it in proper column
end

% Right boundary condition 
A(Nx, Nx-1) = -1;
A(Nx, Nx) = 1;
% A(Nx,Nx-1:Nx) = [-1/dx 1/dx]; no need because right side is 0.
%% Create the B matrix
B = zeros(Nx,Nx);

% Left boundary condition
% Nothing for first row of matrix so just 0

for i = 2:Nx-1 % Sets the coef. for the FDE (interior of B matrix) (each row having beta, 1-2*beta, beta)
    B(i,i-1) = beta;
    B(i,i) = 1-2*beta;
    B(i,i+1) = beta;
end

% Right boundary condition
% All zeroes but we need an initial condition
%% Create the phi variable and set initial condition
phi_n = zeros(Nx,1);
phi_n(floor(Nx/2)) = 1; % floor rounds down 

%% Begin time marching for index n

for n = 1:Nt-1     
    
    %% Create the b vector    
    b = zeros(Nx,1); %we want little b to be a column vector. 
    b(1)=0;
    
    %% Calculate the solution at the new time step    
    phi_np1 = A\(B*phi_n+b);
    
    %% Update the value of phi    
    phi_n = phi_np1;
    
    %% Plot the results    
    plot(x,phi_n,'.-k','MarkerSize',20,'LineWidth',2);
    
    xlabel('$x$','FontSize',20,'Interpreter','latex')
    ylabel('$\phi(x)$','FontSize',20,'Interpreter','latex')
    title(['$\beta$ = ' num2str(beta)],'FontSize',20,'Interpreter','latex');
    axis([0 1 -1 1])
    pause;
end
    
    