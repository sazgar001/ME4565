function HW1P2C

%% Set potential flow parameters
A = 1;
n = 2/3;

%% Create the spatial range in Cartesian coordinates
x = -1.1:.025:1.1;
y = -1.1:.025:1.1;

%% Create a grid of points
[X,Y] = meshgrid(x,y);

%% Convert from Cartesian to Polar coordinates
r = sqrt(X.^2 + Y.^2);
theta = myatan(Y,X);

%% Calculate the polar coordinate velocities
v_r = A * n * r.^(n-1) .* cos(n * theta);
v_theta = -A * n * r.^(n-1) .* sin(n * theta);

%% Convert the polar coordinate velocities to Cartesian velocities
v_x = -v_theta.* sin(theta) + v_r.*cos(theta) ;
v_y = v_theta.* cos(theta) + v_r.* sin(theta);

%% Plot the results
streamslice(X,Y,v_x,v_y,'k')
axis([-1 1 -1 1])
hold on;
fill([0 1 1 0 0],[-1 -1 0 0 -1],[.5 .5 .5])
box on

%% Label the figure
set(gca,'FontSize',16,'TickLabelInterpreter','latex');
xlabel('$$x$$','FontSize',24,'Interpreter','latex');
ylabel('$$y$$','FontSize',24,'Interpreter','latex');

end

function theta=myatan(y,x)

theta=0*x;

theta(x>0) = atan(y(x>0)./x(x>0));
theta(y>=0 & x<0) = pi+atan(y(y>=0 & x<0)./x(y>=0 & x<0));
theta(y<0 & x<0)  =-pi+atan(y(y<0 & x<0)./x(y<0 & x<0));
theta(y>0 & x==0) = pi/2;
theta(y<0 & x==0) = -pi/2;
theta(theta<0) = theta(theta<0) + 2*pi;

end