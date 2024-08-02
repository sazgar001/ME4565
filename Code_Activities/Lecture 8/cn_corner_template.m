clear; close all; clc;

%% Set the flow parameters
alph = 2;
theta_min = 0;
theta_max = pi*1/2;

%% Create base figure
base_figure(alph,theta_min,theta_max)

%% Set the time properties
dt = 0.01;
t = 0:dt:2;
nT = length(t);

%% Set number of iterations for Crank-Nicolson
nIter = 20;

%% Create the trajectory variables
r_traj = zeros(1,length(t));
theta_traj = zeros(1,length(t));

%% Set the initial conditions
r_traj(1) = 2.25;
theta_traj(1) = 0.95*theta_max;

h = plot(r_traj(1).*cos(theta_traj(1)),r_traj(1).*sin(theta_traj(1)),'.-r','MarkerSize',20,'LineWidth',2);

%% Time marching for loop
for n = 1:nT-1
   
    % Set the current position
    r_n     = r_traj(n);
    theta_n = theta_traj(n);
    
    % Calculate the current slope approximation
    ur_n     = alph*r_n^(alph-1)*cos(alpha*theta_n); 
    utheta_n = -alph*r_n^(alph-1)*sin(alpha*theta_n); 
    
    % Set the initial guess
    r_np1_guess = r_n;
    theta_np1_guess = theta_n;
    
    % Perform iterations of the Crank-Nicolson equation
    for j = 1:nIter
            
        % Calculate the velocity for the full step calculation    
        ur_np1_guess     = alph*r_np1_guess^(alph-1)*cos(alpha*theta_np1_guess); 
        utheta_np1_guess = -alph*r_np1_guess^(alph-1)*sin(alpha*theta_np1_guess);
        
        % Perform iteration of Crank-Nicolson
        g_r     = (ur_n+ur_np1_guess)/2;
        g_theta = (utheta_n/r_n+ utheta_np1_guess/r_np1_guess);
        
        r_np1_new     = r_n     + dt*g_r;
        theta_np1_new = theta_n + dt*g_theta;        
        
        % Update the guess value
        r_np1_guess     = r_np1_new;
        theta_np1_guess = theta_np1_new;
    end
    
    % Set the n+1 state based on the final iteration result
    r_np1     = r_np1_guess;
    theta_np1 = theta_np1_guess;
    
    % Add the values into the trajectory variables
    r_traj(n+1)     = r_np1;
    theta_traj(n+1) = theta_np1;
    
    % Plot the trajectory
    delete(h)
    h = plot(r_traj(1:n+1).*cos(theta_traj(1:n+1)),r_traj(1:n+1).*sin(theta_traj(1:n+1)),'.-r','MarkerSize',20,'LineWidth',2);
    drawnow
end


function base_figure(alph,theta_min,theta_max)
figure('Units','Pixels','Position',[0 0 800 800])

%% Create a grid in the r-theta plane
r_vector = .05:.05:3;
theta_vector = theta_min:pi/32:theta_max;

[r, theta] = meshgrid(r_vector,theta_vector);

%% Calculate the velocity components in polar
Ur = alph*r.^(alph-1).*cos(alph*theta);
Utheta = -alph*r.^(alph-1).*sin(alph*theta);

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
axis([-0.1+min(x(:)) max(x(:))+0.1 -0.1+min(y(:)) max(y(:))+0.1]);
xlabel('$$x$$','FontSize',20,'Interpreter','latex')
ylabel('$$y$$','FontSize',20,'Interpreter','latex')
set(gca,'FontSize',16,'TickLabelInterpreter','latex')
box on
% rectangle('Position',[-R -R 2*R 2*R],'Curvature',[1,1],...
%   'FaceColor', [0 0 .5], 'EdgeColor', 'none');

end








