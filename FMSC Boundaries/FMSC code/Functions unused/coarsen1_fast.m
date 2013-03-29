%function [Celements, F] = coarsen1_fast(W,v,alpha)

%% part 1

%F represents whether the nodes are Coarse nodes or not.
%0 means they are, 1 means they aren't
Finv = false(length(W),1);

%Celements is the list of nodes that are coarse nodes.
%The nodes are considered in order of descending size
'sorting'
toc
[~,iorder] = sort(v, 'descend');
toc

Celements = zeros(1,length(iorder));  %preallocate memory
%consider each node, and check whether or not
%to add it to the list of coarse nodes.
CEindex = 1;
alphaSumV = alpha*(sum(W,2)-diag(W));
itcounter = 0;
'total elements'
length(iorder)
toc
timeplot = zeros(floor(length(iorder)/1000),2);
tpcounter = 1;
toc
for index=1:length(iorder)
    i=iorder(index);
    %sumK=W(i,iorder(1:index))*Finv(iorder(1:index)); %Finv replaces (1-F)
    sumK=sum(W(i,Finv));
    %sumV=sum(W(i,:))-W(i,i);
    if sumK<alphaSumV(i)
        Finv(i)=1; %instead of 0
        Celements(CEindex) = i; %add to Celements
        CEindex = CEindex+1;
    end
    itcounter=itcounter+1;
    if itcounter == 1000
       timeplot(tpcounter,:) = [index toc];
       tpcounter = tpcounter+1;
       itcounter = 0;
    end
end

Celements(CEindex:end)=[]; %remove unneeded memory
F = ~Finv;  % change back to F

%% clear
clear Finv; clear iorder; clear sumVall;
clear CEindex; clear sumK; clear sumV;
clear alphaSumV;
clear i;

%% original code
%{
F=ones(length(W),1);
Celements=[];
[~,iorder] = sort(v, 'descend');

for i=iorder'
    sumK=W(i,:)*(1-F);
    sumV=sum(W(i,:))-W(i,i);
    if sumK<alpha*sumV
        F(i)=0;
        Celements=[Celements, i];
    end
end
%}
