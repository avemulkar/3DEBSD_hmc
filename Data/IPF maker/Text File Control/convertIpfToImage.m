%Wrapper Method for creating hexagonal data files
%Method:
%   -hexFile converts each hexagonal index to a set of 
%       square pixels in a matrix grid

function convertIpfToImage(N)
    for i = 1:N
        hexFile(i);
    end
end