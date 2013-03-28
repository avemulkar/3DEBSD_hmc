function plotIPF(eul,coordinates)
% plots the IPF of a single slice of 2D data
% eulers: Matrix (Nx3) [euler1 euler2 euler3]
% coordinates: Matrix (Nx2) [x y ]

% converts euler angles to ipf rgb values
% assumes cubic symmetry

% convert to mtex orientation
CS = symmetry('m-3m');
SS = symmetry('-1');
o = orientation('Euler',eul(:,1),eul(:,2),eul(:,3),CS,SS);
ebsd = EBSD(o,'xy',coordinates);
plot(ebsd,'antipodal')
colorbar


%function plotIPF(eulers,coordinates)
% plots the IPF of a single slice of 2D data
% eulers: Matrix (Nx3) [euler1 euler2 euler3]
% coordinates: Matrix (Nx2) [x y ]

%% Import Script for EBSD Data
%
% This script was automatically created by the import wizard. You should
% run the whoole script or parts of it in order to import your data. There
% is no problem in making any chages to this scrip.

%% Specify Crystal and Specimen Symmetries

% crystal symmetry
CS = symmetry('m-3m');

% specimen symmetry
SS = symmetry('-1');

% plotting convention
plotx2north

%% Specify File Names

% path to files
pname = 'C:\Users\Brian\Documents\3DEBSDrepos\Data\Cleaned Data\aluminum_grains\';

% which files to be imported
fname = {...
[pname 'scanClean1.txt'], ...
};


%% Import the Data

% create an EBSD variable containing the data
ebsd = loadEBSD(fname,CS,SS,'interface','generic' ...
  , 'RADIANS', 'ColumnNames', { 'Euler 1' 'Euler 2' 'Euler 3' 'x' 'y'}, 'Columns', [1 2 3 4 5], 'Bunge', 'unitCell', [-0.25 0.25 0.25 -0.25]);


%% Default template
%% Visualize the Data

plot(ebsd)


%% Calculate an ODF

odf = calcODF(ebsd)

%% Detect grains

%segmentation angle
segAngle = 10*degree;

grains = calcGrains(ebsd,'threshold',segAngle);

%% Orientation of Grains

plot(grains)
'stop'
