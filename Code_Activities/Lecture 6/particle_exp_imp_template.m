clear; close all; clc;

%% Create the griddeds data for the streamlines
[X_grid, Y_grid] = meshgrid(-1:.2:1,-1:.2:1);
U_grid = Y_grid - X_grid; % u = y-x
V_grid = -X_grid; % v = -x

%% Create our time step and time variable
%(start with dt=0.1 and t<=20)
dt = 0.1;
t = 0:dt:20;
nT = length(t);

%% Create our explicit and implicit time history arrays
x_exp =  zero (nT,1);
y_exp =  zero (nT,1);

x_imp = zero (nT,1);
y_imp = zero (nT,1);

%% Set the initial condition
%(start with x0=-0.5, y0=0.5)
x_exp(1) = -0.5;
y_exp(1) = 0.5;

x_imp(1) = -0.5;
x_imp(1) = -0.5;

%% Begin time marching
for n = 1:nT-1
    
    %% Implement the explicit method
 
    x_n = x_exp(n);
    y_n = y_exp(n); 

    % X_n+1
    x_np1 = x_n + dt*(y_n-x_n);

    % Y_n+1
    y_np1 = y_n - dt*(x_n);

    x_exp(n+1) = x_np1;
    y_exp(n+1) = y_np1;
    
    %% Implement the implicit method
    x_n = x_imp(n);
    y_n = y_imp(n);
    % X_n+1
 
   
    x_np1 = (x_n + y_n*dt)/(1+dt+dt^2);

    % Y_n+1

    y_np1 = y_n -dt*(x_n+y_n*dt)/(1+dt+dt^2);

    x_imp(n+1) = x_np1;
    y_imp(n+1) = y_np1;
    
    %% Plot the trajectories for both methods
    hold off
    streamslice(X_grid,Y_grid,U_grid,V_grid)
    axis equal
    axis([-1 1 -1 1])
    box on
    hold on;
    plot(x_exp(1:n+1),y_exp(1:n+1),'.-r','MarkerSize',20,'LineWidth',2)
    plot(x_imp(1:n+1),y_imp(1:n+1),'.-b','MarkerSize',20,'LineWidth',2)
    xlabel('$$x$$','FontSize',24,'Interpreter','latex')
    ylabel('$$y$$','FontSize',24,'Interpreter','latex')
    set(gca,'TickLabelInterpreter','latex')
    drawnow;
    
end
