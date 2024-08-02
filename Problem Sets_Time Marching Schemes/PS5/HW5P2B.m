% Set the parameters
A = 0.2; % Amplitude of noise
dx = pi/40; % Step size
x = 0:dx:2*pi; % Domain

% Generate the signals
[phi, phi_noise] = noisy_signal(A, dx);

% Initialize derivatives
phi_deriv = zeros(size(x));
phi_noise_deriv = zeros(size(x));

% Compute the central differences for phi and phi_noise
for i = 2:length(x)-1
    phi_deriv(i) = (phi(i+1) - phi(i-1))/(2*dx); % Central difference approximation of derivative for base signal
    phi_noise_deriv(i) = (phi_noise(i+1) - phi_noise(i-1))/(2*dx); % Central difference approximation of derivative for noisy signal
end

% Analytic derivative of phi
dphi_dx = 0.5 * (cos(x) + 2*cos(2*x)); % Analytical derivative of the base signal

% Plot the results with adjusted visuals
figure;
plot(x, phi_deriv, 'b', 'LineWidth', 2); % Increased line width and changed to dashed line for base signal derivative
hold on; % Keep the plot for overlaying the next plots
plot(x, phi_noise_deriv, 'r', 'LineWidth', 1.5); % Noisy signal derivative
plot(x, dphi_dx, 'k', 'LineWidth', 1.5); % Analytic derivative
hold off; % Release the plot hold

% Add grid lines
grid on;

% Adjust the y-axis limits to better view the base signal derivative
ylim([min(phi_deriv)-0.5, max(phi_deriv)+0.5]); % Adjust y-axis limits to base signal derivative range with some padding

xlabel('x'); % Label for x-axis
ylabel('d\phi/dx'); % Label for y-axis
title('Derivatives Comparison of Base and Noisy Signals'); % Title for the plot

% Create the legend and place it outside the plot area
legend('Derivative of Base Signal', 'Derivative of Noisy Signal', 'Analytic Derivative', 'Location', 'southoutside'); % Updated legend

% Optionally, you can increase the figure size for better visibility
set(gcf, 'Position', [100, 100, 800, 600]); % Set the figure window size: [left, bottom, width, height] in pixels
