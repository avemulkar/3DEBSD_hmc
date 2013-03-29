function [] = confidenceMap(data,assignments)

sliceSpacing = 0.1;
minX = min(data(:,4));
maxX = max(data(:,4));
minY = min(data(:,5));
maxY = max(data(:,5));

map = zeros((maxX-minX)/sliceSpacing,(maxY-minY)/sliceSpacing);

for i = 1:length(assignments)
    x = round((data(i,4)-minX)/sliceSpacing)+1;
    y = round((data(i,5)-minY)/sliceSpacing)+1;
    map(x,y) = assignments(i,3);
end

map = flipud(map');

imshow(uint8(map*256))