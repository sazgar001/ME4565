% using other ghost point method

clear; close all; clc;
 
omega_w = 1;
R = 1;
nR = 30;
dr = R/(nR-1.5);
r =  -dr/2:dr:R;
 
%% Create the D1 and D2 matrix

D1 = zeros(nR,nR);
D2 = zeros(nR,nR);

for i = 2:nR-1

    D1(i,i-1:i+1) = [-1 0 1]/2/dr;
    D2(i,i-1:i+1) = [ 1 -2 1]/dr^2;
end
%% Create the A matrix from the matrix representation of the FDE

A = diag(r)*D2 + 3*D1; % do not use dot because we need the full matrix operation. cant vector times matrix we need matrix times matrix 

%% Modify the A matrix to account for boundary conditions
A(1,:) = 0;
A(1,1:2)= [-1 1];

A(nR,:)= 0;
A(nR, nR) = [1];

%% Create the b vector
b = zeros(nR,1);
b(nR) = omega_w;

%% Calculate the angular velocity
 
omega = A\b; % b\A gives wrong answer, its always matrix \ back vector
 
%% Plot the profile
 
plot(r,omega,'.-r','MarkerSize',30,'LineWidth',2);
xlabel('$$r$$','FontSize',20,'Interpreter','latex')
ylabel('$$\Omega(r)$$','FontSize',20,'Interpreter','latex')
set(gca,'FontSize',16,'TickLabelInterpreter','latex')
