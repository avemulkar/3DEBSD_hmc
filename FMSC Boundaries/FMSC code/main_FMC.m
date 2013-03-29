%% main_FMC
% clc; close all;
% if ( matlabpool('size')>0 )
%     matlabpool('close')
% end

addpath('sparsesubaccess')

%% FMC Inputs
%Data Selection,  format: [lower bound, upper bound]
% dataSetName = 'nickel_diecompressed';
% xRange = [6 14];
% yRange = [2 16];
% slicerange = [1 5];

%Analysis Parameters
%saliency = .05; %decrease to increase microband size
%cmaha = 5;  %decrease for more grouping
%quatmax = 10;  %increase for more grouping
%gammaW = 500;
%minClustSize = 500*length([slicerange(1):slicerange(end)]); %increase for more grouping
%minConf = .6;
%alpha = .4;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Import Data and LT
minX = xRange(1); maxX = xRange(2);
minY = yRange(1); maxY = yRange(2);

dataFolder = fullfile('data for FMSC',dataSetName);
dataName = ['x' num2str(minX) 't' num2str(maxX) '_'...
             'y' num2str(minY) 't' num2str(maxY) '_'...
             'z' num2str(slicerange(1)) 't' num2str(slicerange(2))];
dataPath = fullfile(dataFolder,[dataName '.txt']);
dataPathLT = fullfile(pwd,dataFolder,[dataName '_LT' '.mat']);

data = dlmread(dataPath);
LT = importdata(dataPathLT);

%% Write Path
writepath = [fullfile('results from FMSC', dataSetName)];
mkdir(writepath);

Aname = [fullfile(writepath, ['assignment_' dataName '.mat'])];
Bname = [fullfile(writepath, ['boundary_' dataName  '.mat'])];
Wkspcname = [fullfile(writepath, ['workspace_' dataName '.mat'])];
logname = [fullfile(writepath, ['\log_' dataName '.txt'])];

%% diary
% diary(logname);
% [fullfile(dataSetName,dataName)];
% paramStr = ['cmaha0:     %g\n',...
%             'cmaha:        %g\n',...
%             'quatmax:      %g\n',...
%             'gammaW:       %g\n'];
% sprintf(paramStr, cmaha0,cmaha,quatmax,gammaW)

%% setup 3D
disp('starting setup 3D')
tic
% toc
[Wnext,  Aves, ~]=setup3D_fast(LT, data,cmaha0,matlabpool('size'));

% toc
% {'Wnext' size(Wnext,1) size(Wnext,2) nnz(Wnext);
%  'Aves' size(Aves,1) size(Aves,2) nnz(Aves)}
%clear variables to make room in memory
clear LT; clear data;

%% RunFMC
disp('starting RunFMC')
% toc
% matlabpool(numcores)

%function [AllSals storage lengths] = RunFMC(Wnext, Avesin, z, quatmax,cmaha)
RunFMC;

%clear variable to make room in memory
% matlabpool close
clear Wnext; clear Aves; clear z;
% toc

%% Prepare for Interpret
'saving results'
% toc
%reload variables
data = dlmread(dataPath);
LT = importdata(dataPathLT);

%reconstruct AllSals
storage = [];
for sindex = 1:s
    %function [Pwrite Psize] = spread(Psize,sindex)
    spread;
    storage=[storage, struct('Ps', P)];
    clear P;
end

rmdir('temp_files');

% 'inputs to interpret 3D'
% [size(AllSals) nnz(AllSals)]
% [size(storage)]
% [size(Sallengths) nnz(Sallengths)]

save(Wkspcname,'AllSals','storage','Sallengths');

disp('FMC finished!')
% toc

%% end

rmpath('sparsesubaccess')

