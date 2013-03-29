%% main_interpret

addpath('MB visual code')

%% Write Path
minX = xRange(1); maxX = xRange(2);  %Determine the range of data along the x axis
minY = yRange(1); maxY = yRange(2);  %Determine the range of data alonf the y axis

dataFolder = [fullfile('data for FMSC',dataSetName)];
dataName = ['x' num2str(minX) 't' num2str(maxX) '_'...
            'y' num2str(minY) 't' num2str(maxY) '_'...
            'z' num2str(slicerange(1)) 't' num2str(slicerange(2))];

dataPath = [fullfile(dataFolder,[dataName '.txt'])];
dataPathLT = [fullfile(pwd,dataFolder,[dataName '_LT' '.mat'])];

writepath = [fullfile('results from FMSC',dataSetName)];
Aname = [writepath 'assignment_' dataName '.mat'];
Bname = [writepath 'boundary_' dataName  '.mat'];
Wkspcname = [fullfile(writepath, ['workspace_' dataName '.mat'])];
Wkspcname
data = dlmread(dataPath);
LT = importdata(dataPathLT);
load(fullfile(Wkspcname));

rmdir('Output Files','s');
mkdir('Output Files');

sSeeds = [];
%% run interpret 3D
% tic
[assignments boundarylist]=PARinterpret3D_fast(AllSals, storage, Sallengths,LT, data, minClustSize, minConf,sSeeds);
% {'assignments'  size(assignments)  nnz(assignments);...
%  'boundarylist' size(boundarylist) nnz(boundarylist)}
% toc

%% Save Results
save(Aname,'assignments');
save(Bname,'boundarylist');
diary off;

%% Plot Results

%plot clusters
% plot2assignments(data,assignments,50);

% % %plot boundaries
% figure(1)
% scatter3(boundarylist(:,4),boundarylist(:,5),boundarylist(:,6),10,'k','Filled','Square');
% view(0,90)
% % title('Boundary Points')
% axis equal
% axis tight

% % %plot clusters

%[clusters M] = plot3assignments(data,assignments,boundarylist);
% % sprintf('press any key to continue')
% % pause()
% 
% 'Plotting' %#ok<NOPTS>
% toc
% 
% % figure('Visible','off');
% figure(3)
% warning('off', 'all');
% plot3assignments_IPF_Coloring(data,assignments);
% plot3assignments(data,assignments);
% view(0,90)
% title('Final Plot - IPF Coloring')
% % saveas(gcf,fullfile('Output Files','Final Figure.fig'));
% % save(fullfile('Output Files','Results.mat'));

%%confidence map
% % figure(2)
% % confidenceMap(data,assignments)
% % title('Confidence Map')




%% end
% matlabpool close
rmpath('MB visual code')