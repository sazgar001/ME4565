clear; close all; clc;

%% a) Set the parameters for the Julia Set

C = 0.4+ 0.1i; % Constant added to the mapping z_n+1 = z_n^2 + C
maxIter = 100; % Maximum number of iterations considered for a point to escape
escapeValue = 4; % The value above which we consider the mapping of a point to have escaped

%% b) Create the set of points where we will evaluate the mapping

X = linspace(-1,1,1000);
Y = linspace(-1.5,1.5,1500);

%% c) Create the variable that will track the number of mappings required to escape

count = zeros(length(Y),length(X));

% Loop through each Y value
for I = 1:length(Y)
    
    % Loop through each X value
    for J = 1:length(X)
        
        %% d) Create the initial position (z = x + i*y)
        z = X(J) + 1i*Y(I);        
        
        %% e) Create the if condition
        if abs(z) < escapeValue 
            n = 1; % Mapping iteration counter           
            %% f) Create the while condition 
            while abs(z) < escapeValue && n <= maxIter
                z = z^2 + C; % Apply the mapping to update the position
                n = n + 1; % Increase the number of iterations taken
            end
            
        else
            n = 0; %Set the count n to zero.
        end
        
        % Store the number of iterations taken in the count variable
        count(I,J) = n;
    end
end

%% Plot the results
imagesc(X,Y,log(count));
colormap jet
xlabel('$$x$$','FontSize',16,'Interpreter','latex')
ylabel('$$y$$','FontSize',16,'Interpreter','latex')
set(gca,'FontSize',14)