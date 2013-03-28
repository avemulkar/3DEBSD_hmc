%Wrapper Method for creating hexagonal data files
%Method:
%   Iterate through N files
%   -cropFiles removes extra, unused data from the file
%       Specific to the Quadir file formats
%   -hexPos converts data sample positions to integer 
%       indexes on a hexagonal grid
%   -hexFile converts each hexagonal index to a set of 
%       square pixels in a matrix grid

function createHex(N)
    for i = 1:N
        cropFiles(i);
        hexPos(i);
        %hexFile(i);
    end
end