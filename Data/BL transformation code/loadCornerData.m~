function [data corners msg] = loadCornerData(dataSetName,slice)
% loads data and corner points
% data: Matrix (Nx6) [euler1 euler2 euler3 x y confidence]
% corners: Matrix (4x2) [x y]

dataFolder = 'Cleaned Data';
fileName = 'scanClean#.txt';

%% Import that data
fileNameTemp = strrep(fileName,'#',int2str(slice));
dataPath = [fullfile(dataFolder,dataSetName,fileNameTemp)];
if exist(dataPath,'file')
    data = importdata(dataPath);
else
    error(['data does not exist: ',dataPath])
end

%% Import the corners
cornerpath = [fullfile('Corner Points',strcat(dataSetName,'.txt'))];
if exist(cornerpath,'file')
    % if corner file exists
    corners = importdata(cornerpath);

    if size(corners,1)<slice
        % if corners for slices doesn't exist
        corners = [];
        msg = 'No corner file exists';  
    else
        % if corners fro slice do exist
        corners = corners(slice,:);
        corners = reshape(corners,2,4)';
        msg = 'Found corner file';
    end
else
    % if corner file does not exist
    corners = [];
    msg = 'No corner file exists';    
end