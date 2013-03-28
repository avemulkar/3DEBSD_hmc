% rearrange the corner points from
% counter clockwise to clockwise

dataSetName = 'nickel_diecompressed_old'

%% import data
corners = importdata([dataSetName '.mat']);

%% rearrange corners
corners = corners(:,[1 2 7 8 5 6 3 4]);

dataSetName = 'nickel_diecompressed';
save([dataSetName '.mat'],'corners')