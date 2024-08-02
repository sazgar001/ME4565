clear; close all; clc;

%% Set Time parameters
dt = 0.25;
t  = 0:dt:1;
nT =  length(t);

%% Set Initial conditions
t_n = t(1);
x_n = 1;
y_n = 0;

%% Plot analytic solution
t_analytic = -.1:.001:1.1;
x_analytic = cosh(t_analytic);
plot(t_analytic,x_analytic,'k','LineWidth',3)
hold on;
xlabel('$$t$$','FontSize',24,'Interpreter','latex')
ylabel('$$x(t)$$','FontSize',24,'Interpreter','latex')
set(gca,'FontSize',16,'TickLabelInterpreter','latex')

%% Perform RK2 Implementation

for n = 1:nT-1
    
    % Plot current position
    plot(t_n, x_n ,'.r','MarkerSize',60);

    % Calculate slope at present position (x_n, t_n)
    k1x =  y_n;
    k1y = x_n;  
    % Calculate the half step position
    
    x_1h =  x_n + (dt/2)*k1x;
    y_1h = y_n + (dt/2)*k1y;
    t_h = t_n + dt/2;
    p1 = plot([t_n t_h],[x_n x_h],'--r','LineWidth',2);
    p2 = plot(t_h,x_h,'.g','MarkerSize',60);

    % Calculate slope at half step position
    k2x = y_h;
    k2y = x_h;

    % Calculate the full step position    
    x_np1 = x_n + dt*k2x;
    y_np1 = y_n + dt*k2y;
    t_np1 = t_n + dt;
    plot([t_n t_np1],[x_n x_np1],'--g','LineWidth',2);
    plot(t_np1,x_np1,'.b','MarkerSize',60);

    % Update position and time
    x_n = x_np1;
    y_n = y_np1;
    t_n = t_np1;
    pause
    delete(p1)
    delete(p2)
end

plot(t_np1,x_np1,'.r','MarkerSize',60);