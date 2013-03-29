%function P = coarsen2_fast(W,Celements,F,P,blockSize)

%% part 3
%splits up calculation on P, the interpolation matrix into blocks of
%blockSize to minimize reallocation of memory for sparse matrix  

%% for i=1:length(W)
Windices = [1:length(W)]';

%% if F(i)==1, P(i,:)=W(i,Celements);
%'if F==1'
WindFtrue = Windices(F==1);  %indices that are not in the coarse graph

%P=sparse(length(W),length(Celements));
%populate the rows of P that correspond to fine nodes with weights between themselves and the coarse nods
P(WindFtrue,:) = W(WindFtrue,Celements);   

clear WindFtrue;

%% if F(i)==0, P(i, Celements == i )=1;
%'if F==0'
newRows = Windices(F==0);   %indices that are in the coarse graph
clear Windicees; 

newCols = zeros(length(newRows),1);

parfor i = 1:length(newRows)
    newCols(i) = find(Celements == newRows(i));
end

newSize = [length(W) length(Celements)];
P = sparseConcat(P,newRows,newCols,ones(length(newRows),1),newSize);

clear newRows; clear newCols; clear newSize;


%% original code
%{
P=sparse(length(W), length(Celements));
for i=1:length(W)  
    if F(i)==1
        P(i,:)=W(i, Celements);
    else
        P(i, Celements == i )=1;
    end
end
%}