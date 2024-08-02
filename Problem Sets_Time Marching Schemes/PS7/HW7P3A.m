% Problem 3 Part A
clear; close all; clc;

% Define the file paths and corresponding angles
filePaths = {'report-file-drag-data-2.5.out', 'report-file-drag-data-5.out', ...
             'report-file-drag-data-7.5.out', 'report-file-drag-data-10.out', ...
             'report-file-drag-data-12.5.out', 'report-file-drag-data-15.out'};
angles = [2.5, 5, 7.5, 10, 12.5, 15];

% Initialize arrays to store the final values of drag force and drag coefficient
finalD = zeros(1, length(angles));
finalCD = zeros(1, length(angles));

% Loop through each file
for i = 1:length(filePaths)
    % Read the data, skipping the first two lines of headers
    data = readtable(filePaths{i}, 'FileType', 'text', 'HeaderLines', 2, 'ReadVariableNames', false);

    % Extract the last drag coefficient (CD) and drag force (D) values
    finalCD(i) = data.Var2(end); % Assuming CD is in the second column
    finalD(i) = data.Var3(end);  % Assuming D is in the third column
end

% Plotting
figure;

% Drag Force vs. Angle Graph 
subplot(2, 1, 1);
plot(angles, finalD, 'o-');
xlabel('Angle α (degrees)');
ylabel('Drag Force (D)');
title('Drag Force vs. Angle α');
set(gca, 'XTick', 2.5:0.5:max(angles)); % Set x-axis ticks to increment by 0.5
grid on; % Add grid lines

% Drag Coefficient vs. Angle Graph
subplot(2, 1, 2);
plot(angles, finalCD, 'x-');
xlabel('Angle α (degrees)');
ylabel('Drag Coefficient (CD)');
title('Drag Coefficient vs. Angle α');
set(gca, 'XTick', 2.5:0.5:max(angles)); % Set x-axis ticks to increment by 0.5
grid on; % Add grid lines


