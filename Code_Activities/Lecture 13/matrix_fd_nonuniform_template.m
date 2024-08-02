clear; close all; clc;

x = 1/2*(1-cos(pi*[0:.01:1]/1)); % Creates the CGL distribution from 0 to 1
x = x'; % Makes x and phi a column vector
nX = length(x);
phi = sqrt(x);

%% Create the D1 matrix
D1 = zeros(nX,nX);

%% Set the coefficients

dx = x(2)-x(1);
alph = (x(3)-x(2))/(x(2)-x(1)); % write local alpha as a function of x(1), x(2), x(3)

% Right sided difference for the first position
D1(1,1) = -(alph+2)/(alph+1)/dx; % phi_i for the right sided difference
D1(1,2) = (alph+1)/alph/dx; % phi_i+1 for the right sided difference
D1(1,3) = -1/alph/(alph+1)/dx; % phi_i+2 for the right sided difference

% For the interior points apply the central difference
for i = 2:nX-1
    
    dx = x(i)-x(i-1);
    alph = (x(i+1)-x(i))/dx; % write local alpha as a function of x(i+1), x(i), x(i+1)
        
    D1(i,i-1) = -alph/(alph+1)/dx; % phi_i-1 for the right sided difference
    D1(i,i) = -(1-alph)/alph/dx; % phi_i for the right sided difference
    D1(i,i+1) = 1/alph/(alph+1)/dx; % phi_i+1 for the right sided difference

end

dx = x(end)-x(end-1);
alph = (x-(nX-1)-x(nX-2))/dx; % write local alpha as a function of x(end), x(end-1), x(end-2)

% Left sided difference for the last position -> end is last index for that
% component 
D1(end,end-2) = 1/alp/(alph+1)/dx; 
D1(end,end-1) = -(alph+1)/alph/dx;
D1(end,end)   = (alph+2)/(alph+1)/dx;


%% Calulate the derivative 
dPhidx_analytic = 1/2./sqrt(x);
dPhidx_matrix = D1*phi;

%% Plot the results
plot(x,dPhidx_analytic,'k','LineWidth',3);
hold on;
plot(x,dPhidx_matrix,'.r','MarkerSize',20);

