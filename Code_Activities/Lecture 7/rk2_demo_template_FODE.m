clear; close all; clc;

%% Set Time parameters
dt = 0.5;
t  = 0:dt:1;
nT =  length(t);

%% Set Initial conditions
t_n = t(1);
x_n = 1;

%% Plot analytic solution
t_analytic = -.1:.001:1.1;
x_analytic = 2*exp(t_analytic)-t_analytic-1;
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
    k1 =  x_n + t_n;
   
    % Calculate the half step position
    x_h =  x_n + (dt/2)*k1;
    t_h = t_n + dt/2;
    p1 = plot([t_n t_h],[x_n x_h],'--r','LineWidth',2);
    p2 = plot(t_h,x_h,'.g','MarkerSize',60);

    % Calculate slope at half step position
    k2 = x_h + t_h;

    % Calculate the full step position    
    x_np1 = x_n + dt*k2;
    t_np1 = t_n + dt;
    plot([t_n t_np1],[x_n x_np1],'--g','LineWidth',2);
    plot(t_np1,x_np1,'.b','MarkerSize',60);

    % Update position and time
    x_n = x_np1;
    t_n = t_np1;
    pause
    delete(p1)
    delete(p2)
end

plot(t_np1,x_np1,'.r','MarkerSize',60);