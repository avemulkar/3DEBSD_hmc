function NNLT(dataSetName,xRange,yRange,slicerange,sliceSpacing,radius)
% NNLT - nearest neighbor lookup table
% creates a cell array that functions as a lookup table 
% to find the nearest neighbors
% inputs  - radius (find nearest neighbors of each point within radius)
%         - xrange, yrange (range of x & y points within each slice
%               that will be analyzed)
%         - slicerange (range of slices of interest in data set)
%         - datafolder (folder that that contains the data files)
% returns - transfMdata (matrix of size Nx6 where N is the total number 
%               of points within the x and y range for all slices.
%               contains euler1 eueler2 eule4 x y z confidence)
%         - transfMLT (structure of size Nx1, where each structure
%               is a 1xM array where M is the # of nearest neighbors
%               to point. array contains the indices of nearest neighbors 
%               to that point. indicees refers to the list index of the
%               nearest neighbor in transfMdata, for lookup purposes.

clc; close all;

%dataSetName = 'nickel_diecompressed';%'aluminum_tensile';
%xRange = [0 9];%[0 35]; %[lower bound, upper bound]
%yRange = [4 14];%[0 19]; %[lower bound, upper bound]
%slicerange = [1 6]; %[lower boudn, upper bound]
%
%radius = .1; %for slice i: (x^2+y^2 < radius)
%sliceSpacing = .5; %for slice i-1, i+1 : (x^2+y^2+sliceSpacing^2 < radius) 

plotYN = 0;
confidence = .2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% preparation
% prep variables
addpath('NNLT code');

slices = [slicerange(1):slicerange(end)];
minX = xRange(1); maxX = xRange(end);
minY = yRange(1); maxY = yRange(end);
Xs = [minX:0.1:maxX];
Ys = [minY:0.1:maxY];

numSlices = length(slices);
numX = length(Xs);
numY = length(Ys);
lengthSlices = zeros(1,numSlices); %row vector

%data paths
cleanData = true;
if cleanData %running on unTransformed data, changes also on line 91
dataFolder = ['..' , filesep, 'Data' , filesep , 'Cleaned Data'];    
else
dataFolder = ['..' , filesep, 'Data' , filesep , 'Transformed Data'];
end
writeFolder = ['data for FMSC',filesep ,dataSetName];
writeName = ['x' num2str(minX) 't' num2str(maxX) '_'...
             'y' num2str(minY) 't' num2str(maxY) '_'...
             'z' num2str(slicerange(1)) 't' num2str(slicerange(2))];
writePath = fullfile(writeFolder,[writeName '.txt']);
writePathLT = fullfile(pwd,writeFolder,[writeName '_LT' '.mat']);
mkdir(writeFolder)
fid = fopen(writePath, 'wt');

%allocate memory
transfMLTcat = cell(numSlices,1);
sliceLengths = zeros(numSlices,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% compute nearest neigbor of every slice
%create gridIndex and transfMgrid for a each slice

for sliceIndex = 1:numSlices;
    currSlice = slices(sliceIndex);
    sprintf(['beginning slice:' int2str(currSlice) '...'])

    %allocate memory
    transfMXYstruct = cell(3,1);
    transfMgridStruct = cell(numY,numX,3);

    %% find gridIndex and transfMgrid for below, current, and above slice
    %save to gridIndexStruct{1:3}, transfMgridStruct{:,:,1:3}

    for structIndex = [1 2 3];
        %% but only if the slice is within the slice range
        slice = currSlice+structIndex-2; %slice number

        if ((slice>=slicerange(1))&&(slice<=slicerange(end)))

            %% Import that data from path (transformed data) 
           
             %running on unTransformed data, changes also on line 49
            if cleanData
                
                dataPath = fullfile(dataFolder,dataSetName,...
                        ['scanClean' int2str(slice) '.txt']);
%                       fullfile(dataFolder,dataSetName,...
%                     ['Scan'  int2str(slice) '.txt']);
%                     ['Scan'  int2str(slice) ' cleaned.ang']);
                transfM = importdata(dataPath);% ,' ',32); %97 tensile, 32 rolled
%                 transfM = transfM(1,1).data;

            else
            dataPath = fullfile(dataFolder,dataSetName,...
                        ['scanTrans' int2str(slice) '.txt']);

            %Columns 1-3 are Euler angles, 4-5 are x and y positions,  7 is confidence
            %Add in columns 6 as z position (slice)
            transfM = importdata(dataPath);
            end
            lengthTransfM = size(transfM,1);
            transfM = [transfM(:,[1:5])...
                       sliceSpacing*slices(sliceIndex)*ones(lengthTransfM,1)...
                       transfM(:,6)];

            %% delete all points in TransfM that are outside the real dimensions & plot
            if slice == currSlice
                xmin = min(transfM(:,4)); xmax = max(transfM(:,4));
                ymin = min(transfM(:,5)); ymax = max(transfM(:,5));
                axisLim = [xmin xmax ymin ymax];
                transfM = NNLT_truncate(transfM,xRange,yRange,plotYN,confidence,axisLim);
            else
                transfM = NNLT_truncate(transfM,xRange,yRange,0,confidence);
            end

            %% write TransfM to file
            transfMXY = transfM(:,4:5); %save xy data for later
            if slice == currSlice
                fprintf(fid,'%.5f\t%.5f\t%.5f\t%.5f\t%.5f\t%.2f\t%.3f\n',transfM');
            end
            clear transfM;

            %% find the points nearest to each grid point
            [gridIndexTemp transfMgrid] = NNLT_grid(transfMXY,xRange,yRange);
            if slice == currSlice
                gridIndex = gridIndexTemp;
            end
            clear gridIndexTemp;

            %% save to structure
            transfMXYstruct{structIndex} = transfMXY; clear transfMXY;
            transfMgridStruct(:,:,structIndex) = transfMgrid; clear transfMgrid;

        end %end if slice statement

    end %end for structIndex loop

    %% find the nearest neighbors
    sprintf('finding nearest neighbor...')
    transfMLTstruct = NNLT_LT(transfMXYstruct,transfMgridStruct,...
                              gridIndex,radius,sliceSpacing);
    clear transfMgridStruct; clear gridIndex;        
    %% reindex and concatentate the data together
    lengths123 = [size(transfMXYstruct{1},1),...
                  size(transfMXYstruct{2},1),...
                  size(transfMXYstruct{3},1)];
    clear transfMXYstruct;
    startIndex = sum(sliceLengths); %last index used
    sliceLengths(sliceIndex) = lengths123(2); %data length of all slices

    %reindex and concatenate
    transfMLTcat{sliceIndex} = NNLT_reIndex(transfMLTstruct,lengths123,startIndex);
    clear transfMLTstruct

end %end for every slice loop

fclose(fid);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% concatenate all look-up tables and save
sprintf('beginning concatenation...')

totalLength = sum(sliceLengths);
transfMLT = cell(totalLength,1);


for sliceIndex = 1:numSlices
    startIndex = sum(sliceLengths(1:sliceIndex-1))+1;
    endIndex = sum(sliceLengths(1:sliceIndex));
    transfMLT(startIndex:endIndex) = transfMLTcat{1};
    transfMLTcat = transfMLTcat(2:end);
end

save(writePathLT,'transfMLT')
%clear;

sprintf('FINISHED!')
    
