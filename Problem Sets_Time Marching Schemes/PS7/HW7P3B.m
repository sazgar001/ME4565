% Problem 3 Part B
clear; close all; clc;

% Define the file paths and corresponding angles
filePaths = {'report-file-drag-data-10-1.25W.out', 'report-file-drag-data-10-2.5W.out', ...
             'report-file-drag-data-10-3.75W.out', 'report-file-drag-data-10-5W.out'};
widthW = [1.25, 2.5, 3.75, 5];

% Initialize arrays to store the final values of drag force and drag coefficient
finalD = zeros(1, length(widthW));
finalCD = zeros(1, length(widthW));

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
plot(widthW, finalD, 'o-');
xlabel('Width W (cm)');
ylabel('Drag Force (D)');
title('Drag Force vs. Width W');
set(gca, 'XTick', 1.25:0.25:max(widthW)); % Set x-axis ticks to increment by 0.25
grid on; % Add grid lines

% Drag Coefficient vs. Angle Graph
subplot(2, 1, 2);
plot(widthW, finalCD, 'x-');
xlabel('Width W (cm)');
ylabel('Drag Coefficient (CD)');
title('Drag Coefficient vs. Width W');
set(gca, 'XTick', 1.25:0.25:max(widthW)); % Set x-axis ticks to increment by 0.25
grid on; % Add grid lines


