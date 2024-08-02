% Define the file name
filename = 'DataforPartA.txt';

% Read the file into a table
opts = detectImportOptions(filename);
opts.DataLine = 2; % Start reading data from line 2
data = readtable(filename, opts);

% Extract y-coordinates and x-velocities
y_coordinates = data{:, 3};
x_velocities = data{:, 5};

% Sort the data by y-coordinate
[y_coordinates, sorted_indices] = sort(y_coordinates);
x_velocities = x_velocities(sorted_indices);

% Perform the trapezoidal integration
volume_flux = trapz(y_coordinates, x_velocities);

% Display the result
fprintf('The volume flux through the outlet is: %.12f m^3/s\n', volume_flux);

% Plot the velocity profile
plot(y_coordinates, x_velocities);
title('Velocity Profile');
xlabel('Y-coordinate [m]');
ylabel('X-velocity [m/s]');
grid on; % Optional: add grid lines to the plot for better readability
