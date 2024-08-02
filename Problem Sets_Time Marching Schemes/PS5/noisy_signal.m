function [phi, phi_noise] = noisy_signal(A, dx)
    %% Create the domain
    x = 0:dx:2*pi;  % Assuming you want to create the signal over the interval [0, 2π]

    %% Set the base function
    phi = 0.5 * (sin(x) + sin(2*x));

    %% Add noise to the base function 
    noise = rand(size(x)); % First generate noise in the range [0, 1]
    noise = 2 * A * noise; % Scale to range [0, 2A]
    noise = noise - A; % Shift to range [-A, A]
    phi_noise = phi + noise; % Add noise to phi to get the noisy signal
end


%% Testing Function on Command Window and Plotting
%[phi, phi_noise] = noisy_signal(0.5, 0.1);
% x = 0:0.1:2*pi; % range of x is from 0 to 2*pi with steps of 0.1 as per your function definition

% Plot the base signal
% plot(x, phi, 'b', 'LineWidth', 2);
% hold on; % This command allows you to plot multiple lines on the same figure

% Plot the noisy signal
% plot(x, phi_noise, 'r--', 'LineWidth', 1.5);
% hold off; % This command ends the multiple line plotting
% xlabel('x');
% ylabel('\phi(x)');
% legend('Base Signal', 'Noisy Signal');
% title('Comparison of Base and Noisy Signals');
