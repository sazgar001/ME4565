clear; close all; clc;

%% Set spatial coordinates

dx = 0.02; % 0.02;
x = (0:dx:1)';
Nx = length(x);

%% Set temporal coordinates

dt = 0.3; % 0.01;
t = 0:dt:40;

%% Set the wave speed
c = .1;

alpha = c*dt/dx;

%% Set the temperature profile initial condition

phi_n = sin(2*pi*x);

%% Create the A Matrix for the IEBS
A_IEBS = zeros(Nx);

% Top row incorporates periodicity
A_IEBS(1, 1) =  1+alpha;
A_IEBS(1, Nx-1) = -alpha ;% replace 4 with Nx-1
    
% For the rest of the points in the domain apply the FDE
for i = 2:Nx
    A_IEBS(i, i-1) = -alpha;
    A_IEBS(i, i) =  1+alpha;
end


%% Create figure for plotting
figure
title(['$$c \Delta t / \Delta x = $$' num2str(alpha)],'Interpreter','Latex','FontSize',20);
xlabel('$$x$$','FontSize',20,'Interpreter','latex')
ylabel('$$\phi$$','FontSize',20,'Interpreter','latex')
hold on;
p1 = plot(x,phi_n,'.-k','MarkerSize',20,'LineWidth',2,'DisplayName','FTBS');
p2 = plot(x,phi_n,'-r','LineWidth',2,'DisplayName','Analytic');
legend('BTBS','Analytic','Location','NorthEast')
       
%% Perform the time marching

for n = 2:length(t)
      
    b =  phi_n; % everywhere
    
    %% Apply the matrix equation (A*phi_np1 = b)
    phi_np1 = A_IEBS\b;
    
    
    %% Plot results
    if mod(n,0.1/dt)==0
    delete(p1)
    p1 = plot(x,phi_n,'.-k','MarkerSize',20,'LineWidth',2,'DisplayName','BTBS');
    delete(p2)
    p2 = plot_analytic(t(n),c);
    axis([0 1 -1.2 1.2])  
    box on
    pause(.1)
    end
        
    %% Update the value of phi
    phi_n = phi_np1;
    
end

function p2 = plot_analytic(t,c)

x_analytic = 0:.001:1;
phi_analytic = 0*x_analytic;
% phi_analytic(x_analytic>c*t & x_analytic<c*t+.002) = 1;
% phi_analytic(x_analytic+1>c*t & x_analytic+1<c*t+.002) = 1;
phi_analytic = sin(2*pi*(x_analytic-c*t));
p2 = plot(x_analytic,phi_analytic,'-r','LineWidth',2,'DisplayName','Analytic');

end


    