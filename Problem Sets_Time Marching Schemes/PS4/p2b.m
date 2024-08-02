% Problem 5 Part B

% Define the parameters
m = 1; % Setting a value for mass
k = 1; % Setting a value for spring coefficient
Cd = 2.5; % Setting value for drag
t = 0:0.01:10; % Creating a time vector 't' from 0 to 10 with a step of 0.01
[x, v, u] = block_cn_linear(t, m, k, Cd); % Call the function


% Create the first figure for background flow velocity u(t) and block velocity v(t)
figure;
plot(t, u, 'r-', t, v, 'b--'); % plotting parameters
xlabel('Time (s)'); % x-axis label
ylabel('Velocity (m/s)'); % y-axis label
% Making it latex to have v dot and u in greek letter. Moved legend to
% bottom of graph but in one line
legend('Background flow velocity $u(t)$', 'Block velocity $\dot{x}(t)$', 'Interpreter', 'latex', 'Location', 'southoutside', 'Orientation', 'horizontal');
title('Background Flow Velocity and Block Velocity'); % title label

% Create the second figure for the position of the block x(t)
figure;
plot(t, x, 'k-'); % plotting parameters
xlabel('Time (s)'); % x-axis label
ylabel('Position (m)');  % y-axis label
legend('Position of the Block $x(t)$', 'Interpreter', 'latex', 'Location', 'southoutside', 'Orientation', 'horizontal');
title('Position of the Block x(t)'); % title label
