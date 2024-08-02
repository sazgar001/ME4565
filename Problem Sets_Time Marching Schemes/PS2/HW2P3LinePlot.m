clear; close all; clc;

% Making all text files into a vector
txt_N = {'sim_1.txt', 'sim_2.txt', 'sim_3.txt', 'sim_4.txt'};

% Create a figure for the combined line plot
figure;

% Iterate through each simulation
for i = 1:length(txt_N) 
    data = importdata(txt_N{i}); % Load data from each file

    % Identify the grid locations and the axial velocity from the simulation
    x = data.data(:, 2);
    y = data.data(:, 3);
    axialVel = data.data(:, 4);

    %% Create the set of points where we want the data
    x_Vertex = 0:.03:3;
    y_Vertex = 0:.01:.2;
    axVel = zeros(21,101);
    
    % Convert Cartesian coordinates to radial coordinates
    r = sqrt(x.^2 + y.^2);

    % Plot axial velocity vs. radial position on the same graph
    plot(axialVel, r, '-');
    hold on;
end

% Title and labels for the entire plot
title('Axial Velocity Profile at z=2 m');
xlabel('Axial Velocity (m/s)');
ylabel('Radial Position (m)');

% Add a legend indicating the Reynolds number for each line
legend('Re = 1', 'Re = 10', 'Re = 100', 'Re = 1000', 'Location', 'eastoutside', 'Orientation', 'vertical');

