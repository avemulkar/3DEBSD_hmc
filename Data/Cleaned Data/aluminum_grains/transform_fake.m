%% transform_fake
%  reformats data and 
%  saves it to the transformed data folder
clc

slices = [1:32];

%% specify write paths
writeFolder = ['..\..\Transformed Data\aluminum_grains'];
mkdir(writeFolder);

numSlices = length(slices);
XYmax = zeros(numSlices,2);
for index = 1:numSlices
    %% import
    sliceNum = slices(index);
    ['slice: ' num2str(sliceNum)]
    readName = ['slice' num2str(sliceNum) '.txt'];
    data = importdata(readName);
    
    %% reformat (simulate transform)
    %cleanPts = data(:,1);
    %data(~cleanPts,:)=[]; %delete not clean pts
    %data = data(:,[4:6,2:3,7]); %keep [eul1 eul2 eul3 x y conf]
    confidences = ones(size(data,1),1); %add fake confidences
    data = [data(:,[4:6,1:2]) confidences];
    
    XYmax(index,:) = max(data(:,4:5));
    
    %% save
    writeName = ['scanTrans' num2str(sliceNum) '.txt'];
    writePath = [writeFolder '\' writeName];
    save(writePath,'data','-ascii','-tabs')
end

'the maximum X Y coordinates were:'
XYmax