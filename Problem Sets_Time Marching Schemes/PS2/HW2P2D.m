clear; close all; clc;

lambda_values = 0:.005:1;

for lambda = lambda_values
    %initializing variables and functions
    initial_neg = lambda/2;
    initial_pos = lambda + (1-lambda)/2;
    trajectory_neg = discrete_map(initial_neg, lambda);
    trajectory_pos = discrete_map(initial_pos, lambda);

    % Plot unique values for each lambda separately
    figure(1);
    
    % Plot values where the initial negative value of the trajectory for a specific lambda on the graph
    plot(lambda*ones(size(unique(trajectory_neg))), unique(trajectory_neg), '.g', 'MarkerSize', 16);
    hold on;
    
    % Plot values where the initial positive value of the trajectory for a specific lambda on the graph
    plot(lambda*ones(size(unique(trajectory_pos))), unique(trajectory_pos), '.r', 'MarkerSize', 16);

    % part d
    quadpos = (3 + 4*lambda + sqrt(16*lambda^2-40*lambda+9))/8;
    quadneg = (3 + 4*lambda - sqrt(16*lambda^2-40*lambda+9))/8;
    if lambda <= 1/4
        % Plot the fixed points only for λ values where they exist
        plot(lambda, 0, 'sr', 'MarkerSize', 6); % Fixed point 1
        plot(lambda, lambda-0.25, '.b', 'MarkerSize', 6); % Fixed point 2
        plot(lambda, quadpos, 'og', 'MarkerSize',6) %plotting quadratic positive fixed point
        plot(lambda, quadneg, 'oc', 'MarkerSize',6) %plotting quadratic negative fixed point
    else
        % Plot the fixed points only for λ values where they exist
        plot(lambda, 0, 'sr', 'MarkerSize', 6); % Fixed point 1
        plot(lambda, lambda-0.25, '.b', 'MarkerSize', 6); % Fixed point 2
    end
end

%plots from part c
plot(lambda_values, unique(trajectory_neg), 'om', 'MarkerSize', 8); 
plot(lambda_values, unique(trajectory_pos), '.r', 'MarkerSize', 8); 
set(gca, 'FontSize', 24, 'TickLabelInterpreter', 'latex');
title('\textbf{Bifurcation Diagram}', 'FontSize', 26, 'Interpreter', 'latex'); %title of graph
xlabel('λ', 'FontSize', 22, 'Interpreter', 'latex'); %labeling x-axis
ylabel('Final States', 'FontSize', 24, 'Interpreter', 'latex'); %labeling y-axis


