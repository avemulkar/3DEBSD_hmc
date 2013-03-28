function [Ndat] = importfile(fileToRead1)

fid=fopen(fileToRead1);
Ndat = {};
i=1;
while 1
    %Get a line in the file
    tline = fgetl(fid);
    %If end of file break
    if ~ischar(tline), break, end
    %Add line to data
    Ndat{i} = tline;
    %increment index
    i = i + 1;
end
%Close file
fclose(fid);