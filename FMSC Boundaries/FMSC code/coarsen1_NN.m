%function [Celements, F] = coarsen1_NN(W,v,alpha)

%% part 1

%F represents whether the nodes are Coarse nodes or not.
%0 means they are, 1 means they aren't
Finv = false(length(W),1); %Nx1 vector of zeros

%Celements is the list of nodes that are coarse nodes.
%The nodes are considered in order of descending size
sizeW = size(W,1);
Celements = zeros(1,sizeW); %preallocate memory
CEindex = 1;

alphaSumV = alpha*full(sum(W,2)-diag(W));   %Cullen uses X & C for fine and coarse graphs, Kushnir uses F & C, V is the total graph -AL 5/22

%alphaSumV = alpha*(sum(full(W),2)-diag(full(W)));
%find indices of all nonzero elements for rows of W...
NNZind = cell(1,sizeW);
parfor rowI = 1:sizeW       %..and store them as a vector in i'th entry of NNZind 
    [~,ind] = find(W(rowI,:));
    NNZind{rowI} = ind;
end

% sort by size
% made changes on 6/12/12

% check which s level the code is currently on
% if s == 1 sort by weights
%else sort by size
% 
if s == 1
    %rms = full(W);
    sumWeights = zeros(sizeW,1);
%     'beginning sorting by weights'
    parfor point = 1:sizeW
        sumWeights(point) = sum(full(W(point,:)));
    end
    [~,iorder] = sort(sumWeights,'descend');
        
else
    [~,iorder] = sort(v, 'descend');
end
clear rms;


%[~,iorder] = sort(v, 'descend');
for rowI = iorder' %for all rows of W
    %find the indices of all nonzero elements that are in F
    %[~,ind1] = find(W(rowI,:));
    ind1 = NNZind{rowI};        %ind1 is the vector of indices of NZ entries of the rowI'th row
    ind2 = ind1(Finv(ind1));    %ind2 contains the indices of ind1 that are coarse nodes
    sumK = sum(W(rowI,ind2));   %sum of the weights between I'th pixel and nodes that are coarse
    %snow = s
    if sumK<alphaSumV(rowI)
        %safter = s
        Finv(rowI)=1;
        Celements(CEindex) = rowI; %add to Celements
        CEindex = CEindex+1;
%         Sallengths;
%         if s == 1
%             sSeeds = [sSeeds; s rowI];
%         else
%             sSeeds = [sSeeds; s (rowI+sum(Sallengths(1:s-1)))];
%         end
    end
end

Celements(CEindex:end)=[]; %remove unneeded memory
F = ~Finv;  % change back to F

%% clear
clear Finv;
clear NNZind;
clear sizeW; clear ind1; clear ind2;
clear rowI; clear CEindex; 
clear sumK; clear alphaSumV;
clear sumWeights;

%% algorithm code
%{
v is the size of each of the pixels
F = ones(N,1)
sumK = 0
sumV = 0

we can find all the nonzero elements of N using a parallel for loop. 
NNZ in N is N*(average # of NN to a point)

for all rows of W

   find the indices of all nonzero elements
   sumV = sum(W(indices))-W(i,i)
   for indices
       if F(index) = 0
            sumK = sumK + W(index)
      end
   end

   if sumK<alpha*sumV
        F(i)=0;
   end

end
%}