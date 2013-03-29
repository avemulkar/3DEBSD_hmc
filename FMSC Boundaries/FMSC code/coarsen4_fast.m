%function P = coarsen4_fast(W,P,gamma)

%length(find(P(i,:)))
NNZperRow = full(sum(P>0,2));
%length(find(P(i,:)<gamma))
numPlessGamma = size(P,2)-full(sum( (P>gamma) ,2));

% for i=1:length(W)
Windices = 1:length(W);

%if length(find(P(i,:)<gamma))<.2*length(find(P(i,:)))
ind2do = Windices(numPlessGamma<.2*NNZperRow);
clear Windices; clear NNZperRow;

numPlessGamma = full(sum( (0<P)&(P<gamma) ,2));

counter = 1;

newRows = zeros(sum(numPlessGamma(ind2do)),1);
newCols = zeros(sum(numPlessGamma(ind2do)),1);

for i = ind2do
    numNewElem = numPlessGamma(i);
    %P(i,(0<P(i,:))&(P(i,:)<gamma))
    newRows(counter:counter+numNewElem-1) = i*numNewElem;
    newCols(counter:counter+numNewElem-1) = P(i,(0<P(i,:))&(P(i,:)<gamma));
    counter = counter+numNewElem;
end

clear ind2do; clear numPlessGamma; clear numNewElem; clear counter;

newSize = size(P);
size(P)
size(newRows)
size(newCols)
size(zeros(length(newRows),1))
P = sparseConcat(P,newRows,newCols,zeros(length(newRows),1),newSize);

%% clear variables
clear newRows; clear newCols; clear newSize;


%% original code
%{
for i=1:length(W)
    %gamma=1/(length(find(P(i,:)))*5);
    gamma=.1;
    if length(find(P(i,:)<gamma))<.2*length(find(P(i,:)))
         P(i,P(i,:)<gamma)=zeros(1,length(find(P(i,:)<gamma)));
    end
end
%}