clear; close all; clc;

%% Set spatial coordinates
dx = .025; %before was 0.25
x = (0:dx:1)';
Nx = length(x);

%% Set temporal coordinates

dt = 0.01; % change from 0.1
t = (0:dt:40)';

%% Set the advection speed
c = 0.1;

alpha = c*dt/2/dx;

%% Set left boundary condition (time-dependent)
phi_left = -sin(2*pi*c*t);

%% Create the temperature profile at t=0
phi_n = sin(2*pi*x);

%% Create the B Matrix for the EECS
B_EECS = zeros(Nx);

% Top row


% Interior points
for i = 2:Nx-1
    B_EECS(i,i-1) = alpha; 
    B_EECS(i,i)   = 1;
    B_EECS(i,i+1) = -alpha;
end

% Bottom row
B_EECS(Nx,Nx-1) = 2*alpha;
B_EECS(Nx,Nx)   = 1-2*alpha;

%% Create figure for plotting
figure
title(['$c \Delta t / \Delta x = $$' num2str(alpha)],'Interpreter','Latex','FontSize',20);
xlabel('$x$','FontSize',20,'Interpreter','latex')
ylabel('$\phi$','FontSize',20,'Interpreter','latex')
hold on;
p1 = plot(x,phi_n,'.-k','MarkerSize',20,'LineWidth',2,'DisplayName','FTCS');
p2 = plot(x,phi_n,'-r','LineWidth',2,'DisplayName','Analytic');
legend('FTCS','Analytic','Location','NorthEast')
       
%% Perform the time marching b/c PDE

for n = 1:length(t)-1
          
    b = zeros(size(phi_n));
    b(1) = phi_left(n+1);
    b(2:end) = 0;
    
    %% Apply the matrix equation
    phi_np1 = B_EECS*phi_n + b;
        
    
    %% Plot results
    if mod(n, 0.1/dt) == 0 % plot only every 0.1 interval
        delete(p1)
        p1 = plot(x,phi_np1,'.-k','MarkerSize',20,'LineWidth',2,'DisplayName','FTCS');
        delete(p2)
        p2 = plot_analytic(t(n+1),c);
        axis([0 1 -1.2 1.2])  
        box on
        pause(.1)
    end
    
    %% Update the value of phi
    phi_n = phi_np1;
end

function p2 = plot_analytic(t,c)

x_analytic = 0:.001:1;
phi_analytic = sin(2*pi*(x_analytic-c*t));
p2 = plot(x_analytic,phi_analytic,'-r','LineWidth',2,'DisplayName','Analytic');

end


    