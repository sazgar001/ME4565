% Overall Sound Code Plot with Logarithmic Fit and Corrected Tick Marks

% Path to the Excel file
excel_file = 'dB_final.xlsx'; % You will need to provide the correct path to the file

% Define the sheet names explicitly including all RPM sheets (copied from txt files)
sheets = {'1000_receiver1', '1000_receiver2', '1000_receiver3', ...
          '3500_receiver1', '3500_receiver2', '3500_receiver3', ...
          '6000_receiver1', '6000_receiver2', '6000_receiver3', ...
          '8500_receiver1', '8500_receiver2', '8500_receiver3', ...
          '10000_receiver1', '10000_receiver2', '10000_receiver3', ...
          '12500_receiver1', '12500_receiver2', '12500_receiver3', ...
          '15000_receiver1', '15000_receiver2', '15000_receiver3'};

% Initialize arrays for the noise levels and RPMs for each receiver
receiver1_rpm = [];
receiver1_noise = [];
receiver2_rpm = [];
receiver2_noise = [];
receiver3_rpm = [];
receiver3_noise = [];

% Initialize array for integral noise levels
integral_noise_levels = zeros(1, length(sheets));
rpms = zeros(1, length(sheets)); % RPM values corresponding to each sheet

% Loop through each specified sheet, convert dB to linear scale, integrate and convert back to dB
for i = 1:length(sheets)
    sheet_name = sheets{i};
    
    % Extract RPM from sheet name
    underscore_idx = find(sheet_name == '_', 1, 'first');
    rpm_value = str2double(sheet_name(1:underscore_idx-1));
    rpms(i) = rpm_value;
    
    % Read the data from the current sheet
    data = readtable(excel_file, 'Sheet', sheet_name);
    
    % Extract SPL values (assuming they are in the second column)
    spl_values = data{:, 2}; % Adjust the column index if your data structure differs
    
    % Convert dB SPL to power ratio
    power_ratios = 10 .^ (spl_values / 10);
    
    % Sum the power ratios (kind of like trapezoidal sum)
    total_power = sum(power_ratios);
    
    % Convert the total power back to dB to get the integral noise level
    integral_noise_level = 10 * log10(total_power);
    integral_noise_levels(i) = integral_noise_level;
    
    % Output integral noise level to command window
    fprintf('Integral noise level for %s: %.2f dB\n', sheet_name, integral_noise_level);
    
    % Group data by receiver
    if contains(sheet_name, 'receiver1')
        receiver1_rpm = [receiver1_rpm, rpm_value];
        receiver1_noise = [receiver1_noise, integral_noise_level];
    elseif contains(sheet_name, 'receiver2')
        receiver2_rpm = [receiver2_rpm, rpm_value];
        receiver2_noise = [receiver2_noise, integral_noise_level];
    else
        receiver3_rpm = [receiver3_rpm, rpm_value];
        receiver3_noise = [receiver3_noise, integral_noise_level];
    end
end

% Ensure no zero or negative RPM values before applying logarithm
assert(all(receiver1_rpm > 0) && all(receiver2_rpm > 0) && all(receiver3_rpm > 0), ...
       'All RPM values must be positive for logarithmic fitting.');

% Fit the logarithmic model
log_receiver1_rpm = log(receiver1_rpm);
log_receiver2_rpm = log(receiver2_rpm);
log_receiver3_rpm = log(receiver3_rpm);

% y = a * log(x) + b; fitting a linear model to log-transformed RPM
log_fit1 = polyfit(log_receiver1_rpm, receiver1_noise, 1);
log_fit2 = polyfit(log_receiver2_rpm, receiver2_noise, 1);
log_fit3 = polyfit(log_receiver3_rpm, receiver3_noise, 1);

% Generate fitted values for plotting
fitted_rpm = linspace(min(rpms), max(rpms), 200); % 200 points for a smooth curve

% Make sure to exclude any non-positive RPM values
fitted_rpm = fitted_rpm(fitted_rpm > 0);

% Get the corresponding noise levels from the fitted logarithmic model
fitted_noise1 = polyval(log_fit1, log(fitted_rpm));
fitted_noise2 = polyval(log_fit2, log(fitted_rpm));
fitted_noise3 = polyval(log_fit3, log(fitted_rpm));

% Plot the integral noise levels and the logarithmic fits
figure;
hold on;

% Original data points
scatter(receiver1_rpm, receiver1_noise, 'r', 'filled');
scatter(receiver2_rpm, receiver2_noise, 'b', 'filled');
scatter(receiver3_rpm, receiver3_noise, 'm', 'filled');

% Logarithmic fit curves
plot(fitted_rpm, fitted_noise1, 'r-', 'LineWidth', 1.5);
plot(fitted_rpm, fitted_noise2, 'b-', 'LineWidth', 1.5);
plot(fitted_rpm, fitted_noise3, 'm-', 'LineWidth', 1.5);

xlabel('RPM');
ylabel('Integrated Noise Level (dB)');
title('Integrated Noise Levels at Different RPMs');

% Set x-axis limits and ticks to match the actual RPM range and correct the tick marks
xlim([min(rpms), max(rpms)]); % Use actual RPM range for x-axis limits
xticks(1000:1000:max(rpms)); % Corrected x-axis ticks at intervals of 1000 RPM

% Add grid, legend, and hold off
grid on;
legend('Receiver 1 Data', 'Receiver 2 Data', 'Receiver 3 Data', ...
       'Receiver 1 Log Fit', 'Receiver 2 Log Fit', 'Receiver 3 Log Fit', ...
       'Location', 'best');
hold off;
