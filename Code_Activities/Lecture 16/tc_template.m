clear; close all; clc;

%% Set system parameters
R1 = 2;
R2 = 6;
Omega1 = 1;
Omega2 = 1/3;

%% Create the non-uniform distribution
N = 20;
r = 4-2*cos(pi*linspace(0,1,N));

%% Create the analytic solution and plot it

C2 = R1^2*R2^2/(R2^2-R1^2)*(Omega1-Omega2);
C1 = Omega1 - C2/R1^2;

v_analytic = C1*r + C2./r;

plot(r,v_analytic,'.-r','MarkerSize',30,'Linewidth',3)

%% Create our D1 and D2 Matrix

D1 = zeros(N);
D2 = zeros(N);

for i = 2:N-1
   
    dx   = r(i) - r(i-1);
    alph = (r(i+1)-r(i))/(r(i)-r(i-1));
    
    D1(i,i-1) =  -alph/(alph+1)/dx; % Coef for phi_i-1
    D1(i,i)   =  -(1-alph)/alph/dx; % Coef for phi_i
    D1(i,i+1) =  1/alph/(alph+1)/dx; % Coef for phi_i+1
    
    D2(i,i-1) =  2/(alph+1)/dx^2;
    D2(i,i)   =  -2/alph/dx^2;
    D2(i,i+1) =  2/alph/(alph+1)/dx^2;
    
end

%% Create the A matrix (Use Matrix Notation)

A = (D2 + diag(1./r)*D1 - diag(1./r.^2)) ;

% A = zeros(N);
% 
% for i = 2:N-1  % Applying the FDE
%     
%     dx = r(i) - r(i-1);
%     alph = (r(i+1)-r(i))/(r(i)-r(i-1));
%     
%     % Contribution of the first term
%     A(i,i-1) = 2/(alph+1)/dx^2;
%     A(i,i)   =-2/alph/dx^2;
%     A(i,i+1) = 2/alph/(alph+1)/dx^2;
% 
%     % Add the contribution of the second term
%     A(i,i-1) = A(i,i-1) + 1/r(i)* -alph/(alph+1)/dx;
%     A(i,i  ) = A(i,i  ) + 1/r(i)* (alph-1)/alph/dx;
%     A(i,i+1) = A(i,i+1) + 1/r(i)* 1/alph/(alph+1)/dx;
%     
%     % Add the contribution of the third term
%     
%     A(i,i  ) = A(i,i  ) - 1/r(i)^2;              
%     
% end

A(1,:) = 0; 
A(1,1) = 1; % Boundary Condition Coefficients at R1
A(N,:) = 0; 
A(N,N) = 1; % Boundary Condition Coefficients at R2

%% Create the b vector

b = zeros(N,1);

% Boundary condition 
b(1) = R1*Omega1;
b(N) = R2*Omega2; 
%% Solve our matrix equation

v_numeric = A\b;

%% Plot the result

hold on;
plot(r,v_numeric,'ob','MarkerSize',10,'Linewidth',3)