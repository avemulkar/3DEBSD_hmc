%renameFile
fileName = 'data with different name/slice#.txt';
writeName = 'scanClean#.txt';
sliceRange = [1:32];

%% for all slices
for sliceI = [1:length(sliceRange)]
    slice = sliceRange(sliceI);
    
    %% import current file
    fileNameTemp = strrep(fileName,'#',int2str(slice));
    data = importdata(fileNameTemp);
    
    %reorder from x y z e1 e2 e3
    %to e1 e2 e3 x y conf
    data = [data(:,4:6) data(:,1:2) ones(size(data,1),1)];
    
    %% save as new file
    writeNameTemp = strrep(writeName,'#',int2str(slice));
    save(writeNameTemp,'data','-ascii','-tabs')
    
    %% erase file
    %delete(fileName)
    
end