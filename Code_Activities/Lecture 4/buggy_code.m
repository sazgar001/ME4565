clear; close all; clc;

%% Generate base figure (no bugs)
figure; hold on;

x1 = 0:.001:.5;
f1 = 5*x1.*(.5-x1);
x2 = 0.501:.001:1.0;
f2 = 1 - 5*(1-x2).*(x2-.5);

plot(x1,f1,'k','LineWidth',2)
hold on;
plot(x2,f2,'k','LineWidth',2)
plot([0 1],[0 1],'r','LineWidth',1)
box on;
set(gca,'FontSize',20,'TickLabelInterpreter','latex')
xlabel('$$x_n$$','FontSize',20,'Interpreter','latex')
ylabel('$$x_{n+1}=F(x_n)$$','FontSize',20,'Interpreter','latex')

%% Perform 10 loops of the piecewise map

% Start with a random initial condition in [0,1] (check function rand)
x_n = rand(1,1);

for iter = 1:10    
    
    % Perform map    
    if x_n <= 1/2 
        x_np1 = 5*x_n*(.5-x_n);
    else
        x_np1 = 1 - 5*(1-x_n)*(x_n-.5); 
    end
    
    
    % Update map plot    
    plot([x_n x_n x_np1],[x_n x_np1 x_np1],'b','LineWidth',2);    
    drawnow;
    
     x_n = x_np1;
    
end