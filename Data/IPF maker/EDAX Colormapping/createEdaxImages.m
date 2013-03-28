%Make and save images of the ipf colormappings
%   From start to stop

function createEdaxImages(start, stop)

for q=start:stop

    %Step 1: Import the text file
    path    =['ipfH', int2str(q), '.txt'];
    Data=importfile(path);
    clear path
    
    %Step 2 build image from txt files
    imageipfEDAX(Data);
    axis equal
    hold on
    y1= [0,0; 0,50];
    plot(y1(:,2)+15, y1(:,1)+140, 'LineWidth',5, 'color',[1,1,1])
    saveas(gcf, ['ipfP', int2str(q), '.jpg']); 
   

    clear Data
end