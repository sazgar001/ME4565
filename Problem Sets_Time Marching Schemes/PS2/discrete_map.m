% Problem 2 Part B 

%% Define the discrete_map function
function result = discrete_map(x0, lambda)
x_n = x0; % Initialize the current state x_n with the initial condition x0

N = 1000; % Set the total number of iterations
nSave = 100; % Set the number of iterations to save
    
result = zeros(nSave, 1);  % Initialize the result array to store the final states
    
    for iter = 1:N % Loop through iterations
        if x_n <= lambda  % Check the condition and apply the appropriate mapping
            x1 = 4 * x_n * (lambda - x_n);
        else
            x1 = 4 * (x_n - 1) * (lambda - x_n);
        end
        
        % If we are in the final 100 steps, store the position
        if iter > (N - nSave)
            result(iter-N+nSave) = x1;
        end

        % Update the state for the next iteration
        x_n = x1;
    end
end