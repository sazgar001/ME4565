clear; close all; clc;

%% Set the flow parameters
U = 2; 
R = 1/2;

%% Create base figure
base_figure(U,R)

%% Set the time properties
dt = 0.01;
t = 0:dt:2;
N = length(t)-1;

%% Create the stored trajectory variables
r_traj = zeros(1,length(t));
theta_traj = zeros(1,length(t));

%% Set the initial conditions
r_traj(1) = 1.25; % r(t=0)
theta_traj(1) = 31*pi/32; % theta(t=0)

h = plot(r_traj(1).*cos(theta_traj(1)),r_traj(1).*sin(theta_traj(1)),'.-b','MarkerSize',40,'LineWidth',2);

%% Time marching for loop
for i = 1:N
   
    % Set the current position
    r_n     = r_traj(i);
    theta_n = theta_traj(i);
    
    % Calculate the velocity for the half step calculation
    ur_n     = U*(1-(R^2)/(r_n^2))*cost(theta_n);
    utheta_n =-U*(1+(R^2)/(r_n^2))*sin(theta_n);
    k1r = ur_n;
    k1theta = utheta_n/r_n;
    
    % Calculate the half step position
    r_h     = r_n + (dt/2)*k1r;
    theta_h = theta_n + (dt/2)*k1theta;
    
    % Calculate the velocity for the full step calculation    
    ur_h     = U*(1-(R^2)/(r_h^2))*cost(theta_h);
    utheta_h =-U*(1+(R^2)/(r_h^2))*sin(theta_h); 
  
    k2r = ur_n;
    k2theta = utheta_h/r_h;
    % Calculate the full step position
    
    r_np1     = r_n + dt*k2r;
    theta_np1 = theta_n+dt*k2theta;
    
    % Add the values into the trajectory variables
    r_traj(i+1)     = r_np1;
    theta_traj(i+1) = theta_np1;
    
    % Plot the trajectory
    delete(h)
    h = plot(r_traj(1:i+1).*cos(theta_traj(1:i+1)),r_traj(1:i+1).*sin(theta_traj(1:i+1)),'.-r','MarkerSize',20,'LineWidth',2);
    drawnow
end


function base_figure(U,R)
figure('Units','Pixels','Position',[0 0 800 800])

%% Create a grid in the r-theta plane
r_vector = R:.05:2;
theta_vector = 0:pi/32:2*pi;

[r, theta] = meshgrid(r_vector,theta_vector);

%% Calculate the velocity components in polar
Ur = 1./r*U.*(r-R^2./r).*cos(theta);
Utheta = -U*(1+R^2./r.^2).*sin(theta);

%% Calculate the dr/dt and d theta/dt terms
drdt = Ur;
dthetadt = Utheta./r;

%% Convert the polar coordinates into Cartesian coordinates
x = r.*cos(theta);
y = r.*sin(theta);

%% Calcualte the velocity in Cartesian coordinates
u = drdt.*cos(theta) - r.*dthetadt.*sin(theta);
v = drdt.*sin(theta) + r.*dthetadt.*cos(theta);

%% Plot the Cartesian coordinates
quiver(x,y,u,v,'k')
hold on;
axis equal;
axis([-1.5 1.5 -1.5 1.5]);
xlabel('$$x$$','FontSize',20,'Interpreter','latex')
ylabel('$$y$$','FontSize',20,'Interpreter','latex')
set(gca,'FontSize',16,'TickLabelInterpreter','latex')
box on

end








