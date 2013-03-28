%Wrapper for choosing a boundary within a quantization colormapping
%   for N EdaxColormappings using ipfHn.txt files where n is a number
function [pts]= selectImageBoundaries(start, stop,N)

pts{1}=zeros(1, 1);
pts(1)=[];
cents=zeros(N, 2);

%For each text file, create the edax colormapping matrix and save the image
%to another file
for q=start:stop
    feature dumpmem
    sprintf('Processing Slice %d', q)
    temp=pts;
    
    %delete pt array to clean up memory
    for j=1:numel(pts)
        pts(1)=[];
    end
    clear pts
    
    path    =['ipf', int2str(33-q), '.txt'];
    Data=importfile(path);
    clear path
    
%     for x=1:length(Data);
%         Data(x,2)=Data(x,2)*2;
%         Data(x,3)=Data(x,3)*2;
%     end
%     max(Data(:,2))
%     
%     for x=1:length(Data);
%         if Data(x,2)>1;
%             Data(x,2)=0;
%         end
%         if Data(x,3)>1;
%             Data(x,3)=0;
%         end
%     end
%     max(Data(:,2))
    
%Step 2 build image from txt files\
    QData = IMAGEipfEDAXQuant(Data, 5);
    close(gcf);
    
%Step 3 Find boundary Pts
    %Input: A matrix of the imagedata
    [cent, cords]=imBound(QData, Data);
    hold on
    subplot(4,4,16)
    imshow(QData);
    hold off
    %choose image as boundary of interest
    choice = input('Choose an Image from Figure as Correct Slice') 
    close(gcf);
    temp{q}(:,2)= cords{choice}(:,2);
    temp{q}(:,1)= cords{choice}(:,1);
    
    cents(q,:)=cent(choice,:);
    clear cent
    
    %need to delete cell array contents
    for j=1:numel(cords)
        cords(1)=[];
    end
    clear cords
    
    %1st create new cell array pts
    for i=1:q
        pts{i}=temp{i};
    end
    
    %delete temporary array
    for j=1:numel(temp)
        temp(1)=[];
    end 
    clear temp
    clear QData
    clear Data
        
    sprintf('Finished Processing Slice %d', q)
end



%Write the points information to an external file
fid = fopen('Pts.txt', 'wt'); % Open for writing

for p=1:N
    A= [p*ones((numel(pts{p})/2), 1), 1*ones((numel(pts{p})/2),1) ,pts{p}, 24*(p-1)*ones((numel(pts{p})/2), 1)];
    for i=1:(numel(A)/5)
        fprintf(fid, '%d %d %d %d %d\n', A(i,:) );
    end
   clear A;
    A= [p*ones((numel(pts{p})/2),1 ), 2*ones((numel(pts{p})/2),1), pts{p}, 24*p*ones((numel(pts{p})/2), 1)];
    for i=1:(numel(A)/5)
        fprintf(fid, '%d %d %d %d %d\n', A(i,:) );
    end
   clear A;
end
fclose(fid);

%Write the centroid information to an external file
fid = fopen('Centroids.txt', 'wt'); % Open for writing
for p=1:N
    A= cents(p,:);
    for i=1:(numel(A)/2)
        fprintf(fid, '%d %d \n', A(i,:) );
    end
end
fclose(fid);
