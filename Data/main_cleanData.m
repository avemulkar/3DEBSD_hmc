%% Clean Data
% Plots data with the inverse pole figure coloring
clc; clear; close all;

%% data set parameters
dataSetName = 'aluminum_grains';

slices = [1:32];

numHeaderLines = 0; %for importing raw data only

%% plotting parameters
cleanUnassigned = true; %for unassigned points (eulers = [0 0 0])
cleanNoise = false; %for mostly uniform data (single grain)

%% write cleaned data
writeCleanData = true;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% preliminary
digits(5)
addpath('..\CQ Boundaries\CQ code');
addpath('IPF code');

%% make read path
% Import raw data from path 
dataFolder = 'Raw Data';
fileName = 'scan#.txt';

%% make write directory
if writeCleanData
    writeFolder = 'Cleaned Data';
    cleanDataFolder = fullfile(writeFolder,dataSetName);
    mkdir(cleanDataFolder);
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
 
    Data = importdata(dataPath,' ',numHeaderLines);
    cleanData = Data;
    
    %% clean unassigned
    if cleanUnassigned
        unassignI = all(cleanData(:,1:3)==0,2);
        cleanData(unassignI,:) = [];
    end

    %% clean noise
    if cleanNoise
        stdevs = 2.5;
        IPFcolors = myeuler2rgb(cleanData(:,1:3));
        [~, outlier] = cleanPixels(IPFcolors,stdevs);
        cleanData(outlier,:) = [];
    end
    
    %% calculate IPF colors
    dataIPF = myeuler2rgb(Data(:,1:3));
    cleanDataIPF = myeuler2rgb(cleanData(:,1:3));
    
    %% plot the data
    interpolate = false;
    scaling = [1 1 1];
    
    figure(1)
    subplot(2,1,1)
    plotRGB(Data(:,4:5),dataIPF,'imap',interpolate,scaling);
    xlabel('original data')
    title(['slice ' int2str(slice)])
    
    subplot(2,1,2)    
    plotRGB(cleanData(:,4:5),cleanDataIPF,'imap',interpolate,scaling);
    xlabel('cleaned data')
    
    %% write cleaned data to file
    if writeCleanData
        writeName = ['scanClean' int2str(slice) '.txt'];
        writePath = fullfile(writeFolder,dataSetName,writeName);
        save(writePath,'cleanData','-ASCII','-tabs')
    end
        
    pause(.1)
end
 

