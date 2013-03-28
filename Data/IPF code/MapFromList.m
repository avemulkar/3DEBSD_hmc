function colorMap = MapFromList(Data,spacing)
% creates an IPF color map Data
% spacing: Scalar - expected distance between points
% Data: Matrix (N x 6) [r g b x y]

mapScaling = 1/spacing;

DataI = round(Data(:,4:5)*mapScaling);
DataI(:,1) = DataI(:,1) - min(DataI(:,1)) + 1;
DataI(:,2) = DataI(:,2) - min(DataI(:,2)) + 1;

% preallocate memory
colorMap = zeros(max(DataI(:,2)),max(DataI(:,1)),3);

% create map by adding rgb values to appropriate entry
numPts = size(Data,1);
for i=1:numPts
    colorMap(DataI(i,2),DataI(i,1),:)=Data(i,1:3);
end