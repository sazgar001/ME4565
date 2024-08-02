clear; close all; clc;

%% Create the mapping function plot and the x_n=x_n+1 line
plot([0 .5 1],[0 1 0],'k','LineWidth',3);
hold on;
plot([0 1],[0 1],'r','LineWidth',2);
xlabel('$$x_n$$','FontSize',24,'Interpreter','latex')
ylabel('$$x_{n+1}=F(x_n)$$','FontSize',24,'Interpreter','latex')
set(gca,'FontSize',16,'TickLabelInterpreter','latex')

%% Set the number of iterations
N = 60;

%% Create the variable x to store the values of the mapping
x = zeros(N,1);

%% Set the initial condition
x(1) = 0.4; 

%% Perform a for loop to execute the mapping
for n = 1:N-1
    %% Set the current state
    x_n = x(n); % Use "x_n" for the current state
    
    %% Perform the piecewise map to calculate x_np1 (x_(n+1))   
    % Use "x_np1" to represent the next state (the x_(n+1) state)
    if x_n <= 0.5
        x_np1 = 2 * x_n;
    else
        x_np1 = 2 * (1 - x_n);
    end
    
    %% Store the next state in the x-vector
    x(n+1) = x_np1;

    %% Plot the mapping plot
    plot([x_n x_n x_np1],[x_n x_np1 x_np1],'b');
    pause(0.5);
end

%% Plot the state as a function of iteration number (part e addition)
figure;
plot(1:N, x, '-o', 'LineWidth', 2);
xlabel('Iteration Number','FontSize',16);
ylabel('State','FontSize',16);
title('State as a Function of Iteration','FontSize',18);
grid on;