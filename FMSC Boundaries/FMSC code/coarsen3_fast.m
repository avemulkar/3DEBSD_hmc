% function [Celements, P, F] = coarsen3_fast(W,Celements,F,P,blockSize)

%% part 4,6,8
%Divide P such that each row sums to 1.

%% for i=1:length(W)
Windices = [1:length(W)]';

%% if sum(P(i,:))>0, P(i,:)=P(i,:)/sum(P(i,:));
%'if sum>0'

Psum = sum(P,2);
WindMore = Windices(Psum > 0);
P(WindMore,:)=bsxfun(@rdivide,P(WindMore,:),Psum(WindMore));
clear WindMore;

%% if sum(P(i,:)==0, 
%        Celements=[Celements,i];
%        P(i, Celements == i )=1;
%'if sum<0'
newRows = Windices(Psum <= 0); clear Windices; clear Psum;
origClen = length(Celements);
Celements = [Celements newRows'];

newCols = zeros(length(newRows),1);

parfor i = 1:length(newRows)
    newCols(i) = find(Celements(1:origClen+i) == newRows(i));
end

newSize = [length(W) length(Celements)];
P = sparseConcat(P,newRows,newCols,ones(length(newRows),1),newSize);

clear newRows; clear newCols; clear newSize; clear Psum;

%% original code

%{
for i=1:length(W)
    if sum(P(i,:))>0
        P(i,:)=P(i,:)/sum(P(i,:));
    else
        Celements=[Celements,i];
        P(i, Celements == i )=1;
        F(i)=0;
    end
end
%}