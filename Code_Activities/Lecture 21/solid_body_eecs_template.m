clear; close all; clc;
 
dt = 0.02;
omega_ini = zeros(nZ,1);
omega_w = 1;
R = 1;


nR = 50;
dr =  R(nR-3/2);
r =  -dr/2:dr/R;

nu = 0.01;

t = 0;
t_max = 60;
 
%% Create the D1 and D2 matrix

D1 = zeros(nR,nR);
D2 = zeros(nR,nR);

for i = 2:nR-1

    D1(i,i-1:i+1) = [-1 0 1]/2/dr;
    D2(i,i-1:i+1) = [ 1 -2 1]/dr^2;
end

%% Create the A matrix from the matrix representation of the FDE
A = eye(nR);


%% Create the B matrix
B = eye(nR)+ nu*dt*D2 + nu*dt*diag(3./r)*D1; % we need column vector for 3/r

%% Modify the A and B matrix to account for boundary conditions
A(1,:) = 0;
A(1,1:2) = [-1,1];
B(1,:) = 0;

A(nR,:) = 0;
A(nR, nR) = 1;
B(nR, :) = 0;

%% Set the initial conditions
omega_n = omega_ini;

%% While time is less than t_max and the maximum difference between omega_n and 
% omega_wall is greater than 1% of omega wall
% Add an additional condition that the maximum magnitude of Omega needs to
% be less than 10.

while  % look for psat 8 for this 

    %% Create the b vector
    b = zeros(nR,1);
    b(1) = 0;
    b(nR) = omega_w;

    %% Calculate the angular velocity
     
    omega_np1 = (A\B*omega_n+b);
 
    %% Plot the profile
    
    if mod(t,0.1) == 0
        plot(r,omega,'.-r','MarkerSize',30,'LineWidth',2);
        xlabel('$$r$$','FontSize',20,'Interpreter','latex')
        ylabel('$$\Omega(r)$$','FontSize',20,'Interpreter','latex')
        set(gca,'FontSize',16,'TickLabelInterpreter','latex')
    end

    %% Update the time and state
    omega_n = ;
    t = ;

end
