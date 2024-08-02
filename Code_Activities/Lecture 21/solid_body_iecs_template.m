clear; close all; clc;
 
nu = 0.01;
omega_w = 1;
H = 1;

nZ = 50;
dz =  ;
z =  ;

dt = 0.02;
t = 0;
t_max = 60;
 
%% Create the D2 matrix
 
 
%% Create the A matrix from the matrix representation of the FDE

%% Create the B matrix

%% Modify the A and B matrix to account for boundary conditions


%% Set the initial conditions
omega_n = zeros(nZ,1);

%% While time is less than t_max and the maximum difference between omega_n and 
% omega_wall is greater than 1% of omega wall

while 

    %% Create the b vector


    %% Calculate the angular velocity
     
    omega_np1 = ;
 
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
