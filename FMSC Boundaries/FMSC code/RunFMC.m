%function [AllSals storage lengths] = RunFMC(Wnext, Aves, z, quatmax, cmaha)

%z checks if the data is 3D or not

%find the location of all non-zero
%values in Wnext
[r,c]=find(Wnext);
W=[];

%links counts the number of connection
%between nodes.
% 'links' %<----------------------------------------------------------CHANGED
% toc
%sprintf(['size r' size(r)])
links = sparse(r,c,ones(length(r),1),length(Wnext),length(Wnext));
clear r; clear c;
% toc

%v contains the number of data points in each node
v=ones(length(Wnext),1);  
%Sal is the saliency of each node
Sal=Inf*ones(length(Wnext),1);

%Storage is an array of structures the keeps track of information about
%each level.  Sals contains the saliencies, Ps contains the probability 
%matrices, Vs contains the number of data points in each node, Ws is the 
%weighting matrix, Qin is the covariance helper matrix, Var is the variance
%for each node, and Aves is the averages of each value.
%storage=[struct('Sals', Sal, 'Ps', speye(length(Wnext)), 'Vs', v, 'Ws', Wnext, 'Qin',Qin, 'Var', zeros(length(W),1), 'Aves', Aves)];
%storage=[struct('Ps', speye(length(Wnext)))];

AllSals=Sal;
Sallengths=[length(Sal)];
Varin=zeros(length(Wnext),1);

% Initialize the matrix tha will hold all the seed for each s level
sSeeds = [];

%Coarsen repeatedly until the size of W doesn't change
sizeWnext = size(W);

%s is the iteration number
s=1;

%storage=[struct('Ps', speye(length(Wnext)))];
P = speye(length(Wnext));
%function [Pwrite Psize] = spwrite(P,s)
spwrite;


while ~isequal(size(Wnext),sizeWnext)
     disp(['S-Level: ' num2str(s)])
     disp(['Number of Clusters: ' num2str(size(Wnext,1))])
     
     sizeWnext=size(Wnext);
     W=Wnext; clear Wnext;
     
     
%      'coarseninteresting'
     %[Wnext, Sal, v, P,links,Avesin,Varin] =Coarseninteresting_fast(quatmax, cmaha, W, alpha, links, v, s, Aves, Varin);
     Coarseninteresting_fast;
     
     Wnext = Wcoarse; clear Wcoarse;
     v = vnew; clear vnew;
     links = nextlinks; clear nextlinks;
     Aves = Avesnew; clear Avesnew;
     Varin = Qvar; clear Qvar;
     
     
%      {'Wnext'   size(Wnext,1)   size(Wnext,2) nnz(Wnext);...
%       'Sal'     size(Sal,1)     size(Sal,2)     nnz(Sal);...
%       'v'       size(v,1)       size(v,2)       nnz(v);...
%       'P'       size(P,1)       size(P,2)       nnz(P);...
%       'links'   size(links,1)   size(links,2)   nnz(links);...
%       'Aves'    size(Aves,1)  size(Aves,2)  nnz(Aves);...
%       'Varin'   size(Varin,1)   size(Varin,2)   nnz(Varin)}
          
     s=s+1;
     
     %storage=[storage, struct('Sals', Sal,'Ps', P, 'Vs', v, 'Ws', Wnext,'Qin',Qin, 'Var', Varin, 'Aves', Avesin)];
     %storage=[storage, struct('Ps', P)]; clear P;
     
     %function [Pwrite Psize] = spwrite(P,s)
     spwrite;
     
     AllSals=[AllSals;Sal];
     Sallengths=[Sallengths, length(Sal)];
         
     %nextmask=interpret(AllSals, storage, lengths, mask,z,matrix);
     %figure
end

clear W; clear Wnext; clear Sal; clear v;
clear links; clear Aves; clear Varin;

% %interpret takes in the data analyzed 
% close all
% nextmask=interpret(AllSals, storage, lengths, mask,z,matrix);
% figure
% colormapping(nextmask(:,:,1));