function [assignments boundarylist]=PARinterpret3D_fast(AllSals, storage, lengths,NNlist, pointData, minClustSize, minConf,~)
% elements - list of all nodes for all s
% AllSals - list of of all saliencys for all s
% lengths - number of course nodes in each s

%% sort by saliency
% sort all course nodes for all s by saliency from lowest to highest
[~,elements] = sort(AllSals,'ascend'); %elements is list of indices representing the sorted AllSals list
% all points assigned to own node Nx2 [assignment,confidence]
% pointData is euler1 euler2 euler3 x y z confidence
numPoints = length(pointData);
assignmentsX=zeros(numPoints,1);  % assignment of each poing
assignmentsY=zeros(numPoints,1);  % probability of that assignment
assignmentsZ=zeros(numPoints,1);  % pointwise probability

%% s values of each node
% vector sAssign has s value of all nodes
numS = length(lengths); %number of iterations of s
sAssign=ones(lengths(1),1); %initiating sAssign
lengthsub=zeros(1,numS);


%1 spot in sAssign for each node, increasing number for each saliency set
parfor curS=2:numS
    sAssign=[sAssign; curS*ones(lengths(curS),1)];    
end

% build assignments
for curS = 13%numS-4:numS
    %find nodes for current s
    elemS = elements(sAssign(elements) == curS)';   %nodes of curS
    sLen = lengths(curS);
    numNodes = length(elemS);
    allUs = zeros(numPoints,numNodes+1);
    
    curS %#ok<NOPRT>
  
    % for each s from current s to s=1, iteratively find which nodes
    % are inside of the node by multiplying by Ps
    backPs = storage(curS).Ps;
    for iterS=curS-1:-1:2
        backPs=storage(iterS).Ps*backPs;
    end
    
    % find probability of points assigned to each node
    parfor curNodeIndex = 1:numNodes
        %U is a vector of zeros whose entries correspond to whether
        %subnodes belong to the current node...
        U=zeros(sLen,1);
        U(curNodeIndex)=1;  %seeded with a one for the current node
        U = backPs*U;
        
       allUs(:,curNodeIndex) = U; %#ok<PFOUS>
        
    end
    
    allUs(:,numNodes + 1) = assignmentsY;
       
    
    %assign clusters to points based on the strongest probability of any
    %point in the cluster
    for point = 1:numPoints
        [Prob NodeIndex] = max(allUs(point,:));
        if ((NodeIndex <= numNodes) && (Prob ~= 1))
            nodePoints = allUs(:,NodeIndex)>=minConf;
            assignmentsX(nodePoints) = NodeIndex;
            assignmentsY(nodePoints) = Prob;
%             assignmentsZ(nodePoints) = allUs(nodePoints,NodeIndex);  %This takes a bit, not needed in general
        end
    end
end

%% check if each point is a boundary
% check nearest neighbor list to see if neighbors assigned
% to different cluster
boundarylist = zeros(size(NNlist,1),8);
indexN = 1;
for i=1:length(NNlist)
    curpoint=assignmentsX(i);
    if curpoint>0
        for NNpoint=NNlist{i}
            if assignmentsX(NNpoint)~=curpoint
                boundarylist(indexN,:) = [pointData(i,:) assignmentsX(i)];
                indexN = indexN+1;
            end
        end
    end
end
boundarylist(indexN:end,:)=[];


%% Break up non-continuous (Michigan) clusters
rLimit = 15;   %Recursion limit (MATLAB tends to crash around 840)
%N.B. This runs considerably faster with a low recursion limit due to
%MATLAB's huge overhead. Better to make more calls than fewer, deeper calls
% set(0,'RecursionLimit',rLimit)

disp('Breaking non-continuous clusters')


xrange = length(unique(pointData(:,4)));    %row length
flag = zeros(length(assignmentsX),1);
assignmentsN = zeros(length(assignmentsX),1);
contPoints = [];
for point = 2:length(flag)
    if assignmentsN(point) == 0
        oldClust = assignmentsX(point);
        newClust = point;
        if (flag(point)>1)     %if the point has been reserved, continue the same grouping
            newClust = flag(point);
        end
        assignmentsN(point) = newClust;
        rDepth = 1;

        [assignmentsN flag contPoints] = clustBreaker(assignmentsN, point, assignmentsX, flag, NNlist, oldClust, newClust, xrange, contPoints, rDepth, rLimit-5);
        
        while isempty(contPoints) == 0
            pointC = contPoints(1);
            contPoints = contPoints(2:end);
            assignmentsN(pointC) = newClust;
            rDepth = 1;
            [assignmentsN flag contPoints] = clustBreaker(assignmentsN, pointC, assignmentsX, flag, NNlist, oldClust, newClust, xrange, contPoints, rDepth, rLimit-5);
        end
    end
end

singlePoints = find(flag == -1);
for pt = singlePoints'
assignmentsN(pt) = assignmentsN(NNlist{pt}(2));
end

assignmentsX = assignmentsN;
set(0,'RecursionLimit',500)

%% Re-assign small clusters
% 
% 'Re-assigning small clusters' %#ok<NOPRT>
% toc
% 
% [nodelist,~,~] = unique(assignmentsX); % creates a list of all the nodes and their indeces
% 
% replacementList = []; %[Old New;...]
% % For each unique cluster
% parfor nodeIndex = 1:length(nodelist) %deal with zero case later
%     nodepoints = find(assignmentsX == nodelist(nodeIndex));  %nodepoints are the points in that cluster
%     
%     % If the cluster has fewer points than minCLustSize
%     if length(nodepoints) < minClustSize 
%         curNode = nodelist(nodeIndex); %Identify the cluster
%         slevel = zeros(length(lengthsub),1);%initialize variable slevel
%         
%         for s = 1:numS %search for the S line in which curNode lives
%             % determine the lengthsub index            
%             if (lengthsub(s) - curNode) > 0
%                 slevel = s;
%                 break
%             end
%         end
%         
%         allProbs = cell(slevel,2); % To contain all relevant P matrices
%         
%         clust = 1;  
%         for curS = slevel:-1:2 %create loop to go through relevent parts of the storage array
%             
%             Probs = full(storage(curS).Ps); %determine probabilities for s level
%             Diff = curNode-lengthsub(slevel-1); %index offset
%             if Diff == 0 % to make sure no indices of 0
%                 Diff = 1;
%             end
%             [r,c,NZProbs] = find(Probs(Diff,:)); %determine indeces of non-zero and...
%             if NZProbs ~= 1                      %...non-one probabilities
%                 allProbs{clust,1} = NZProbs; %store the probabilities
%                 allProbs{clust,2} = c + lengthsub(slevel); %store the columns
%             end
%             clust = clust+1;
%         end
%         
%         vect_weights = [];
%         vect_indices = [];
%         for clust = 1:length(allProbs) % extract all the probabilities and their indices
%             vect_weights = [vect_weights allProbs{clust,1}];
%             vect_indices = [vect_indices allProbs{clust,2}];
%         end
%         
%         empty_ind = isempty(vect_indices); %check to see if vect_indices is empty or not
%         if empty_ind == 0
%             % find neighbouring clusters
%             neigh_clusters =[];
%             for point = 1:length(nodepoints)
%                 neighbours = NNlist{nodepoints(point),1};
%                 neigh_clusters =[neigh_clusters assignmentsX(neighbours)'];
%             end
%         
%             %check vect_indices for neighbouring clusters
%             similar_clusters = [];
%             ind_weights = [];
%             for clust = 1:length(vect_indices)
%                 for sim = 1:length(neigh_clusters)
%                     if vect_indices(clust) == neigh_clusters(sim)
%                         similar_clusters = [similar_clusters vect_indices(clust)];
%                         ind_weights = [ind_weights clust];
%                     end
%                 end
%             end
%             
%             % check to see if neghbouring clusters are represented
%             
%             if isempty(similar_clusters) == 0 % pick out the neighbouring weights
%                 vect_weights = vect_weights(ind_weights);
%                 vect_indices = similar_clusters;
% %             else
% %                 vect_weights = 0;
% %                 vect_indices = 0;
%             end
% 
% 
%             maxW = -1; % find max W and its index
%             for curW = 1:length(vect_weights)
%                 if vect_weights(curW) > maxW
%                     ind = curW;
%                     maxW = vect_weights(curW);
%                 end
%             end
%         
%             new_node = vect_indices(ind);
%             % add max W and index to max W to the assignments list
%             % replacing the previous value
% %             for d = 1:length(assignmentsX)
% %                 if assignmentsX(d) == curNode
% %                     assignmentsX(d) = new_node;
% % %                     assignmentsY(d) = maxW;
% %                 end
% %             end
%             
%             replacementList = [replacementList;[curNode, new_node]];
%            
%         end
%         
%     end
%     
% end
% 
% 
% if ~isempty(replacementList)
%     for correction = 1:length(replacementList)
%                 replacements = find(assignmentsX == replacementList(correction,1));
%                 assignmentsX(replacements) = replacementList(correction,2);
%     end
% end

assignments = [assignmentsX assignmentsY assignmentsZ];
    
end

