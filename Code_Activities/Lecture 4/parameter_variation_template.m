clear; close all; clc;

% Set the total number of iterations to take
N = 1000;
nSave = 100;

% Create the variables to store the last nSave steps
x_1_hist = zeros(nSave,1);
x_2_hist = zeros(nSave,1);

%% Create a for loop that loops through different values of the parameter lambda

for lambda = 1:0.5:16

    %% Create the base plot
    
    % Calculate the piece-wise function
    x1 = 0:.01:.5;
    f1 = lambda*x1.*(0.5-x1);
    x2 = .5:.01:1;
    f2 = 1-lambda*(1-x2).*(x2-0.5);

    % Plot them in figure 1
    figure(1)
    hold off
    plot(x1,f1,'k','LineWidth',2)
    hold on;
    plot(x2,f2,'k','LineWidth',2)
    set(gca,'FontSize',20,'TickLabelInterpreter','latex')
    ylabel('$$x_{n+1}=F(x_n)$$','FontSize',24,'Interpreter','latex')
    xlabel('$$x_n$$','FontSize',24,'Interpreter','latex')

    %% Set the new initial conditions for this value of lambda
    
    x0_1 = rand/2;     % Start one mapping in the left half of the domain (random)
    x0_2 = rand/2 + 0.5;     % Start one mapping in the right half of the domain (random)
    
    %% Perform the discrete mapping
    
    for iter = 1:N

        % Mapping for the point x0_1 to get x1_1
        % Perform map    
        if x0_1 <= 1/2 
            x1_1 = lambda*x_0*(.5-x0_1);
        else
            x1_1 = 1 - lambda*(1-x0_1)*(x0_1-.5); 
        end

        % Mapping for the point x0_2 to get x1_2
        if x0_2 <= 1/2 
            x1_2 = lambda*x_0*(.5-x0_2);
        
        else
            x1_2 = 1 - lambda*(1-x0_2)*(x0_2-.5); 
        end

        

        % If we are in the final 100 steps plot the map and save the
        % position
        if iter > (N-nSave) %total number of iterations - number last save

            % Plot the maps (cobweb diagram)
            plot([x0_1 x0_1 x1_1],[x0_1 x1_1 x1_1],'.-b','LineWidth',2,'MarkerSize',16);
            % add plot for x_2
            plot([x0_2 x0_2 x1_2],[x0_2 x1_2 x1_2],'.-m','LineWidth',2,'MarkerSize',16);
            % Store the state in the list
            x_1_hist(iter-N+nSave) = x1_1; %900 0s, then get new values if I use x_1_hist(iter)
            x_2_hist(iter-N+nSave) = x1_2;

        end

        % Update the state
        x0_1=x1_1;
        x0_2=x1_2;
    end
    

    %% At the conclusion of performing the map for the specific lambda plot the results
    
    % Plot the map result
    drawnow

    % Add data to the bifurcation diagram in figure 2
    figure(2)
    plot(lambda,unique(x_1_hist),'.b','MarkerSize',16*2)
    hold on;
    plot(lambda,unique(x_2_hist),'.m','MarkerSize',16*2)
    axis([1 16 0 1])
    set(gca,'FontSize',20,'TickLabelInterpreter','latex')
    ylabel('Long-term $$x_n$$','FontSize',24,'Interpreter','latex')
    xlabel('$$\lambda$$','FontSize',24,'Interpreter','latex')
    % Pause so that we can observe how things are changing
    pause(.25)
end