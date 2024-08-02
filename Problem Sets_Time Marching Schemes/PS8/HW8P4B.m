% Problem 4 Part B
clear; close all; clc;

% Define the range of tank heights and the time step
H_values = 0.1:0.1:1.0;
dt = 0.02;
ts_values = zeros(length(H_values), 1); % Initialize an array to store spin-up times

% Loop over each height and call the spin_up_axial function
for i = 1:length(H_values)
    H = H_values(i);
    ts_values(i) = spin_up_axial(dt, H);
end

% Plot the spin-up time as a function of the tank height
figure; % Create a new figure
plot(H_values, ts_values, 'o-'); % Plot with circle markers and a line
xlabel('Height (H)'); % Label the x-axis
ylabel('Spin-up time (ts)'); % Label the y-axis
title('Spin-up time vs. Tank Height'); % Title for the plot
grid on; % Turn on the grid for easier reading
