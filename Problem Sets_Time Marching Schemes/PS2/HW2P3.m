clear; close all; clc;

% Making all text files into a vector
txt_N = {'sim_1.txt', 'sim_2.txt', 'sim_3.txt', 'sim_4.txt'};

% Reynolds numbers corresponding to each simulation (added it to code since
% making code for each Re_value would be very tedious.
Re_values = [1, 10, 100, 1000];

%I used a similar for loop from my ME2355 lab since we needed to make multiple plots from lab reports
for i = 1:length(txt_N) 
    data = importdata(txt_N{i}); % Call the plotting function to represent each file.
    % In each loop iteration, the code works with a different file 
    % listed in the txt_N collection.

    % Identify the grid locations and the axial velocity from the simulation
    x = data.data(:, 2);
    y = data.data(:, 3);
    axialVel = data.data(:, 4);

    % Create the set of points where we want the data
    x_Vertex = 0:.03:3;
    y_Vertex = 0:.01:.2;

    [xGrid, yGrid] = meshgrid(x_Vertex, y_Vertex);

    % Use interpolation to determine the velocity at the grid points
    axVelGrid = griddata(x, y, axialVel, xGrid, yGrid);

    % Contour Plot
    figure;
    contourf(xGrid, yGrid, axVelGrid); %contourf shades the regions
    colorbar;
    title(['Axial Velocity Contour Plot (Re = ', num2str(Re_values(i)), ')']);
    xlabel('z(m)');
    ylabel('Radial Position (m)');
    
end
