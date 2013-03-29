function [] = PARplot3assignments_IPF_Coloring(data,assignments)
%returns cell array of cluster points
%cluster is [euler1 euler2 euler3 x y z confidence]

%removes points that have euler of all zeros
allZeroI = all(data(:,1:3)==0,2);
data(allZeroI,:)=[];
assignments(allZeroI,:)=[];

%determine value of unique clusters
%assignments(assignments(:,1)==0,:)=[];
assignments(assignments(:,2)==1,:)=[];
uniqueClust = unique(assignments(:,1));
%uniqueClust(uniqueClust==0)=[]; %erase unassigned points
numClusters = length(uniqueClust);
singleSlice = (length(unique(data(:,6))) == 1);

addpath(fullfile('..','FMSC code'))

%% plot all clusters together
hold off
parfor index = 1:numClusters
    %% plot all clusters
    cluster = uniqueClust(index);
    dataC = data(assignments(:,1)==cluster,:);
    
    %Euler averaging
    cs = symmetry('cubic');
    ss = symmetry('cubic');
    o = orientation('Euler',dataC(:,1:3),cs,ss);
    [fundEulers,~] = project2FundamentalRegion(o);
    aveAngle = mean(fundEulers,1);
    aveRGB = myeuler2rgb(Euler(aveAngle));
    numNodes=size(dataC,1);
    colorVec = ones(numNodes,3);
    colorVec(:,1) = aveRGB(1)*colorVec(:,1);
    colorVec(:,2) = aveRGB(2)*colorVec(:,2);
    colorVec(:,3) = aveRGB(3)*colorVec(:,3);
    
    %RGB averaging
%     numNodes=size(dataC,1);
%     fullOrien = zeros(numNodes,3);
%     RGBs = myeuler2rgb(dataC(:,1:3));
%     aveOrien=mean(RGBs,1);
%     for i=1:numNodes
%         fullOrien(i,:) = aveOrien;
%     end
%     colorVec=myeuler2rgb(fullOrien);

    
    %Lab averaging
%     numNodes=size(dataC,1);
%     fullOrien = zeros(numNodes,3);
%     RGBPoint = myeuler2rgb(dataC(:,1:3));
%     [L a b] = RGB2Lab(RGBPoint(:,1),RGBPoint(:,2),RGBPoint(:,3));
%     Labave=mean([L a b],1);
%     aveOrien=Lab2RGB(Labave(1),Labave(2),Labave(3));
%     for i=1:numNodes
%         fullOrien(i,:) = aveOrien;
%     end
%     colorVec=myeuler2rgb(fullOrien);
    
    %if unassigned, make black
    if cluster==0; colorVec=[0 0 0]; end;
    
    if singleSlice
        dataC(:,6) = index*ones(length(dataC(:,6)),1);
    end
    
    scatter3(dataC(:,4),dataC(:,5),dataC(:,6),10,colorVec,'Filled');
    view(0,90)
    hold on; box on;
    
end

axis equal  
axis tight

