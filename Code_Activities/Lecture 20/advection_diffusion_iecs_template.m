clear; close all; clc;

%% Create spatial domain
dx = 0.02;
x = (0:dx:1)';
Nx = length(x);

%% Create time span
dt = 0.05;
t = 0:dt:10;
Nt = length(t);

%% Set the advection speed c and diffusion coefficient k
c = 0.1;
k = 0;

%% Create the alph=c*dt/dx and beta=k*dt/dx^2 coefficients
alph = c*dt/dx; 
beta = k*dt/dx^2;

%% Create the A matrix
A = zeros(Nx,Nx);

% Left Periodic Point
A(1,Nx-1) =  -alph-beta;% phi_(i-1) coef is   alph/2+beta
A(1,1)    =  1+alph+2*beta;% phi_(i)   coef is 1-2*beta
A(1,2)    =  -beta;% phi_(i+1) coef is  -alph/2+beta

for i = 2:Nx-1    
    A(i,i-1) =  -alph-beta;% phi_(i-1) coef is   alph/2+beta
    A(i,i  ) =  1+alph+2*beta;% phi_(i)   coef is 1-2*beta
    A(i,i+1) =  -beta;% phi_(i+1) coef is  -alph/2+beta
end

% Right Periodic Point
A(Nx,Nx-1) =  -alph-beta;% phi_(i-1) coef is   alph/2+beta
A(Nx, Nx)   = 1+alph+2*beta ;% phi_(i)   coef is 1-2*beta
A(Nx, 2)    =  -beta;% phi_(i+1) coef is  -alph/2+beta


%% Create the phi variable
phi = zeros(Nx,1);

%% Set the initial condition

% Sin-Wave IC
phi_n = sin(2*pi*x);

% DPA IC
% phi = 
	 
%% Begin time marching

for n = 1:Nt-1
    
    %% Set the b vector;
    b = phi_n;
    
    %% Perform the matrix operation
    % Forward Time A*phi^np1 = b
    phi_np1 =  A\b ;
    
    %% Update the value of phi
    phi_n = phi_np1;

    %% Plot the results

    if mod(t(n+1), 0.1) == 0 % Plot every DT=0.1
        hold off
        plot(x,phi_n,'.-k','MarkerSize',20,'LineWidth',2);
        hold on;
        
        % Analytic Sin-Wave Advection
        plot(x,sin(2*pi*(x-c*t(n+1))),'r','LineWidth',2);

%         % DPA Analytic Advection
%         plot([0 mod(x(ceil(Nx/2))+c*t(n+1),1) mod(x(ceil(Nx/2))+c*t(n+1),1) mod(x(ceil(Nx/2))+c*t(n+1),1) 1], ...
%           [0 0 1 0 0],'r','LineWidth',2);
        
        xlabel('$x$','FontSize',20,'Interpreter','latex')
        ylabel('$\phi(x)$','FontSize',20,'Interpreter','latex')
        title(sprintf('$t=%g$, $\\alpha = %g$, $\\beta = %g$, Max Value = %g', t(n+1), alph, beta, max(phi)), ...
          'FontSize',16,'Interpreter','latex')
        axis([0 1 -1.2 1.2])
        drawnow
    end
    
end