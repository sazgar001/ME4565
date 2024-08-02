clear; close all; clc;

% Define the filenames of the simulation data
txt_N = {'k1report-file-heat-transfer.txt', 'k2report-file-heat-transfer.txt', 'k3report-file-heat-transfer.txt'};

% Create a figure for the combined line plot
figure;

% Colors for each plot for better visibility
colors = ['r', 'g', 'b']; % Assign a color for each file

% Iterate through each simulation
for i = 1:length(txt_N)
    data = importdata(txt_N{i}, ' ', 3); % Load data, skip the first 3 header lines

    % Time and flux data
    time = data.data(:, 2); % Flow-time
    bottomFlux = data.data(:, 3); % Bottom boundary heat flux
    topFlux = data.data(:, 4); % Top boundary heat flux

    % Plot bottom and top flux vs. time on the same graph with different colors
    subplot(2, 1, 1); % Bottom flux plot
    plot(time, bottomFlux, strcat(colors(i), '-'), 'DisplayName', ['Bottom Flux Sim ', num2str(i)]);
    hold on;
    
    subplot(2, 1, 2); % Top flux plot
    plot(time, topFlux, strcat(colors(i), '--'), 'DisplayName', ['Top Flux Sim ', num2str(i)]);
    hold on;
end

% Formatting the bottom flux plot
subplot(2, 1, 1);
title('Bottom Boundary Heat Flux vs. Time');
xlabel('Time (s)');
ylabel('Heat Flux (W/m^2)');
legend('Location', 'eastoutside', 'Orientation', 'vertical');

% Formatting the top flux plot
subplot(2, 1, 2);
title('Top Boundary Heat Flux vs. Time');
xlabel('Time (s)');
ylabel('Heat Flux (W/m^2)');
legend('Location', 'eastoutside', 'Orientation', 'vertical');
