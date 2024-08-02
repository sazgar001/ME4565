clear; close all; clc;

%% Set the number of iterations for relaxation method
nIter =  10 ;

%% Create the domain
dEta =  0.1; % change dx, be half step to be above the boundary. 
eta  = (0:dEta:10)'; % make x a column vector
nEta = length(eta);

%% Create the guess   
% This should satisfy the boundary conditions
% In this example f(eta=0)=0, f'(eta=0)=0, f'(eta->10) = 1;
% We need a guess for f_g that satisifies f_g(eta=0)=0, f'(eta=0)=0,                     
% f'(eta =10) =1;

f_g = (sqrt(1+eta(end)^2)/eta(end))*(sqrt(1+eta.^2)-1);

plot(eta,f_g, '-k', 'LineWidth',2)

% Zeta boundary conditions: zeta(eta=0)=0, zeta'(eta=0)=0, zeta'(eta=10)=0

%% Create the derivative matrices
% Don't include any boundary conditions yet.

% First derivative matrix
D1 = zeros(nEta,nEta); % first derivative O(dx^2)

D1(1,1:3) = [-3/2 2 -1/2]/dEta; % right sided
for i = 2:nEta-1
    D1(i,i-1:i+1) = [-1/2 0 1/2]/dEta; % central difference
end
D1(nEta,nEta-3:nEta) = [1/2 -2 3/2]/dEta; % left sided

% Second derivative matrix
D2 = zeros(nEta,nEta); % Second derivative 

D2(1,1:4) = [2 -5 4 -1]/dEta^2; % right sided
for i = 2:nEta-1
    D2(i,i-1:i+1) = [1 -2 1]/dEta^2; % central
end
D2(nEta,nEta-3:nEta) = [-1 4 -5 2]/dEta^2; % left sided

% Third derivative matrix
D3 = zeros(nEta, nEta); % third derivative   O(dx^2)
D3(1,1:5) = [-5/2 9 -12 7 -3/2]/dEta^3; % first row
D3(2,2:6) = [-5/2 9 -12 7 -3/2]/dEta^3; % forward difference for second position
for i = 3:nEta-2 % Interior points -> have enough info from center to left and right
    D3(i,i-2:i+2) = [-1/2 1 0 -1 1/2]/dEta^3; % Central Difference
end

D3(nEta-1, nEta-5:nEta-1) = [3/2 -7 12 -9 5/2]/dEta^3;
D3(nEta, nEta-4:nEta) = [3/2 -7 12 -9 5/2]/dEta^3;

%% Loop through the iterations
for i = 1:nIter
    
    %% Create the A matrix
    % In this case that is (D2 + 2*diag(phi_g))
    
    A = D3 + 0.5*diag(f_g)*D2 + 0.5*diag(D2*f_g); % The diag function creates a diagonal matrix with the diagonal values matching the input vector

    %% Create the b vector
    
    b = -D3*f_g - 1/2*diag(D2*f_g)*f_g;
    
    %% Account for the boundary conditions of the correction
    % Since the original B.C. are satisfied by the guess, both B.C. for the correction are zero
    
    % Set zeta(eta=0) = 0; 
    A(1,:) = 0; % Reset the entire coefficient matrix row to zero   : means all columns 
    A(1,1) = 1; 
    b(1)   = 0;
    
    % Set zeta'(eta=0) = 0; 
    A(2,:) = 0; % Reset the entire coefficient matrix row to zero   : means all columns 
    A(2,1:3) = [-3/2 2 -1/2]/dEta;
    b(2)   = 0;
    
    % Set zeta'(x=10) = 0; 
    A(nEta,:) = 0;
    A(nEta,nEta-2:nEta) = [1/2 -2 3/2]/dEta;
    b(nEta) = 0; % still needs to be averaged out to be 0. 
    
    %% Solve the matrix equation to get the correction
    
    zeta = A\b;
    
    %% Incorporate the correction into an updated guess 
    f_g = f_g + zeta;
    
    %% Calculate the ODE residual   
    R = D3*f_g + 0.5*diag(D2*f_g)*f_g; % Based on the ODE you are solving for    -> plug in f_g in governing eq
    res(i) = mean(abs(R(2:end-1))); % No residual at boundary points, just interior
    
    %% Plot the results
    
    subplot(121);
    hold off
    plot(eta,D1*(f_g-zeta),'.-k','MarkerSize',30); % Previous guess
    hold on;
    plot(eta,D1*f_g,'.-r','MarkerSize',10); % New guess
    xlabel('$$\eta$$','FontSize',20,'Interpreter','latex')
    ylabel('$$f''(\eta)$$','FontSize',20,'Interpreter','latex')
    
    subplot(122);
    plot(1:i,res,'.k','MarkerSize',20);
    set(gca,'YScale','log')     
    xlabel('Iteration','FontSize',20,'Interpreter','latex')
    ylabel('Residual','FontSize',20,'Interpreter','latex')
    pause
    
end
    