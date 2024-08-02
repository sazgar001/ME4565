% Homework 3 Problem 2 Part E
% Time vector
t = 0:0.1:25;

% Generate meshgrid for streamlines
[x, y] = meshgrid(linspace(-10, 10, 20), linspace(-10, 20, 20));

% Define the velocity field based on your system's equations
u = -2 * y ./ (1 + y.^2).^2;
v = 2 * x ./ (1 + x.^2).^2;

% Plot streamlines with a specified color
figure;
hStreamlines = streamslice(x, y, u, v, 2); %cannot make legends separate colors unless I use hstreamlines
set(hStreamlines, 'Color', 'b');  % Set the color to blue

hold on;

% Initialize a cell array to store trajectory data for each initial position
trajectoryData = cell(1, 3);

% Loop through different initial y positions
for i = 1:3 % loop will run 3 times to run each iteration aka the three points given
    
    % Call the euler_advect function for the current initial position
    [xTraj, yTraj] = euler_advect(t, x0, 1 + 0.5 * (i-1)); %inital y value changes each loop 1, 1.5, 2 respec
    
    % Plot particle trajectory on top of streamlines
    if i == 3
        % If initial position is (0, 2), plot in red
        plot(xTraj, yTraj, 'r', 'LineWidth', 2);
    elseif i == 2
        % If initial position is (0, 1.5), plot in dark green
        plot(xTraj, yTraj, 'g', 'LineWidth', 2);
    else
        % Otherwise, plot in blue aka (0,1)
        plot(xTraj, yTraj, 'b', 'LineWidth', 2);
    end
    
    % Save trajectory data in the cell array
    trajectoryData{i} = [xTraj; yTraj];
end

% Scatter initial position
scatter(x0, y0, 'k', 'filled');

% Set axis limits
axis([-4 4 -4 4]); % did not want a really large graph

title('Streamlines and Particle Trajectories'); %title of graph
xlabel('x'); % title of x-axis
ylabel('y'); % title of y-axis

% Specified legend entries and colors, place the legend outside at the
% bottom, set orientation to horizontal, and set two rows (one row is too
% big. Had to look up how to set this legend up since was not able to
% myself and it kept showing legend before with lines all of same color)

legend([hStreamlines(1), scatter(x0, y0, 'k', 'filled'), ...
        plot(trajectoryData{1}(1, :), trajectoryData{1}(2, :), 'LineWidth', 2), ...
        plot(trajectoryData{2}(1, :), trajectoryData{2}(2, :), 'g', 'LineWidth', 2), ...
        plot(trajectoryData{3}(1, :), trajectoryData{3}(2, :), 'r', 'LineWidth', 2)], ...
    'Streamlines', 'Initial Position', 'Particle Trajectory (0,1)', ...
    'Particle Trajectory (0, 1.5)','Particle Trajectory (0,2)','Interpreter', ...
    'latex', 'FontSize', 10,'Location', 'southoutside', 'Orientation', ...
    'horizontal', 'NumColumns', 2);

hold off;
