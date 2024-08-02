clear; close all; clc;

% Parameters
dx = 0.005;
L = 1;
q = 1;
EI = 1;  % Define EI in the script

% Generate the x vector
x = 0:dx:L;

% Call the beam_deflection function
y_num = beam_deflection(x', q);

% Corrected analytical solution for comparison
y_analytical = (q/(24*EI)) * (x.^4 - 2*L*x.^3 + L^3*x.^1);

% Plotting the results with scaling for the y-axis
figure;
plot(x, y_num * 1e3, 'o-', 'MarkerSize', 3, 'DisplayName', 'Numerical Solution');  % Scale numerical solution by 1e3 for mm
hold on;
plot(x, y_analytical * 1e3, 'LineWidth', 1.5, 'DisplayName', 'Analytical Solution');  % Scale analytical solution by 1e3 for mm
title('Beam Deflection: Numerical vs. Analytical');
xlabel('Position along beam [m]');
ylabel('Deflection [x10^{-3} m]');
legend('show');
grid on;