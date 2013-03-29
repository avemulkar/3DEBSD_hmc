%% PLOT CLUSTERS AND BOUNDARIES
% plots the boundaries overlayed on the ipf images for each slice
% plots the clusters for each slice with artificial colors
% plots all clusters together in 3D plot
clc; clear; close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% data selection
dataSetName = 'aluminum_grains';%'nickel_diecompressed'; %
xRange = [0 56]; % [0 18];%
yRange = [0 19.5]; %[0 19];% 
slicerange = [5 5];%[1 30];%

axis_label = {'RD','TD','ND'}; %{x y z}

%% plot options
plotBoundariesOnIPF = true;
Rscaling = 1;
Gscaling = 1;
Bscaling = 1;

pausetime = 1; %pause in seconds between slices

%% write options
saveImage = false;
saveMovie = false;
saveClusters = false;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% add paths
addpath('..\CQ Boundaries\CQ code');
addpath('..\Data\IPF code')
addpath('MB visual code')

%% load boundary pts and assigments and data

boundFolder = ['results from FMSC\' dataSetName];
    minX = xRange(1); maxX = xRange(2);
    minY = yRange(1); maxY = yRange(2);
dataName = ['x' num2str(minX) 't' num2str(maxX) '_'...
             'y' num2str(minY) 't' num2str(maxY) '_'...
             'z' num2str(slicerange(1)) 't' num2str(slicerange(2))];
boundPath = [boundFolder '\boundary_' dataName '.mat'];
assignPath = [boundFolder '\assignment_' dataName '.mat'];
boundarylist = importdata(boundPath);
assignments = importdata(assignPath);

%% load data
dataFolder = ['data for FMSC','\',dataSetName];
dataPath = [dataFolder,'\',dataName,'.txt'];
data = dlmread(dataPath);

%% plot boundaires superimposed on IPF
if plotBoundariesOnIPF
    
%preallocate memory
slices = [slicerange(1):slicerange(end)];
meanRGB = zeros(length(slices),3);
maxRGB = zeros(length(slices),3);

for slice = slices

    %% import that data from path
    fileName = 'scanTrans#.txt';
    fileNameTemp = strrep(fileName,'#',int2str(slice));
    dataPath = ['..\Data\Transformed Data','\',dataSetName,'\',fileNameTemp];
    %Data = importdata(dataPath,' ',headerLines);
    Data = importdata(dataPath);

    
    %% truncate data
    % assumes [euler1 euler2 euler3 x y confidence]
    Data((Data(:,4)<xRange(1))|...
         (Data(:,4)>xRange(2))|...
         (Data(:,5)<yRange(1))|...
         (Data(:,5)>yRange(2)),:) = [];
     
    %% plot the IPF
    plottype = 'imap';
    interpolate = true;
    cleanNoise = false;
    
    subplot(2,1,1)
    hold off;
    [meanRGBi maxRGBi] = plotIPF(Data,plottype,interpolate,cleanNoise,Rscaling,Gscaling,Bscaling);
    
    meanRGB(slice,:) = meanRGBi;
    maxRGB(slice,:) = maxRGBi;
    
    %% plot boundaries
    hold on;
    spacing = estSpacing(data(:,4));
    scaling = 1/spacing;
    pts = boundarylist( round(scaling*boundarylist(:,6))==slice, [4:6]);
    pts = scaling*pts;  
    
    iaxis = axis;
    plot3(pts(:,1),pts(:,2),pts(:,3),'.k','markersize',1)
    view(0,90)
    axis equal; axis(iaxis); axis off;
    
    %% plot assignments
    [mask numClusters] = sliceMask(data,assignments,slice);
    subplot(2,1,2),colormapping(mask,numClusters);
    axis equal; axis(iaxis); axis off;
    set(gca,'YDir','normal')
    
    xlabel(axis_label{1})
    ylabel(axis_label{2}) 
    
    %% write new IPF image to file
    %{
    filename = [ipfImageFolder '\' 'IPFtrans' int2str(slice) '.bmp'];
    print('-dbmp','-r300',filename)
    %saveas(fig,filename)
    %}
    
    pause(pausetime)
end


%% color scaling tuning
sprintf(['can increase scaling by:\n',...
         'r: X %g \n',...
         'g: X %g \n',...
         'b: X %g \n'],...
         1./max(maxRGB))

end

%% plot 3D plot of boundaries and assignments
figure
[clusters M] = plot3assignments(data,assignments,boundarylist);
set(gca,'fontsize',20)
xlabel(axis_label{1})
ylabel(axis_label{2})
zlabel(axis_label{3})


%% save image
if saveImage
    saveFolder = ['Images','\',dataSetName];
    saveName = [dataName '_image'];
    filename = [saveFolder '\' saveName '.tiff'];
    mkdir(saveFolder)
    print(gcf,filename,'-dtiff','-r300')
    ['image saved to: ',filename]
end

%% write movie to file
if saveMovie
    writeFolder = ['Animation\',dataSetName];
    mkdir(writeFolder)
    writePath = [writeFolder,'\',dataName,'.avi'];
    movie2avi(M,writePath,'compression','Cinepak','fps',5);
    ['movie saved to: ',writePath]
end

%% save clusters
if saveClusters
    clusterFolder = ['Images\' dataSetName];
    mkdir(clusterFolder);
    clusterPath = [clusterFolder '\' dataName '.mat'];
    save(clusterPath,'clusters')
    ['clusters saved to: ',clusterPath]
end



