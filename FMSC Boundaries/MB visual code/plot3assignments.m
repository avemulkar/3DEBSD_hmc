function [clusters M] = plot3assignments(data,assignments,boundarylist,showMovie)
%returns cell array of cluster points
%cluster is [euler1 euler2 euler3 x y z confidence]

%determine value of unique clusters
%assignments(assignments(:,1)==0,:)=[];
assignments(assignments(:,2)==1,:)=[];
uniqueClust = unique(assignments(:,1));
%uniqueClust(uniqueClust==0)=[]; %erase unassigned points
numClusters = length(uniqueClust);
singleSlice = (length(unique(data(:,6))) == 1);

clusters = cell(numClusters,2); %allocate memory

%% plot cluters one by one
if nargin>3 && showMovie
figure
for index = 1:numClusters
    
    %% select cluster points
    cluster = uniqueClust(index);
    dataC = data(assignments(:,1)==cluster,:);
    boundC = boundarylist(boundarylist(:,8)==cluster,:);
    clusters{index,1} = dataC;
    clusters{index,2} = boundC(:,1:7);

    %% choose colors and plot
    % normalize color from hue = 0 to 1,sat=1,val=1
    hue = (index-1)/(numClusters-1);
    if isnan(hue); hue=0; end
    colorVec = hsv2rgb([hue 1 1]);
    %if unassigned, make black
    if cluster==0; colorVec=[1 0 1]; end;
    
    hold off
    plot3(boundarylist(:,4),boundarylist(:,5),boundarylist(:,6),'.k','markersize',3)
    hold on;
    plot3(dataC(:,4),dataC(:,5),dataC(:,6),'.','color',colorVec)
    axis equal; box on;

    %% Capture Movie Frame
    fig=gcf;
    %set(fig,'Position',scrsz);
    frame = index;
    speed = 5;
    framestart = (frame-1)*speed+1;
    frameend = frame*speed;
    M(framestart:frameend)=getframe(fig);

    pause(.1)
    
end
end %end showMovie

%% plot all clusters together
hold off
for index = 1:numClusters
    %% plot all clusters
    cluster = uniqueClust(index);
    dataC = data(assignments(:,1)==cluster,:);
    % normalize color from hue = 0 to 1,sat=1,val=1
    hue = (index-1)/(1.2*(numClusters-1));
    if isnan(hue); hue=0; end
    colorVec = hsv2rgb([hue 1 1]);
    %if unassigned, make black
    if cluster==0; colorVec=[0 0 0]; end;
    
    if singleSlice
        dataC(:,6) = index*ones(length(dataC(:,6)),1);
    end

    scatter3(dataC(:,4),dataC(:,5),dataC(:,6),29,colorVec,'filled','square')
    hold on; box on;
    
    
    
    
    %Plotting with IPF colors
%     cluster = uniqueClust(index);
%     dataC = data(assignments(:,1)==cluster,:);
%     if numClusters>100
%        % normalize color from hue = 0 to 1,sat=1,val=1
%        hue = (index-1)/(numClusters-1);
%        if isnan(hue); hue=0; end
%        colorVec = hsv2rgb([hue 1 1]);
%     else
%        aveOrien = mean(dataC(:,1:3));
%        numNodes=size(dataC,1);
%        fullOrien = zeros(numNodes,3);
%        for i=1:numNodes
%        fullOrien(i,:) = aveOrien;
%        end
%            colorVec=myeuler2rgb(fullOrien);
%     end
%     %if unassigned, make black
%     if cluster==0; colorVec=[0 0 0]; end;
% 
%     scatter3(dataC(:,4),dataC(:,5),dataC(:,6),10,colorVec,'Filled','Square');
%     hold on; box on;
    
    
end

axis equal    

%% Capture Movie Frame
fig=gcf;
%set(fig,'Position',scrsz);
frame = numClusters+1;
speed = 5;
framestart = (frame-1)*speed+1;
frameend = frame*speed;
M(framestart:frameend)=getframe(fig);
