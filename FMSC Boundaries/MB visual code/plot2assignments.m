function [colorList clustwax] = plot2assignments(data,assignments,numColors, scaling)
%Plots results of FMC for a 2D Slice

%determine value of unique clusters
uniqueClust = unique(assignments(:,1));
%uniqueClust(uniqueClust==0)=[]; %erase unassigned points
numClusters = length(uniqueClust);
% numColors = 25;

coordinates = data(:,4:5);

if abs(coordinates(2,1)-coordinates(3,1)) < .15
    mapScaling = 1/0.1;
else
    mapScaling = 1/0.5;
end

colorList = distinguishable_colors(numColors,[1 0 0;0 1 0; 0 0 1;0 0 0;0.5 0.1 0.5; 0.4706 0.5490 0.0039]); %20,15

% colorList = varycolor(numClusters/2);

% colorList = [237 217 22;...yellow
%     137 230 5;... green
%     187 3 237;... purple
%     229 199 127;... khakhi
%     107 127 187;... grey-purply-blue
%     93 8 0;... maroon
%     1 160 106;... some green-blue
%     123 53 136;...purple
%     45 170 47;... light green
%     120 140 1]/256; %swamp green


% colorList = [255 148 17;...
%     19 255 12;...
%     25 5 255;...
%     163 146 255;...
%     255 14 16;...
%     107 127 187;...
%     6 255 71;...
%     255 111 211;...
%     254 241 27;...
%     255 144 69;...
%     93 8 0;...
%     8 255 222]/255;
% colorList1 = colorList(1:numClusters/2,:);


% colorList = [flipud(colorList1); colorList];
colorList = flipud(colorList);
% colorList = sort(colorList,1);
coordinates = round(coordinates*mapScaling);

coordinates(:,1) = coordinates(:,1) - min(coordinates(:,1)) + 1;
coordinates(:,2) = coordinates(:,2) - min(coordinates(:,2)) + 1;

colorMap = zeros(max(coordinates(:,2)),max(coordinates(:,1)),3);


%% plot all clusters together
hold off
clustwax = cell(length(numClusters),2);
for index = 1:numClusters
    %% plot all clusters
    cluster = uniqueClust(index);
    DataI = coordinates(assignments(:,1)==cluster,:);   
    clustwax{index,1} = index;    
    
    
    % preallocate memory
    
    numPts = size(DataI,1);
    % create map by adding rgb values to appropriate entry
    for i=1:numPts
        ind = mod(index,numColors)+1;
        IPFcolorMap(DataI(i,2),DataI(i,1),:)=colorList(ind,1:3);
    end
    clustwax{index,2} = ind;  
%     imshow(IPFcolorMap)
    
end

  
imshow(IPFcolorMap,'InitialMagnification',scaling);
% img1 = rgb2gray(IPFcolorMap);
% figure(2)
% imshow(img1)
% imwrite(colorMap,'image.tiff','tiff')

 %     set(gca,'YDir','normal')
axis equal    
axis tight
axis off
set(gca,'YDir','reverse');


