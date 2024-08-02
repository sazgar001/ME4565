clear; close all; clc;

deta = 0.01;
eta = 0:deta:10;
nEta = length(eta);

%% Set the shooting method properties
nIter = 10;

h_guess_lower = 0;
h_guess_upper = 1;
g_end_target = 1;

%% Plot the far field velocity
% f = sin(eta) + cos(eta) + eta - 1;
plot([1 1],[min(eta) max(eta)],'--k','LineWidth',2);
hold on;

%% Perform the shooting method iterations

for iter = 1:nIter
    
    %% Create the computed profile
    f_profile = zeros(nEta,1);
    g_profile = zeros(nEta,1);
    h_profile = zeros(nEta,1);
    
    %% Calculate the initial slope guess
    h_ini_guess = (h_guess_upper + h_guess_lower)/2;
    
    %% Set the initial conditions
    f_proile(1) = 0; % Current value of f
    g_profile(1) = 0; % Current value of g
    h_profile(1) = h_ini_guess; % Current value of h
    
    %% Perform the time marching scheme
    
    for n = 1:nEta-1
        
        % Grab the current state
        f_n = f_profile(n);
        g_n = g_profile(n);
        h_h = h_profile(n);

        % Calculate the slopes at the current state
        
        k1f = g_n;
        k1g = h_n;
        k1h = -(f_n*h_n)/2;

        % Perform the half step
        f_h = f_n + deta/2*k1f;
        g_h = g_n + deta/2*k1g;
        h_h = h_n + deta/2*k1h;

        % Calculate the slopes at the half state
        k2f = g_h;
        k2g = h_h;
        k2h = -(f_h*h_h)/2;
        
        % Perform the full step   
        f_np1 = f_n + deta*k2f;
        g_np1 = g_n + deta*k2g;
        h_np1 = h_n + deta*k2h;
        % Save the next step
        f_profile(n+1) = f_np1;
        g_profile(n+1) = g_np1;
        h_profile(n+1) = h_np1;
    
    end
    
    %% Plot the test profile

    plot(g_profile,eta,'.-r');
    
    %% Evaluate the final state and update your guess range
    
     if  g_profile(end)> g_end_target % Overestimate
        h_guess_upper = h_ini_guess; % set upper bound to initial guess
     elseif g_profile(end) < g_end_target % Underestimate
        h_guess_lower = h_ini_guess; 
     else % Hits target
          break
     end
    
    pause
    if iter<nIter; plot(g_profile,eta,'.-k'); end
    
end

