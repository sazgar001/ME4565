clear; close all; clc;

%% Create the physical domain
dx = 0.01;
x = 0:dx:1;
nX = length(x);

%% Create the solution variable
phi = zeros(1,nX);

%% Create the Differential Matrices

D1 = zeros(nX,nX);
D2 = zeros(nX,nX);

for i = 2:nX-1
    D1(i, i-1:i+1) = [-1 0 1]/2/dx;
    D2(i, i-1:i+1) = [1 -2 1]/dx^2;
end
%% Create the coefficient matrix

A =  D2-eye(nX) ;

%% Set the coefficients

% Left boundary condition (Dirichlet)
A(1,:)=0;
A(1,1)=1;

% Right boundary condition (Dirichlet)
A(nX,:) = 0;
A(nX,nX-1:nX)= [-1 1]/dx;
%% Create the b vector

b = zeros(nX,1);
b(1) = 1;
b(2:nX-1) = x(x.^2 - 2); % need to fix this
b(nX) = sinh(2)-4
phi = A\b;

plot(x,phi,'.-k','MarkerSize',20,'LineWidth',2)
hold on;

c1 = (exp(-1))/(exp(-1)-exp(-2));
c2 = -exp(-2)/(exp(-1)-exp(-2));
plot(x,cosh(x)-x.^2,'r', 'LineWidth',3)

hold on;

