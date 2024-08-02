% Homework 3 Problem 2 Part D
% Initial conditions
x0 = 0;  % initial x position
y0 = 2;  % initial y position

% Time vector
t = 0:0.1:25;

% Call the euler_advect function
[xTraj, yTraj] = euler_advect(t, x0, y0);

% Generate meshgrid for streamlines
[x, y] = meshgrid(linspace(-10, 10, 20), linspace(-10, 20, 20));

% Define the velocity field based on your system's equations
u = -2 * y ./ (1 + y.^2).^2;
v = 2 * x ./ (1 + x.^2).^2;

% Plot streamlines with a specified color
figure;
hStreamlines = streamslice(x, y, u, v, 2); %use hStreamlines because streamslice would cause legend to have lines be same color
set(hStreamlines, 'Color', 'b');  % Set the color to blue

hold on;

% Scatter initial position
scatter(x0, y0, 'k', 'filled');

% Plot particle trajectory on top of streamlines
plot(xTraj, yTraj, 'r', 'LineWidth', 2);

% Set axis limits
axis([-4 4 -4 4]);%axis bounds first two are x and last two are y

title('Streamlines and Particle Trajectory'); %title of graph
xlabel('x'); %x-axis label
ylabel('y'); %y-axis label

% Specify legend entries and colors, place the legend outside at the
% bottom, set orientation to horizontal so it looks nice below x-axis ->
% had to look up how to set this legend up.
legend([scatter(x0, y0, 'k', 'filled'), hStreamlines(1), plot(xTraj, yTraj, 'r', 'LineWidth', 2)], 'Initial Position', 'Streamlines', 'Particle Trajectory', 'Interpreter', 'latex', 'FontSize', 12, 'Location', 'southoutside', 'Orientation', 'horizontal');

hold off;


