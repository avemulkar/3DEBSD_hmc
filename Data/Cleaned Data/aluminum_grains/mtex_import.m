clc
CS = symmetry('m-3m'); % crystal symmetry
SS = symmetry('-1');   % specimen symmetry

% file name
fname = fullfile('c:','Users','Andrew','Desktop','Research','3DEBSDrepos','Data','Cleaned Data','aluminum_grains',...
    'scanClean5.txt');

% import ebsd data
ebsd = loadEBSD(fname, CS, SS, 'interface','generic',...
  'RADIANS', 'ColumnNames', { 'Euler 1' 'Euler 2' 'Euler 3' 'x' 'y'},...
  'Columns', [1 2 3 4 5],'ignorePhase', 0, 'Bunge', 'flipud');

plotx2east

grains = calcGrains(ebsd,'threshold',10*degree);

figure(1)
plot(ebsd)
hold on
plotBoundary(grains)
hold off
figure(2)
plot(grains)

%% Smaller region for testing
region = [0 0; 0 2;2 2; 2 0; 0 0];
in_region = inpolygon(ebsd,region);
ebsdR = ebsd( in_region );
plot(ebsdR)
grainsR = calcGrains(ebsdR,'threshold',10*degree);
plot(grainsR)

%% 3D
CS = symmetry('m-3m');  % crystal symmetry
SS = symmetry('-1');   % specimen symmetry

dirName = fullfile('c:','Users','Andrew','Desktop','Research','3DEBSDrepos','Data','Cleaned Data','aluminum_grains','3Dgrains');
Z = (1:32)*0.5;
ebsd = loadEBSD(dirName, CS, SS, 'interface', 'generic',...
  'RADIANS', 'ColumnNames', { 'Euler 1' 'Euler 2' 'Euler 3' 'x' 'y'},...
  'ignorePhase', 0, 'Bunge','3d', Z)
%%
grains = calcGrains(ebsd,'threshold',10*degree,'unitcell');

%%
plot(grains([22 26 28]))
material dull
camlight('headlight')
lighting gouraud

%%
smooth_grains = smooth(grains,10);
grain = smooth_grains(smooth_grains == grains(26));
neighbouredGrains = neighbours(smooth_grains,grain)

figure, hold on

for partnerGrain = neighbouredGrains
  if partnerGrain ~= grain
   plotBoundary([grain partnerGrain],'property','angle','FaceAlpha',1,'BoundaryColor','k');
  end
end
colorbar

plot(neighbouredGrains(1:end-2),'facealpha',0.1,'edgecolor','k')

view([150 20])
material dull

camlight('headlight')
lighting phong

%%
plot(smooth_grains(26),...
  'FaceColor','g','EdgeColor',[0.7 0.7 0.7],'FaceAlpha',0.05)

hold on,
plotSubBoundary(smooth_grains(26),...
  'FaceColor','c','BoundaryColor','r','EdgeColor','k')

%slice3( misorientation(grains,ebsd),'y',1.25,'property','angle',...
%  'FaceAlpha',0.7)

view([35 15])

%%
slice3(smooth_grains,'x',5,'margin',1,...
  'FaceColor','k','FaceAlpha',0.3)

hold on
slice3(ebsd,'x',4)
axis tight
view(105,15)