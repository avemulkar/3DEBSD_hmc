function [mask numClusters] = sliceMask(data,assignments,slice)

%% number of clusters
uniqueClust = unique(assignments(:,1));
numClusters = length(uniqueClust)+1;

%% plot assignments
spacing = estSpacing(data(:,4));
scaling = 1/spacing;
Zindex = [round(scaling*data(:,6))==slice];
dataZ = data(Zindex,4:5);
assignZ = assignments(Zindex,1);

Xi = round(scaling*dataZ(:,1));
Yi = round(scaling*dataZ(:,2));

mask=zeros(max(Xi), max(Yi));
for i=1:length(assignZ)
    if Xi(i)>0&&Yi(i)>0
        mask(Yi(i),Xi(i))=find(uniqueClust==assignZ(i));
    end
end
