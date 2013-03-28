%% Plot IPF
% Plots data with the inverse pole figure coloring
% clc; clear; close all;

%% data set parameters
% dataSetName =  'aluminum_grains';
% xRange = [6.5 47]; %[8 13]; %[0 56]; %microns
% yRange = [0.5 18];%[11 15]; %[0 19.5]; %microns
% slices = 5; %slices

%  dataSetName = 'aluminum_rolled';
%  xRange = [2 19]; %[6 20]; %[0 25]; %[0 12];
%  yRange = [8 15]; %[0 8.5]; %[0 8.5]; %[5 8.5];
%  slices = 74; %74

% dataSetName =  'nickel_diecompressed';
% xRange = [4 18];%[8 13]; %microns
% yRange = [4 16];%[11 15]; %microns
% slices = 5; %slices

dataSetName =  'aluminum_tensile';
xRange = [1 35];%[5 15];%[1 38]; %microns
yRange = [2 20];%[13 18];%[1 20]; %microns
slices = 49; %slices

% dataSetName = 'toy';
% xRange = [0 7.5];
% yRange = [0 5];
% slices = 1;



% data type? 
% options: 'raw', 'cleaned', 'transformed'
dataType = 'cleaned';
numHeaderLines = 97; %for importing raw data only

%% plotting parameters
%exagerate colors by scaling
% [Rscaling Gscaling Bscaling]
scaling = [1 1 1];
PtSize=10;

%plot type 
%options: 'mtex','impap'
Coloring = 'MTEX';     %['EDAX', 'PMTEX', or 'MTEX']
plottype2D = 'imap'; 
scatter3D = false;
interpolate = false; %for imap
plotlabels = true;


%% write image
writeSliceImages = false;
write3DImage = false;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% preliminary
% digits(5)
addpath(fullfile('..', 'CQ Boundaries', 'CQ code'));
addpath('IPF code');

%% make read path
if strcmp(dataType,'raw')
    % Import raw data from path 
    dataFolder = 'Raw Data';
    fileName = 'scan#.txt';
elseif strcmp(dataType,'cleaned')
    % Import cleaned data from path 
    dataFolder = 'Cleaned Data';
    if strcmp(dataSetName,'aluminum_tensile')
        fileName = 'Scan# cleaned.ang';
    elseif strcmp(dataSetName,'aluminum_tensile')
        fileName = 'Scan#.txt';
    else
        fileName = 'scanClean#.txt';
    end
elseif strcmp(dataType,'transformed')
    % Import transformed data from path 
    dataFolder = 'Transformed Data';
    fileName = 'scanTrans#.txt';
else
    sprintf(['error: dataType should be',...
             '"raw","cleaned", "transformed"'])
end

%% make write directory
if writeSliceImages || write3DImage
    ipfImageFolder = ['IPF Images','\',dataSetName];
    mkdir(ipfImageFolder);
end

%% for all slices

% preallocate memory
numSlices = length(slices);
meanRGB = zeros(numSlices,3);
maxRGB = zeros(numSlices,3);
scatterData = cell(numSlices,1);

% for all slices
for sliceI = 1:numSlices
    slice = slices(sliceI);
        
    %% import that data from path 
    fileNameTemp = strrep(fileName,'#',int2str(slice));
    dataPath = fullfile(dataFolder,dataSetName,fileNameTemp);
    if (strcmp(dataType,'raw') || strcmp(dataSetName,'aluminum_tensile'))
        Data = importdata(dataPath,' ',numHeaderLines);
        Data = Data(1,1).data;
    else
        Data = importdata(dataPath);
       
    end
    
    %% truncate data
    % assumes [euler1 euler2 euler3 x y confidence]
    Data((Data(:,4)<xRange(1))|...
         (Data(:,4)>xRange(2))|...
         (Data(:,5)<yRange(1))|...
         (Data(:,5)>yRange(2)),:) = [];
     
    %removes points that have euler of all zeros
    allZeroI = all(Data(:,1:3)==0,2);
    Data(allZeroI,:)=[];
    
    %plotIPF(Data(:,1:3),Data(:,4:5))
    
    %% calculate IPF colors
    if strcmp(Coloring, 'PMTEX')
        cs = symmetry('cubic');
        ss = symmetry('cubic');
        o = orientation('Euler',Data(:,1:3),cs,ss);
        [fundEulers,~] = Euler(project2FundamentalRegion(o),cs);
        IPFcolors = myeuler2rgb(fundEulers);
        
    elseif strcmp(Coloring, 'EDAX');
        addpath(fullfile('IPF maker','Inverse Pole Figure'))
        addpath(fullfile('IPF maker','EDAX Colormapping'))
        [ipfC] = ipfplotter(Data(:,1:5));
        [Red, Green, Blue, posX, posY] = EDAX(ipfC(:,1), ipfC(:,2), ipfC(:,4), ipfC(:,5));    
        IPFcolors=cat(2,Red,Green,Blue);
        Data(:,4:5) = [posX posY];
                
    elseif strcmp(Coloring, 'MTEX')
          IPFcolors = myeuler2rgb(Data(:,1:3));
    end
    
    
     
    %% plot the data
    [meanRGBi maxRGBi spacing] = plotRGB(Data(:,4:5),IPFcolors,...
                                          plottype2D,interpolate,scaling);
    numPts = size(Data,1);
    zvec = slice*spacing*ones(numPts,1);
    scatterData{sliceI} = [IPFcolors, Data(:,4:5), zvec];
    meanRGB(sliceI,:) = meanRGBi;
    maxRGB(sliceI,:) = maxRGBi;
    
    %% plot labels
    if plotlabels
        title(['slice ' int2str(slice)])
    else
        set(gca,'xtick',[],'ytick',[],'layer','bottom','box','on','fontsize',20)
    end
    
    
    %% write image to file
    if writeSliceImages
        axis off
        filename = fullfile(ipfImageFolder,[dataType,int2str(slice),'.tif']);
        print('-dtiff','-r300',filename) 
    end
    
    pause(.1)
end

%% plot scatter plot
if scatter3D
    scatterData = cell2mat(scatterData);
    scatter3(scatterData(:,4),scatterData(:,5),scatterData(:,6),...
            PtSize,scatterData(:,1:3),'Filled','Square');
    pause(.1)
    box on; axis equal;
    %set(gca,'Zdir','reverse')
    
    if write3DImage
        zRange = [slices(1) slices(end)]*spacing;
        fileDescript = ['x' num2str(xRange(1)) 't' num2str(xRange(end)) '_',...
                        'y' num2str(yRange(1)) 't' num2str(yRange(end)) '_',...
                        'z' num2str(zRange(1)) 't' num2str(zRange(end))];
        filename = fullfile(ipfImageFolder,[dataType,'_',fileDescript,'.tif'])
        print('-dtiff','-r300',filename)
    end
    
end

% %% plot rgb data
% figure; hold on;
% set(gca,'ColorOrder',[1 0 0;0 1 0; 0 0 1])
% 
% % plot mean/max rgb vs slice
% plot(slices,meanRGB(:,1:3))
% plot(slices,maxRGB(:,1:3))
% 
% title('mean and max rgb values')
% xlabel('slice')
% ylabel('rgb value')
% 
% sprintf(['can increase scaling by:\n',...
%          'r: X %g \n',...
%          'g: X %g \n',...
%          'b: X %g \n'],...
%          1./max(maxRGB))
%      
 %% plot color scale
% ebsdColorbar(symmetry('m-3m'),'colorcoding','hkl','position',[100 100 285 197])
 

% hold on
% bl = boundarylist/spacing; 
% scatter3(bl(:,4)-xRange(1)/spacing*ones(length(bl(:,4)),1),bl(:,5)-yRange(1)/spacing*ones(length(bl(:,5)),1),bl(:,6),10,'k','Filled','Square');
% hold off