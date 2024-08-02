% Homework 4 Problem 1 Part E
% Define the analytical solution
analytical_solution = @(t) -(t + 1) + 2 * exp(t); 
time_steps = [0.05, 0.005]; % Time steps to use

% Initialize error storage
errors_explicit = zeros(length(time_steps), 1);
errors_implicit = zeros(length(time_steps), 1);

% Loop through each time step
for i = 1:length(time_steps)
    delta_t = time_steps(i);
    
    % Get the numerical solutions from both methods
    x_explicit = explicit_euler(delta_t);
    x_implicit = implicit_euler(delta_t);
    
    % Get the analytical solution at t=1
    x_analytical = analytical_solution(1);
    
    % Calculate the errors for both methods 
    errors_explicit(i) = abs(x_explicit - x_analytical);
    errors_implicit(i) = abs(x_implicit - x_analytical);
end

% Display the errors on Command Windows
disp('Explicit Euler Method Errors:'); 
disp(errors_explicit);
disp('Implicit Euler Method Errors:');
disp(errors_implicit);

% Assuming that the error scales with delta_t to the power of p,
% we can estimate p using the ratio of errors for different delta_ts
p_explicit = log(errors_explicit(1) / errors_explicit(2)) / log(time_steps(1) / time_steps(2));
p_implicit = log(errors_implicit(1) / errors_implicit(2)) / log(time_steps(1) / time_steps(2));

% Display the estimated order of the truncation error on Command Window
fprintf('Estimated order of truncation error for Explicit Euler: %f\n', p_explicit); 
fprintf('Estimated order of truncation error for Implicit Euler: %f\n', p_implicit);
