clear ; close all ; clc;

%% System Parameters

dt = 0.01;
t = 0:dt:1;
nT = length(t);

R = 1;
V0 = 10;
V = exp(-t)*V0;

%% Create Solution Variable
theta = zeros(4,nT);

%% Set the initial conditions
theta(:,1)= [0; -pi/16; -pi/8; -3*pi/16];

%% Perform the time marching

for n = 1:nT-1
    
    %% Set the current state
    theta_n = theta(:,n);

    %% Determine the n+1 state
    theta_np1 = theta_n + dt*V(n)/R;

    %% Save the values in the solution variable
    theta(:, n+1) = theta_np1;

    %% Plot the results
    hold off
    plot(R*cos(0:pi/100:2*pi), R*sin(0:pi/100:2*pi), 'k');
    hold on
    plot(R*cos(theta(:,n+1)),R*sin(theta(:,n+1)), '.r', 'MarkerSize', 3);
    axis([-1.1 1.1 -1.1 1.1]);
    drawnnow;