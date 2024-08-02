clear; close all; clc;

lambda_values = 0:.005:1; % range of lambda from 0 to 1 with increments of 0.005

for lambda = lambda_values
    initial_neg = lambda/2; %set initial condition of x0 negative
    initial_pos = lambda + (1-lambda)/2; %set initial condition of x0 positive
    trajectory_neg = discrete_map(initial_neg, lambda); % Trajectory for the negative initial condition on map
    trajectory_pos = discrete_map(initial_pos, lambda); % Trajectory for the positve initial condition on map

    % Plot unique values for each lambda separately
    figure(1);
    
    % Plot  values where the initial negative value of the trajectory for a specific lambda on the graph
    plot(lambda*ones(size(unique(trajectory_neg))), unique(trajectory_neg), '.g', 'MarkerSize', 16);
    hold on;
    
    % Plot  values where the initial positive value of the trajectory for a specific lambda on the graph
    plot(lambda*ones(size(unique(trajectory_pos))), unique(trajectory_pos), '.r', 'MarkerSize', 16);
end

% Title and labels for the plot
title('\textbf{Bifurcation Diagram}', 'FontSize', 26, 'Interpreter', 'latex'); %title of graph
ylabel('Final States', 'FontSize', 24, 'Interpreter', 'latex');
xlabel('λ', 'FontSize', 22, 'Interpreter', 'latex');

