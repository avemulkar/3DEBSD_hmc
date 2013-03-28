%renameFile
fileName = 'aluminum_grains\scanTrans#.txt';
writeName = 'aluminum_grains\scan#.txt';
sliceRange = [1:32];

%mkdir('..\..\Cleaned Data\nickel_diecompressed')

%% for all slices
for sliceI = [1:length(sliceRange)]
    slice = sliceRange(sliceI);
    
    %% import current file
    fileNameTemp = strrep(fileName,'#',int2str(slice));
    data = importdata(fileNameTemp,' ',32);
    data = data.data;
    
    %reorder from e1 e2 e3 x y _ conf _ _ _
    %to e1 e2 e3 x y conf
    %data = [data(:,1:5) data(:,7)];
    
    %% save as new file
    writeNameTemp = strrep(writeName,'#',int2str(slice));
    save(writeNameTemp,'data','-ascii','-tabs')
    
    %% erase file
    %delete(fileName)
    
end