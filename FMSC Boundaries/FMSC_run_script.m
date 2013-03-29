%% FMC run script
% will save ouput of NNLT to "boundaries for FMSC" folder
% will save output of FMC to "boundaries from FMSC" folder
% FMC will create temporary folder in directory containing Ps#.mat

% file names determined by datasetname, data range
% will overwrite existing files. manually archive before re-rerunning.

clc; clear; close all;

%% data selection
dataSetName =  'aluminum_rolled';
xRange = [2 19]; %[0 20];%[1 15];%[8 13]; %[0 56]; %microns [0 20]
yRange = [8 15]; %[0 8.5];%[1 7];%[11 15]; %[0 19.5]; %microns [0 8.5]
slicerange = [74 74];

% dataSetName =  'aluminum_grains';
% xRange = [6.5 47]; %microns
% yRange = [.5 18]; %microns
% slicerange = [5 5]; %slices

% dataSetName =  'aluminum_tensile';
% xRange = [1 35];%[5 20]; %microns
% yRange = [2 20];%[3 18]; %microns
% slicerange = [72 72]; %slices 

% dataSetName =  'nickel_diecompressed';
% xRange = [4 18];%[8 13]; %microns
% yRange = [4 16];%[11 15]; %microns
% slicerange = [5 5]; %slices

% dataSetName = 'toy';
% xRange = [0 7.5];
% yRange = [0 5];
% slicerange = [1 1];

%% nearest neighbors
radius = 0.15;%0.71;%0.15;%.71; %for slice i: (x^2+y^2 < radius)
sliceSpacing = 0.1;%0.5;%.1; %for slice i-1, i+1 : (x^2+y^2+sliceSpacing^2 < radius) 

%% FMC
cmaha0 = 0.05; %decrease to increase microband size
cmaha = 3;  %decrease for more grouping%2
quatmax = 5;  %increase for more grouping
gammaW = 25;
alpha = 0.28;

%% interpret FMC results
minConf = 0.3;%.3;
minClustSize = 10;
%% computer 
numcores = 2;
% matlabpool(numcores)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% run nearest neigbors
% addpath('NNLT code')
% NNLT(dataSetName,xRange,yRange,slicerange,sliceSpacing,radius)
% rmpath('NNLT code')
%% run FMC

addpath('FMSC code')
main_FMC
rmpath('FMSC code')

%% interpret FMC results
% profile on; tic
addpath('FMSC code')
% main_interpret
[assignments boundarylist]=PARinterpret3D_fast(AllSals, storage, Sallengths,LT, data, minClustSize, minConf,sSeeds);
plot2assignments(data,assignments,51,100);
% sound(sin(2*pi/18*[1:10000]));
rmpath('FMSC code')
% profile viewer
% makeVisible






