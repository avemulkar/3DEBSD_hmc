function [gridIndex transfMgrid] = NNLT_grid(transfMXY,xRange,yRange)
%% find the points nearest to each grid point
%store transfM index of point in cell array
%whose entries correspond to each grid point
%returns - transfMgrid(sliceIndex)
stepsize = 0.1;

%preliminary variables
minX = xRange(1); maxX = xRange(2);
minY = yRange(1); maxY = yRange(2);
numX = (maxX-minX)/stepsize+1;
numY = (maxY-minY)/stepsize+1;

transfMgrid = cell(numY,numX); %allocate memory

%find nearest coordinate and corresponding gridIndex
shiftCoord = [transfMXY(:,1)-minX transfMXY(:,2)-minY];
gridIndex = round(10*shiftCoord)+1;

for point = 1:size(transfMXY,1)
    %get index of nearest discrete grid point
    xGridIndex = gridIndex(point,1);
    yGridIndex = gridIndex(point,2);
    %add index of point to the cell with that index
    transfMgrid{yGridIndex,xGridIndex} = ...
        [transfMgrid{yGridIndex,xGridIndex} point];
end