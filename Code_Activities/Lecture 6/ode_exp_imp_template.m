clear; close all; clc;

%% Create your time step and time array
dt = 0.05;
t = 0:dt:3 ;

%% Set the value of the constant c
c = -5;

%% Create the initial condition and the analytic solution
% dx/dt = c*x + t
x_analytic = (1+1/c^2)*exp(c*t) - t/c - 1/c^2;

%% Create our explicit and implicit map arrays
x_map_exp = zeros( 1, length(t) ); % ( number rows, number of columns)
x_map_imp = zeros( 1, length(t) );

%% Set the initial condition for both methods
x_map_exp(1) = 1; 
x_map_imp(1) = 1;

%% Begin time marching
for n = 1:length(t)-1
    
    %% Implement the explicit method
    x_n = x_map_exp(n);
    t_n = t(n);
    x_map_exp(n+1) = x_n + dt*(c*x_n+t_n);
    
    %% Implement the implicit method
    x_map_imp(n+1) = x_map_imp(n) + dt*(t_n+dt))/(1-c*dt);
        
    %% Plot the results
    subplot(121) % Results
    hold off
    plot(t,x_analytic,'k');
    hold on;
    plot(t(1:n+1),x_map_exp(1:n+1),'.-r','MarkerSize',20,'LineWidth',2)
    plot(t(1:n+1),x_map_imp(1:n+1),'.-b','MarkerSize',20,'LineWidth',2)
    legend('Analytic','Explicit','Implicit','Location','NorthEast')
    xlabel('$t$', 'Interpreter', 'Latex')
    ylabel('$x$', 'Interpreter', 'Latex')
    drawnow;
    
    subplot(122) % Error compared to analytic
    hold off
    plot(t(1:n+1),abs(x_map_exp(1:n+1)-x_analytic(1:n+1)),'.-r','MarkerSize',20,'LineWidth',2)
    hold on;
    plot(t(1:n+1),abs(x_map_imp(1:n+1)-x_analytic(1:n+1)),'.-b','MarkerSize',20,'LineWidth',2)
    legend('Explicit','Implicit','Location','NorthEast')
    xlabel('$t$', 'Interpreter', 'Latex')
    ylabel('abs(error)', 'Interpreter', 'Latex')
    set(gca,'YScale','log')
    drawnow;
    
end
