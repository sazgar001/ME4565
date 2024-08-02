% Define the time vector for the simulation
t = 0:0.01:10; % Time vector from 0 to 10 with a step of 0.01

% Constants for the simulation
k_over_m = 1; % Ratio of spring constant to mass, ensuring k/m remains constant
Cd = 2.5; % Damping coefficient
masses = [0.1, 0.5, 1, 2, 10]; % Array of different mass values to simulate

% Loop over each mass value to perform simulations
for m = masses
    % Calculate the spring constant k for the current mass to maintain constant k/m ratio
    k = k_over_m * m;

    % Call the linear model function for the current mass
    [x_linear, v_linear, u_linear] = block_cn_linear(t, m, k, Cd);

    % Call the nonlinear model function for the current mass
    [x_nonlinear, v_nonlinear, u_nonlinear] = block_cn_nonlinear(t, m, k, Cd);

    figure; % Create a new figure for plotting
    
    % Create a subplot for position comparison
    ax1 = subplot(2,1,1); % Create a subplot for position (first of two vertical plots)
    plot(t, x_linear, 'b-', t, x_nonlinear, 'r--'); % Plot both linear and nonlinear positions
    title(['Position Comparison for m = ', num2str(m)]); % Title for position plot
    xlabel('Time (s)'); % Label for the x-axis
    ylabel('Position (m)'); % Label for the y-axis
    legend('Linear Model', 'Nonlinear Model', 'Location', 'eastoutside'); % Legend to the right of the plot
    
    % Create a subplot for velocity comparison
    ax2 = subplot(2,1,2); % Create a subplot for velocity (second of two vertical plots)
    plot(t, v_linear, 'b-', t, v_nonlinear, 'r--'); % Plot both linear and nonlinear velocities
    title(['Velocity Comparison for m = ', num2str(m)]); % Title for velocity plot
    xlabel('Time (s)'); % Label for x-axis
    ylabel('Velocity (m/s)'); % Label for y-axis
    legend('Linear Model', 'Nonlinear Model', 'Location', 'eastoutside'); % Legend to the right of the plot

    % Adjust layout with a super title for figure
    sgtitle(['Linear vs Nonlinear Model for m = ' num2str(m)]); % Super title for overall comparison
end
