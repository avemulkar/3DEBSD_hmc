function [assignments, boundarylist]=interpret3D_fast(AllSals, storage, lengths,NNlist, pointData, minClustSize, minconf,sSeeds)
% elements - list of all nodes for all s
% AllSals - list of of all saliencys for all s
% lengths - number of course nodes in each s

%% sort by saliency
% sort all course nodes for all s by saliency from lowest to highest
[~,elements] = sort(AllSals,'ascend'); %elements represents the list of indices representing the sorted AllSals list
% all points assigned to own node Nx2 [assignment,confidence]
% pointData is euler1 euler2 euler3 x y z confidence
assignments=zeros(length(pointData),2);  % assignments is a n x 2 matrix --- i.e 2 columns

%% s values of each node
% vector lengthsub has index at which each s values starts
% vector sAssign has s value of all nodes
numS = length(lengths); %number of iterations of s
sAssign=[ones(lengths(1),1)]; %initiating sAssign
lengthsub=zeros(1,numS);
for i=2:numS
    sAssign=[sAssign; i*ones(lengths(i),1)];    %1 spot in sAssign for each node, increasing number for each saliency set
    lengthsub(i)=lengthsub(i-1)+lengths(i-1);
end


%% plot assignments for s=1,2,...

for curS=1:numS
    %find nodes for current s
    elemS = elements(sAssign(elements) == curS)';
    
    curS
    toc
    
    %% find points assigned to each node
    %for all nodes, recursively find wich subnodes it contains
    %until finding the list of points it contains
    for curNode = elemS
        %U is a vector of zeros with 
        %whose entries correspond to whether subnodes
        %belong to the current node
        %seeded with a one for the current node 
        U=zeros(lengths(curS),1); 
        U(curNode-lengthsub(curS))=1; %seed the respective index with 1 for the current node
    
        % for each s from current s to s=1, iteratively find which nodes
        % are inside of the node by multiplying by Ps
        for iterS=curS:-1:2
            %U(U<.1)=zeros(length(find(U<.1)),1); %why .1? -- probably thresholding down -- try changing this to a much smaller value
            U=storage(iterS).Ps*U;               
        end    
        
        % find all data points that have conf about minconf
        curPts=find(U>=minconf); % find the indeces of points in U greater than minConf
        
        %assign points to the current node
        %if the confidence they belong to this node is greater than
        %the confidence they belong to the previously assigned node
        %or if its the seed node
        %then set assignment to this node
        for pt = curPts'
            isSeed = ( assignments(pt,2)==1 ); % what do you mean by is seed really?
            isBetter = ( U(pt)>assignments(pt,2) && U(pt)~=1 );%this kinda works... what if you assign probability of individual points?
            
            if (isSeed || isBetter)
                assignments(curPts,1)=curNode;
                assignments(curPts,2)=U(pt);
            end
        end
    end
    %U
    %% check if each point is a boundary
    % check nearest neighbor list to see if neighbors assigned
    % to different cluster
    boundarylist = zeros(size(NNlist,1),8);
    indexN = 1;
    for i=1:length(NNlist)
        curpoint=assignments(i,1);
        if curpoint>0
            for NNpoint=NNlist{i}
                if assignments(NNpoint,1)~=curpoint
                    boundarylist(indexN,:) = [pointData(i,:) assignments(i,1)];
                    indexN = indexN+1;
                    %boundarylist=[boundarylist;PointData(i,:)];
                end
            end
        end
    end
    boundarylist(indexN:end,:)=[];

    %% plot
    hold off;
    figure(1);
    [clusters M] = plot3assignments(pointData,assignments,boundarylist);
    title(['S level ' num2str(curS) ' plot'])
    view(0,90)

    
    savePath = [fullfile('Splots',['slevel - ',num2str(curS),'.jpg'])];
    saveas(gcf,savePath);
    
%     % Plot seeds for next s level
%     nextseeds = find(sSeeds(:,1) == (curS));
%     nextseeds = sSeeds(nextseeds,2);
%     seedlengths = length(nextseeds);
%     hold on;box on;
%     for sindex = 1:seedlengths
%         dataSeed = pointData(assignments(:,1)==nextseeds(sindex),:);
%         % normalize color from hue = 0 to 1,sat=1,val=1
%         %hue = (index-1)/(numClusters-1);
%         
%         colorVec = [1 1 1];
% 
%         plot3(dataSeed(:,4),dataSeed(:,5),dataSeed(:,6),'.','color',colorVec)
%         hold on;box on;
%     end
    

end

%% Break up non-adjecent (Michigan) clusters
rLimit = 15;   %Recursion limit (MATLAB tends to crash around 840)
%N.B. This code runs considerably faster with a low recursion limit
set(0,'RecursionLimit',rLimit)
assignmentsX = assignments(:,1);

'Breaking non-continuous clusters' %#ok<NOPRT>
toc

xrange = length(unique(pointData(:,4)));    %row length
flag = zeros(length(assignmentsX),1);
assignmentsN = zeros(length(assignmentsX),1);
contPoint = 0;
for point = 1:length(flag)
    if assignmentsN(point) == 0
        oldClust = assignmentsX(point);
        newClust = point;
        if (flag(point)>1)     %if the point has been reserved, continue the same grouping
            newClust = flag(point);
        end
        assignmentsN(point) = newClust;
        rDepth = 1;

        [assignmentsN flag contPoint] = clustBreaker(assignmentsN, point, assignmentsX, flag, NNlist, oldClust, newClust, xrange, contPoint, rDepth, rLimit-5);
        
        while isempty(contPoints) == 0
            pointC = contPoints(1);
            contPoints = contPoints(2:end);
            assignmentsN(pointC) = newClust;
            rDepth = 1;
            [assignmentsN flag contPoints] = clustBreaker(assignmentsN, pointC, assignmentsX, flag, NNlist, oldClust, newClust, xrange, contPoints, rDepth, rLimit-5);
        end
    end
end

assignments(:,1) = assignmentsN;

%% Re-assign small clusters
[nodelist,ia,ic] = unique(assignments(:,1)); % creates a list of all the nodes and their indeces
%assign_list = assignments;
s = 1;
for i = 1:length(nodelist) %deal with zero case later
    nodepoints = find(assignments(:,1) == nodelist(i)); % i is the cluster we are looking at/ nodepoints are the points in that cluster
    
    if length(nodepoints) < minClustSize % If the cluster has fewer points than minCLustSize
        curNode = nodelist(i); %Identify the cluster
        slevel = zeros(length(lengthsub),1);%initialize variable slevel
        new_node = 0;

        
        for j = 1:length(lengthsub) %search for s level of cluster
            % determine the lengthsub index            
            if (lengthsub(j) - curNode) > 0
                slevel(j) = 1; % check this step
            end
        end
        sval = find(slevel);
        sval = sval(1);
        Weights = cell(sval,2); %initialize cell 
        for curS = sval:-1:2 %create loop to go through relevent parts of the storage array
            
            Probs = full(storage(curS).Ps); %determine probabilities for s level
            Diff = curNode-lengthsub(sval-1);
            if Diff == 0 % to make sure no indices of 0
                Diff = 1;
            end
            [r,c,Weight] = find(Probs(Diff,:)); %determine indeces of non-zero and non-one weights
            if Weight ~= 1
                Weights{s,1} = Weight; %store the weights
                Weights{s,2} = c + lengthsub(sval);%store the columns
            end
            s = s+1;
        end
        vect_weights = [];
        vect_indices = [];
        for k = 1:length(Weights) % extract all the probabilities and their indices
            vect_weights = [vect_weights Weights{k,1}];
            vect_indices = [vect_indices Weights{k,2}];
        end
        
        empty_ind = isempty(vect_indices); %check to see if vect_indices is empty or not
        if empty_ind == 0
            % find neighbouring clusters
            neigh_clusters =[];
            for point = 1:length(nodepoints)
                neighbours = NNlist{nodepoints(point),1};
                neigh_clusters;
                assignments(neighbours,1);
                neigh_clusters =[neigh_clusters assignments(neighbours,1)'];
            end
        
            %check vect_indices for neighbouring clusters
            similar_clusters = [];
            ind_weights = [];
            for clust = 1:length(vect_indices)
                for sim = 1:length(neigh_clusters)
                    if vect_indices(clust) == neigh_clusters(sim)
                        similar_clusters = [similar_clusters vect_indices(clust)];
                        ind_weights = [ind_weights clust];
                    end
                end
            end
            
            % check to see if neghbouring clusters are represented
            
            if isempty(similar_clusters) == 0 % pick out the neighbouring weights
                vect_weights = vect_weights(ind_weights);
                vect_indices = similar_clusters;
%             else
%                 vect_weights = 0;
%                 vect_indices = 0;
            end


            maxW = -1; % find max W and its index
            for curW = 1:length(vect_weights)
                if vect_weights(curW) > maxW
                    ind = curW;
                    maxW = vect_weights(curW);
                end
            end
        
            new_node = vect_indices(ind);
            % add max W and index to max W to the assignments list
            % replacing the previous value
            for d = 1:length(assignments(:,1))
                if assignments(d,1) == curNode
                    assignments(d,1) = new_node;
                    assignments(d,2) = maxW;
                end
            end
        end
        
    end
    
end

%% plot
    hold off;
    figure(2);
    [clusters M] = plot3assignments(pointData,assignments,boundarylist);
    title('Final Plot - Hue Coloring')
    view(0,90)



    


                    
 
  

%%
%{
i=1;
filledin=0;
%% assign nodes to cluster
% once 99 percent filled in or reaches end, then finished
% 99 so nodes with sal=inf,conf=1 dont get used
% filled in number of assigned points
while filledin<.99*length(pointData) && i<=length(elements)    
    %filledin  
      curele=elements(i); % current node
        %don't consider nodes with Sal==0, ie all nodes in 1 cluster
        if  AllSals(curele)>0 %%&& AllSals(curele)<1
            curS=sAssign(curele) % s of current node
            % U is a vector representing all nodes in the node
            U=zeros(lengths(curS),1);
            U(curele-lengthsub(curS))=1; %start with node contains
            %only itself
            %this calculates which data points are in the node
            
            % for each s from max s to s=1, iteratively find which nodes
            % are inside of the node for the s-1x
            for j=curS:-1:2
                %U(U>.9)=ones(length(find(U>.9)),1);
                % 
                % trimming off all connectsion that have conf<.1
                U(U<.1)=zeros(length(find(U<.1)),1);
                U=storage(j).Ps*U;
            end
            
            
            max(U);
            % find all data points that have conf about minconf
            eles=find(U>minconf);
            
            % if number of points in node is greater than minClustSize
            if length(eles)>minClustSize%&&curs<(length(storage)-3)%&& length(newmask(index(maskeles,1), index(maskeles,2),2)>.5)<.5*length(maskeles)
                %add each data point 
                for j=1:length(eles)
                    %pn is the point number of a data point that should be
                    %added to this nodes segment
                    
                    % if the old conf of the assignment of the point to a node <
                    % new conf of assignment of point to new node we are
                    % now cosidering
                    if (assignments(eles(j),2)<U(eles(j)))%%&&(assignments(eles(j),2)<minconf)
                        
                        % if the confidence == 0, i.e hasnt been initialized
                        % then increase number of assigned pts by 1
                        if assignments(eles(j),2)==0
                            filledin=filledin+1;
                        end
                        
                        % assign it
                        % assignments(:,1) = boolean of if assigned
                        % assignments(:,2) = cluster assignment
                        assignments(eles(j),1)=i;
                        assignments(eles(j),2)=U(eles(j));
                        
                    end
                end
            end
        end
        i=i+1
end

%% check if each point is a boundary
% check nearest neighbor list to see if neighbors assigned
% to different cluster
boundarylist = zeros(size(NNlist,1),8);
indexN = 1;
for i=1:length(NNlist)
    curpoint=assignments(i,1);
    if curpoint>0
        for NNpoint=NNlist{i}
            if assignments(NNpoint,1)~=curpoint
                boundarylist(indexN,:) = [pointData(i,:) assignments(i,1)];
                indexN = indexN+1;
                %boundarylist=[boundarylist;PointData(i,:)];
            end
        end
    end
end
boundarylist(indexN:end,:)=[];
%}

%{
mask=zeros(max(floor(10*PointData(:,4))+1), max(floor(10*PointData(:,5)))+1);
mask2=mask;
for i=1:length(assignments)
    mask(floor(10*PointData(i,4)+1), floor(10*PointData(i,5))+1)=assignments(i, 1);
end
for i=1:length(boundarylist)
    mask2(floor(10*boundarylist(i,4)+1), floor(10*boundarylist(i,5))+1)=1;
end
colormapping(mask);
figure
imshow(mask2)
%}
 