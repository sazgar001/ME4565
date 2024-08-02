clear; close all; clc;
%make sure this plots
%% Plot the analytical solution

t_analytic = 0:.01:2*pi; %only used in this plotting solution not for euler
%t_analytic is a vector need to include a dot
x = cos(t_analytic);
plot(t_analytic,x,'k','LineWidth',2);
hold on;
set(gca,'FontSize',16,'TickLabelInterpreter','latex')
xlabel('$$t$$','FontSize',24,'Interpreter','latex')
ylabel('$$x(t)$$','FontSize',24,'Interpreter','latex')

%this should ideally what the result should look like. 
% control R comments everything. control t uncomments
%% Perform Explicit Euler Solver

dt = pi/4; %uf you do pi/40 or pi/400 it makes graph look way better
x_n = 1; % initial condition 
y_n = 0; % initial condition
t = 0:dt:2*pi; %create list of times for approximating x

for n =  1:length(t)-1% use length(t) to set the number of time steps (we want 4 loops based on our hand work iteration)
    %we have initial condition, we only need the times beyond zero. 4 loops
    %but really 3. 
    % Explicit Euler step to get next state
    
    %t_n = t(n); no need since t dont appear. 
    
    x_np1=x_n+dt*y_n;
    y_np1=y_n-dt*x_n;

   % Plot the step
   % plot (t,x_np1, '.r', 'MarkerSize',30); this is wrong because t is the
   % value of all time, so should be t_n

   plot (t(n+1),x_np1, '.r', 'MarkerSize',30); 
    
    % Update the x_n and y_n (current state) values
    x_n = x_np1;
    y_n = y_np1;
end