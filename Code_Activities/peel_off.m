function [theta_return, t_return] = peel_off(alpha)

%% System Parameters
phi = pi/4;
V = 10;
mg = 60;
R = 1;

u_theta = V*cos(alpha);
%% Create the time variable
dt = 0.002;
t = [0];

%% Create the solution variable
theta = 0;
r = R;
ur = V*sin(alpha);

%% Perform the time marching
n = 1; 
while r(end) >= R

    %% Set the current state
    theta_n = theta(n);
    r_n = r(n);
    ur_n = ur(n);
    %% Calculate the k1
    k1_theta = u_theta/r_n;
    k1_r = ur_n;
    k1_ur = -mg*sin(phi);

    %% Calculate the half state
    theta_h = theta_n _dt/2*k1_theta;
    r_h = r_n + dt/2*k1_r;
    ur_h = ur_n + dt/2*k1_ur;

    %% Calculate the k2

    %% Calculate the n+1 state

    %% Store the n+1 state in the variables

    %% Plot the results