%% NNLT_checker
dataSetName =  'aluminum_grains';
xRange = [8 13]; %[0 56]; %microns
yRange = [11 15]; %[0 19.5]; %microns
slicerange = [5 5]; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Check
% load data and LT
minX = xRange(1); maxX = xRange(2);
minY = yRange(1); maxY = yRange(2);

addpath('NNLT code')

dataFolder = ['data for FMSC','\',dataSetName];
dataName = ['x' num2str(minX) 't' num2str(maxX) '_'...
             'y' num2str(minY) 't' num2str(maxY) '_'...
             'z' num2str(slicerange(1)) 't' num2str(slicerange(2))];
dataPath = [dataFolder,'\',dataName,'.txt'];
dataPathLT = [pwd,'\',dataFolder,'\',dataName,'_LT','.mat'];

data = dlmread(dataPath);
LT = importMatFile(dataPathLT);

% pick a point and plot NN, ctrl-c to quit
sprintf(['pick a point to view its neighbors\n',...
         'hit contr-c to quit\n',...
         'choose from points 1-%g'], size(data,1))

while 1
    pt = input('point?')  %Add condition that point exceeds dimension
    xyz = data(pt,4:6)
    LTarray = LT{pt};
    NN = [];
    for index = 1:length(LTarray)
        NN(index,:) = data(LTarray(index),4:6);
    end
    clf
    plot3(xyz(1),xyz(2),xyz(3),'.r','markersize',20)
    hold on
    plot3(NN(:,1),NN(:,2),NN(:,3),'.b','markersize',20)
    view(0,90)
end