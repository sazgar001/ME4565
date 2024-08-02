clear; close all; clc;

% Create the x variable using the CGL coordinates
x = 1/2*(1-cos(pi*(0:.001:1)/1));
nX = length(x)    % remember like length of time stuff 
f = sqrt(x);

% Create the integral vector for each subdomain
I_i = zeros(nX-1,1);

% Loop through each subdomain to compute integral
for i = 1:nX-1
    
    I_i(i) = (f(i)+f(i+1))/2*(x(i+1)-x(i));
    
end

% Sum up the sub-interval integrals to get the solution
I = sum(I_i)

% Compare to the analytic solution
error = I - 2/3