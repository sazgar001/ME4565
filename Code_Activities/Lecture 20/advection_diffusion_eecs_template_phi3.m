clear; close all; clc;

%% Create spatial domain
dx = 0.02;
x = (0:dx:1)';
Nx = length(x);

%% Create time span
dt = 0.02;
t = 0:dt:100; %what if 100  when alph 1 to 1.25 it destabilizes
Nt = length(t);

%% Set the advection speed c and diffusion coefficient k
c = 0.1;
k = -0.0075; %do an anti diffusion maybe -> maybe binary search 

%% Create the alph=c*dt/dx and beta=k*dt/dx^2 coefficients
alph = c*dt/dx; 
beta = k*dt/dx^2;

%% Create the B matrix
B = zeros(Nx,Nx);

% Left Periodic Point (what column do we need to set these)
B(1,Nx-1) =  alph + beta; 
B(1,1)    =  1-alph-2*beta;      %(left most node, node 1)
B(1,2)    =  beta;

for i = 2:Nx-1    
    B(i,i-1) =  alph + beta; %c*dt/dx + k*dt/dx^2;
    B(i,i) =  -alph - 2*beta + 1; %theres a +1 b/c of phi n.
    B(i,i+1) =  beta; %no alph for phi_i_1 coefficient
end

% Right Periodic Point
B(Nx,Nx-1) =  alph+beta;% phi_(i-1) coef is   alph/2+beta
B(Nx,Nx)   =  1-alph-2*beta;% phi_(i)   coef is 1-2*beta
B(Nx,2) =  beta;% phi_(i+1) coef is  -alph/2+beta  -> +1 step to take us to second column


%% Create the phi variable
phi_n = zeros(Nx,1);

%% Set the initial condition

% Sin-Wave initial condition
%phi_n = sin(2*pi*x);

% DPA IC
phi_n = zeros(Nx,1);
phi_n(ceil(Nx/2)) = 1;
	 
%% Begin time marching

for n = 1:Nt-1
    
    %% Set the b vector;
    %b = -dt*phi_n.^3;  %add the source term phi^3 . comment it out for DPA
    
    %% Perform the matrix operation
    % Forward Time phi^np1 = B*phi^n + b
    phi_np1 = B*phi_n +b  ;
    
    %% Update the value of phi
    phi_n = phi_np1;

    %% Plot the results

    %if mod(t(n+1), 0.1) == 0 % Plot every DT=0.1
        hold off
        plot(x,phi_n,'.-k','MarkerSize',20,'LineWidth',2);
        hold on;
        
        % Analytic Sin-Wave Advection
        %plot(x,sin(2*pi*(x-c*t(n+1))),'r','LineWidth',2);

         % DPA Analytic Advection
         plot([0 mod(x(ceil(Nx/2))+c*t(n+1),1) mod(x(ceil(Nx/2))+c*t(n+1),1) mod(x(ceil(Nx/2))+c*t(n+1),1) 1], ...
           [0 0 1 0 0],'r','LineWidth',2);
        
        xlabel('$x$','FontSize',20,'Interpreter','latex')
        ylabel('$\phi(x)$','FontSize',20,'Interpreter','latex')
        title(sprintf('$t=%g$, $\\alpha = %g$, $\\beta = %g$, Max Value = %g', t(n+1), alph, beta, max(phi_n)), ...
          'FontSize',16,'Interpreter','latex')
        axis([0 1 -1.2 1.2])
        drawnow
    %end
    
end