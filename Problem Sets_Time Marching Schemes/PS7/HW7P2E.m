% Problem 2 Part E with beam_deflection_mod function

%% Parameters
dx = 0.005; % Step size for discretizing the beam
L = 1; % Length of the beam
x = 0:dx:L; % Array of positions along the beam from 0 to L with step size dx

%% The target maximum deflection from part c, using the analytical solution
q = 1; % Load for Part C to find target deflection
y_analytical_partC = q/(24*1) * (x.^4 - 2*L*x.^3 + L^3*x); % Analytical solution for the deflection for Part C where EI is 1
target_max_deflection = max(y_analytical_partC); % Maximum deflection from the analytical solution
EI_var = @(x) 1 - 2 * ((x / L) - (x / L).^2); % Function handle defining the variable EI along the beam

%% Binary search setup to find the load q that gives same maximum deflection for the variable EI beam
q_min = 0; % Minimum load
q_max = 2; % Maximum load
tolerance = 1e-5; % Tolerance for the binary search
q = (q_min + q_max) / 2; % Initial guess for the load

%% Binary search loop
while (q_max - q_min) > tolerance % Continue until the range is smaller than the tolerance
    y_num = beam_deflection_mod(x', q, EI_var); % Compute the deflection of the beam with the current load and variable EI
    max_deflection = max(y_num); % Maximum deflection obtained numerically

    % Adjust q based on whether the max deflection is higher or lower than the target
    if max_deflection > target_max_deflection
        q_max = q; % Reduce the upper bound
    else
        q_min = q; % Increase the lower bound
    end
    q = (q_min + q_max) / 2; % Update the load for the next iteration
end

y_inhomogeneous = beam_deflection_mod(x', q, EI_var); % Deflection of the beam with the final load and variable EI Compute deflection with final q
y_analytical = q./(24*EI_var(x)) .* (x.^4 - 2*L*x.^3 + L^3*x); % Analytical solution for the deflection using the final load and variable EI

% Plotting the numerical and analytical solutions
figure;
plot(x, y_inhomogeneous, 'b-', 'DisplayName', 'Inhomogeneous Beam Numerical'); % Plotting the numerical solution
hold on;
plot(x, y_analytical, 'r--', 'DisplayName', 'Inhomogeneous Beam Analytical'); % Plotting the analytical solution
title('Beam Deflection: Numerical vs. Analytical');
xlabel('Position along the beam [m]');
ylabel('Deflection [m]');
legend show;
grid on;

% Display the adjusted load q
fprintf('The adjusted load q for the inhomogeneous beam: %.5f N/m\n', q); % Print the final adjusted load
