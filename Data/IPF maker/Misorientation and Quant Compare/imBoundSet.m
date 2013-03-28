function imBoundSet(X) %[cent, cords]

%Note code here taken from Steve's Blog
%Make X a 2d matrix for future manipulation hencforth referred to as
%rgb_columns. 
rgb_columns = reshape(X, [], 1);

%We want the unique colors found in rgb_columns 
[unique_colors, m, n] = unique(rgb_columns, 'rows');
color_counts = accumarray(n, 1);

%Human error check to see if the number of colors is correct
fprintf('There are %d unique colors in the image.\n', ...
    size(unique_colors, 1))
unique_colors;
m;

%Creates the 3-d vector for boundary lines of each plot
A=[0,0];
f=0;
cen=1;
%Here we want to find the slip planes corresponding to the various 
%unique colors found by unique(). The indexes were stored in m, so
%we check each index for valid slip planes
for i=2:(numel(unique_colors))
    bw = n == i;
    bw = reshape(bw, size(X, 1), size(X, 2));
    L = bwlabel(bw);
    s = regionprops(L, 'Area', 'Centroid');

    %own code based on principles shown in Steve's Blog
    %Takes the labels of a given slip plane and shows only those of a certain
    %threshold size
    Thresh=0;
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


    b = bwboundaries(NewL, 'noholes');
    b;
    size(b);
    if 1 %size(b)>0
        %Plot each chunk in slice individually
        %Controls max # of plots in window, Set this indvidually on what
        %one expects
        %plots= 6                         %ceil(sqrt(numel(b)));
        for j = 1:numel(b)
            f=f+1; %Counter for object # in subimage
            %subplot(4,3,f), subimage(NewL);    %use so each boundary is a
                                                %seperate image
            hold on
            %if j>16
                %break
            %end
            %Plot the boundary
            %Currently edited to plot all boundaries in one image
            if(i==1)
                plot(b{j}(:,2), b{j}(:,1), 'g', 'Linewidth', 3);
            end
            if(i==2)
                plot(b{j}(:,2), b{j}(:,1), 'yellow', 'Linewidth', 3);
            end
            if(i==3)
                plot(b{j}(:,2), b{j}(:,1), 'green', 'Linewidth', 3);
            end
            if(i==4)
                plot(b{j}(:,2), b{j}(:,1), 'black', 'Linewidth', 3);
            end
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
    b;
    clear b;
end