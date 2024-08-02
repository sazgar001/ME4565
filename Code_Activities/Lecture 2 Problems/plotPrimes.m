function plotPrimes(numList,testFactor)

figure(1);
hold off

maxNum = length(numList);

numRows = ceil(maxNum/10);

for i = 0:numRows
    plot([.5 10.5],i+[.5 .5],'k');
    hold on;
end

for i = 0:10
    plot(i+[.5 .5],[.5 numRows+.5],'k');
end
    
axis([.5 10.5 .5 numRows+.5]);
axis off
set(gca,'YDir','reverse')

for i = 1:length(numList)
   
    if numList(i) ~= 0
        
        col = mod(i,10);
        if col == 0
            col = 10;
        end
        row = ceil(i/10);
        
        fill(col+[-.5 .5 .5 -.5 -.5],row+[-.5 -.5 .5 .5 -.5],'r')
        text(col,row,num2str(i),'HorizontalAlignment','center','VerticalAlignment','middle','FontSize',14)
    
        if i == testFactor
            plot(col+[-.5 .5 .5 -.5 -.5],row+[-.5 -.5 .5 .5 -.5],'g','LineWidth',4)
        end
    end
end