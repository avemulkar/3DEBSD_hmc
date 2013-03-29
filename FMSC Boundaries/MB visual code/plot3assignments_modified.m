function [clusters M] = plot3assignments_modified(data,assignments)

%returns cell array of cluster points
%cluster is [euler1 euler2 euler3 x y z confidence]

%determine value of unique clusters
%assignments(assignments(:,1)==0,:)=[];
assignments(assignments(:,2)==1,:)=[];
uniqueClust = unique(assignments(:,1));
%uniqueClust(uniqueClust==0)=[]; %erase unassigned points
numClusters = length(uniqueClust);

clusters = cell(numClusters,2); %allocate memory

%% plot all clusters together
hold off
for index = 1:numClusters
    %% plot all clusters
%     cluster = uniqueClust(index);
%     dataC = data(assignments(:,1)==cluster,:);
%     
%     % normalize color from hue = 0 to 1,sat=1,val=1
%     hue = (index-1)/(numClusters-1);
%     if isnan(hue); hue=0; end
%     colorVec = hsv2rgb([hue 1 1]);
%     %if unassigned, make black
%     if cluster==0; colorVec=[0 0 0]; end;
% 
%     plot3(dataC(:,4),dataC(:,5),dataC(:,6),'.','color',colorVec)
%     hold on; box on;
%     
    
    cluster = uniqueClust(index);
    dataC = data(assignments(:,1)==cluster,:);
    if numClusters>1000
       % normalize color from hue = 0 to 1,sat=1,val=1
       hue = (index-1)/(numClusters-1);
       if isnan(hue); hue=0; end
       colorVec = hsv2rgb([hue 1 1]);
    else
        aveOrien = mean(dataC(:,1:3));
        numNodes=size(dataC,1);
        fullOrien = zeros(numNodes,3);
        for i=1:numNodes
        fullOrien(i,:) = aveOrien;
        end
        colorVec=myeuler2rgb(fullOrien);
        
    end
    %if unassigned, make black
    if cluster==0; colorVec=[0 0 0]; end;

   
    if((nnz(dataC(:,1)) == 0) &&  (nnz(dataC(:,2)) == 0) && (nnz(dataC(:,3)) == 0))
        'dont plot';
    else
        scatter3(dataC(:,4),dataC(:,5),dataC(:,6),10,colorVec,'Filled','Square');
        hold on; box on;
    end
    
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
