clear; close all; clc;

y_ini_lower = -.2;
y_ini_upper =  0;

%% Set Time parameters
dt = 0.01;
t  = 0:dt:4;
nT = length(t);

%% Create the periodic "Anonymous Function"
% An Anonymous Function is a function you create in line and is only
% accessible in the given file.

% -(sin(2pi*t)+2pi*cos(2pi*t))/(1+4pi^2);
f = @(t) -(sin(2*pi*t)+2*pi*cos(2*pi*t))/(1+4*pi^2);
plot(0:.01:1, f(0:.01:1))

%% Perform the shooting method iterations
for i = 1:10

    %% Create the solution variables
    x = zeros(nT,1);
    y = zeros(nT,1);

    %% Set the initial y value
    y_ini = (y_ini_lower+y_ini_upper)/2; 
    y(1) = y_ini; 

    %% Set the other initial conditions    
    x(1) = 0;

    %% Plot the periodic solution
    hold off
    plot(0:.001:1,f(0:.001:1),'k') % This plots the periodic solution
    hold on
    plot( x(1)  , y(1)  ,'.r','MarkerSize',20);
    
    %% Perform RK2 Implementation
    
    for n = 1:nT-1
        
        %% Set the current state
        x_n = x(n); % Current value of x
        y_n = y(n); % Current value of y
        t_n = t(n);

        % Calculate slope at present position (x_n, t_n)
        k1x = 1;
        k1y = y_n + sin(2*pi*x_n);

        % Calculate the half step position
        x_h = x_n + dt/2*k1x;
        y_h = y_n + dt/2*k1y;
        t_h = t_n + dt/2;
    
        % Calculate slope at half step position
        k2x = 1;
        k2y = y_h + sin(2*pi*x_h);
    
        % Calculate the full step position    
        x_np1 = x_n + dt*k2x;
        y_np1 = y_n + dt*k2y;
        t_np1 = t_n + dt;
    
        % Update position and time
        x(n+1) = mod(x_np1,1);
        y(n+1) = y_np1; 
        
        plot( x_np1  , y_np1  ,'.r','MarkerSize',20);
        drawnow;
    
    end    

    %% Update the initial value range based on the final value
   
    if y(end) > y_ini %overestimate the value
        y_ini_upper = y_ini; % set upper bound to initial guess
    else 
        y_ini_lower = y_ini;
    end

end