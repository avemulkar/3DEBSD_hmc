%Generates centroids of each region as well as cordinates for the boundary
%of each major region. The size (number of pixels) that defines by regions
%is determined by Thresh (variable in the program).

function [cent, cords]= imBound(X, Data)

%check to see if image is appropiate
choice=0;

while choice~=1
    imshow(X);
    hold on
    %y1= [0,0; 0,50];
    %plot(y1(:,2)+15, y1(:,1)+140, 'LineWidth',5, 'color',[1,1,1])
    sprintf('Is this fine? (1)\n choose different quantization (2)\n')
    
    choice = input('');
    
    if choice ==2
        clear X;
        numCol = input('How many colors to quantize?: ');
        X=IMAGEipfEDAXQuant(Data, numCol);
        hold on
        y1= [0,0; 0,50];
        plot(y1(:,2)+15, y1(:,1)+140, 'LineWidth',5, 'color',[1,1,1])
        close(gcf);
    end
    close(gcf);
end


%Note code here taken from Steve's Blog
%Make X a 2d matrix for future manipulation hencforth referred to as
%rgb_columns. 
rgb_columns = reshape(X, [], 3);

%We want the unique colors found in rgb_columns 
[unique_colors, m, n] = unique(rgb_columns, 'rows');
color_counts = accumarray(n, 1);

%Human error check to see if the number of colors is correct
fprintf('There are %d unique colors in the image.\n', ...
    size(unique_colors, 1))
unique_colors
m

%Creates the 3-d vector for boundary lines of each plot
A=[0,0];
f=0;
cen=1;

%Here we want to find the slip planes corresponding to the various 
%unique colors found by unique(). The indexes were stored in m, so
%we check each index for valid slip planes
for i=1:(numel(unique_colors)/3)
    bw = n == i;
    bw = reshape(bw, size(X, 1), size(X, 2));
    L = bwlabel(bw);
    s = regionprops(L, 'Area', 'Centroid');

    %own code based on principles shown in Steve's Blog
    %Takes the labels of a given slip plane and shows only those of a certain
    %threshold size
    Thresh=500;
    L = bwlabel(bw);
    NewL=zeros(size(L));
    for k=1:numel(s)
        if (s(k).Area) >Thresh
            s(k).Centroid
            cent(cen,:)=s(k).Centroid;
            cen=cen+1;
            NewL=NewL+(L==k);
        end
    end

    %Plots boundaries of the slices not including holes in a slice
    %Can get position of boundary pixes by use of [B,L,N,A]=boundaries(bw)
    %See matlab for more info

screen_size = get(0, 'ScreenSize');
f1 = figure(1);
set(f1, 'Position', [0 0 screen_size(3) screen_size(4) ] );

    b = bwboundaries(NewL, 'noholes');
    size(b)
    if size(b)>0
        %Plot each chunk in slice individually
        %Controls max # of plots in window, Set this indvidually on what
        %one expects

        for j = 1:numel(b)
            
            f=f+1; %Counter for object # in subimage
            subplot(6,6,f), subimage(NewL);
            hold on
            if j>16
                break
            end
            %Plot the boundary
            plot(b{j}(:,2), b{j}(:,1), 'r', 'Linewidth', 3)
            %store cordinate information for image f
            cords{1, f}(:,2)=b{j}(:,2);
            cords{1, f}(:,1)=b{j}(:,1);
        end
        hold off
    end
    
    %need to delete cell array contents
    for j=1:numel(b)
        b(1)=[];
    end
    clear b;
    
end