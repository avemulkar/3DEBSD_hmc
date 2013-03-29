%% original code
%Edge Dilution Procedure in Kushnir 2006
%function W=coarsenW_fast(W)
Sums=sum(W,2)-diag(W);                  %Total weights of each entry to its neighbors, not counting itself
[newRows,newCols,newVals]=find(W);      
lengths = full(sum(W>0)-[diag(W)>0]');  %Total numer of neighbors each entry has
sizeW = size(W); clear W;

%gammaW = 2500;

%If the weight between two nodes, (e.g. a to b) is less than the total
%weights of a to all its neighbors normalized by the total number of a's
%neighbors, set that weight to zero. Mutatis mutandis for b. 
parfor i=1:length(newRows)
   if ( ( newVals(i) < (Sums(newRows(i))/(gammaW*lengths(newRows(i)))) ) &&...
        ( newVals(i) < (Sums(newCols(i))/(gammaW*lengths(newCols(i)))) ) ) 
       newVals(i)=0;
   end
end

clear Sums lengths;

W = sparse(newRows,newCols,newVals,sizeW(1),sizeW(2));

clear newRows newCols newVals sizeW;

