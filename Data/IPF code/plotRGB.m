function [meanRGB maxRGB spacing] = plotRGB(coordinates,RGB,plottype,interpolate,scaling)
% plots the IPF of a single slice of 2D data
% data: Matrix (Nx6) [euler1 euler2 euler3 x y confidence]
% scaling: Vector (3x1) [Rscaling Gscaling Bscaling]


%% rescale colors
meanRGB = mean(RGB);
if nargin>4
    RGB(:,1) = scaling(1)*RGB(:,1);
    RGB(:,2) = scaling(2)*RGB(:,2);
    RGB(:,3) = scaling(3)*RGB(:,3);
end
satpix = nnz(RGB>1);
maxRGB = max(RGB);

% saturate rgb values > 1
RGB(RGB>1) = 1;
RGB(RGB<0) = 0;

%% plot

if strcmp(plottype,'scatter')
    %% scatter plot
    scatter(coordinates(:,1),coordinates(:,2),PtSize,RGB,'s','filled');
    sprintf(['           slice: %g \n',...
             'saturated pixels: %g'],...
             slice,satpix)

elseif strcmp(plottype,'imap')
    %% imap plot
    % map x y coordinate to array entry
    [spacing avg] = estSpacing(coordinates(:,1));

    colorList = [RGB coordinates(:,1:2)];
    IPFcolorsMap = MapFromList(colorList,spacing);

    % interpolate black or white points
    if nargin>3 && interpolate
        IPFcolorsMap = interpImage(IPFcolorsMap,'black');
    end

    % plot colormap
    image(IPFcolorsMap);
    set(gca,'YDir','normal')

    % print variables
    sprintf(['    mean spacing: %g \n',...
             ' assumed spacing: %g \n',...
             'saturated pixels: %g'],...
             avg,spacing,satpix)

else
    sprintf('invalid plottype: "scatter" or "imap"')

end

%% fix axis
axis equal
axis tight


