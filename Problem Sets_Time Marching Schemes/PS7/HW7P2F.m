% Script for Part F to compare with Part E's beam deflection
clear; close all; clc;

% Parameters for part E
dx = 0.005; % Step size for discretizing the beam
L = 1; % Length of the beam
x = 0:dx:L; % Array of positions along the beam from 0 to L with step size dx

% The target maximum deflection from part C, using the analytical solution
y_analytical_partC = @(q, x) q/(24*1) * (x.^4 - 2*L*x.^3 + L^3*x); % Function handle for analytical solution
target_max_deflection = max(y_analytical_partC(1, x)); % Maximum deflection for q=1
EI_var = @(x) 1 - 2 * ((x / L) - (x / L).^2); % Function handle for variable EI

% Binary search for the load q for part E
q_min = 0; % Minimum load
q_max = 2; % Maximum load
tolerance = 1e-5; % Tolerance for the binary search
q = (q_min + q_max) / 2; % Initial guess for the load

% Binary search loop for part E
while (q_max - q_min) > tolerance
    y_num = beam_deflection_mod(x', q, EI_var); % Deflection with current load and variable EI
    max_deflection = max(y_num); % Max deflection
    
    if max_deflection > target_max_deflection
        q_max = q;
    else
        q_min = q;
    end
    q = (q_min + q_max) / 2;
end

% Calculate and plot deflection for part E
y_inhomogeneous = beam_deflection_mod(x', q, EI_var);
y_analytical = y_analytical_partC(q, x); % Analytical solution with final load

% Plot for part E
figure;
plot(x, y_inhomogeneous, 'b-', 'DisplayName', 'Distributed Load E'); 
hold on;

% Parameters for part F (non-uniform node
% Parameters for part F (non-uniform node distribution)
x_nonuniform = 0.5 - cos(pi * (0:0.05:1)) / 2; % Non-uniform node distribution

% Calculate deflection for part F
% Non-uniform node distribution
y_nonuniform = beam_deflection_mod_modify(x_nonuniform', q, EI_var);

% Plot for part F
plot(x_nonuniform, y_nonuniform, 'ko-', 'DisplayName', 'Distributed Load F');

% Final plot adjustments
title('Beam Deflection Profiles Comparison');
xlabel('Position along the beam (m)');
ylabel('Deflection (m)');
legend('show');
grid on;
hold off;

% Display the adjusted load q for part E
fprintf('The adjusted load q for the homogeneous beam: %.5f N/m\n', q);