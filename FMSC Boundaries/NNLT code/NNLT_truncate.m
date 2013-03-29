function transfM = NNLT_truncate(transfM,xRange,yRange,plotYN,confidence,axisLim)

minX = xRange(1); maxX = xRange(end);
minY = yRange(1); maxY = yRange(end);

%% plot data and check that its OK
%returns - which has a minimum confidence level
if plotYN == 1
    transf2plot = transfM(transfM(:,7)>confidence,:);
    figure(1)
    subplot(2,1,1),plot(transf2plot(:,4),transf2plot(:,5),'.b','markersize',2)
    title('specified x range and y range of slice')
    ylabel('Height (microns)');
    axis(axisLim);
    line([minX maxX; minX maxX; minX minX; maxX maxX],...
         [minY minY; maxY maxY; minY maxY; minY maxY],...
         'linestyle','--','color','r')
end

%% delete all points in TransfM that are outside the real dimensions
%i.e. get rid of all extraneous points, to get lessen size of data set
%returns - transfMstruct(sliceIndex)
transfM(transfM(:,4)<minX,:)=[]; %delete x<minX
transfM(transfM(:,4)>maxX,:)=[]; %delete x>maxX
transfM(transfM(:,5)<minY,:)=[]; %delete y<minY
transfM(transfM(:,5)>maxY,:)=[]; %delete y>maxY

%% plot data again and check that its still OK
%returns - which has a maximum confidence level
if plotYN == 1
    %transf2plot = transfM(transfM(:,7)>confidence,:);
    transf2plot = transfM(transfM(:,7)>confidence,:);
    figure(1)
    subplot(2,1,2),plot(transf2plot(:,4),transf2plot(:,5),'.b','markersize',2)
    xlabel('Width (microns)'); ylabel('Height (microns)');
    axis([xRange yRange])
    pause(.1)
end