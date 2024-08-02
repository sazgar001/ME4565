clear; close all; clc;

%% Plot the analytic solution

t = 0:0.001:1;
x_analytic =  log(t+1);
plot(t,x_analytic,'k','LineWidth',2)
hold on;
xlabel('$t$','FontSize',24,'Interpreter','latex')
ylabel('$x(t)$','FontSize',24,'Interpreter','latex')

%% Set the time parameters
dt = 0.5;
t  = 0:dt:1;
nt = length(t);

%% Set the number of iterations within each step
nIter = 10; %iterations to converge 

%% Create the solution variables
x_cn = zeros(nt,1);
y_cn = zeros(nt,1);

%% Set the initial conditions
x_cn(1) = 0;
y_cn(1) = 1; 
plot(t(1),x_cn(1),'.r','MarkerSize',20);
axis([0 1 0 1])

%% Perform the Crank-Nicolson - Iterative approach

for n = 1:nt-1
    
    % Remove previous schematic sketches
    if n>1; delete(ps0); delete(ps1); delete(ps2); delete(ps3); delete(ps4); delete(ps5); end
    
    % Set the current state
    x_n = x_cn(n);
    y_n = y_cn(n);
    t_n = t(n);
    
    % Plot current position    
    ps0 = plot(t_n,x_n,'.r','MarkerSize',60);
    plot(t_n,x_n,'.r','MarkerSize',30);
    
    % Calculate the current slope approximation
    fx_n = y_n;
    fy_n = -y_n^2;

    % Plot the current state slope approximation
    t_s = t_n-dt/2:.01:t_n+dt/2;
    x   = fx_n*(t_s-t_n)+x_n;
    ps2 = plot(t_s,x,'r','LineWidth',5);
        
    % Set the initial guess
    x_np1_guess = x_n;
    y_np1_guess = y_n;
    
    % Perform iterations of the Crank-Nicolson equation
    for j = 1:nIter
        
        % Remove skematic lines
        if j > 1; delete(ps3); delete(ps4); delete(ps5); end
        
        % Calculate slope approximation
        fx_np1_guess = y_np1_guess/2;
        fy_np1_guess = -y_np1_guess^2;

        % Perform iteration of Crank-Nicolson
        gx_n = (fx_n + fx_np1_guess)/2;
        gy_n = (fy_n + fy_np1_guess)/2;
        
        x_np1_new = x_n + dt*gx_n;
        y_np1_new = x_n + dt*gy_n;
                
        % Plot skematic lines
        t_s = t(n+1)-dt/2:.01:t(n+1)+dt/2;
        x = fx_np1_guess*(t_s-t(n+1))+x_np1_guess;
        ps3 = plot(t_s,x,'g','LineWidth',1);        
        ps4 = plot(t(n+1),x_np1_guess,'xg','MarkerSize',10);     
        ps5 = plot(t(n+1),x_np1_new,'.g','MarkerSize',30);                
        drawnow
        pause(0.1)
        
        % Update the guess value
        x_np1_guess = x_np1_new;
        y_np1_guess = y_np1_new;
        disp(num2str(x_np1_guess)); %values you getting on cmd
    end
    
    % Set the n+1 state based on the final iteration result
    x_np1 = x_np1_guess;
    y_np1 = y_np1_guess;

    % Store the n+1 value
    x_cn(n+1) = x_np1;
    y_cn(n+1) = y_np1;
    
    % Plot the result    
    plot(t_n+dt,x_np1,'.r','MarkerSize',30);
    ps1 = plot(t_n+dt,x_np1,'.b','MarkerSize',60);
    drawnow;                  
    
    pause
    
end
    
delete(ps0); delete(ps1); delete(ps2); delete(ps3); delete(ps4); delete(ps5);
        



