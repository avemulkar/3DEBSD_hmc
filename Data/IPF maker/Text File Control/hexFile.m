%hexFile

%Convert a hexfile from hexagonal indexs to a pixel grid
function hexFile(i)
        %Path to read from
        path = ['ipf', int2str(i), '.txt'];
        %Path to write to
        pathWrite = ['ipfH', int2str(i), '.txt'];
        %Path to read shape of hexagon from
        pathShape = 'HexShape.txt';
        
        X = importfileData(path);
        shape = importfileData(pathShape);
        
        len = length(X);
        Data = zeros(4000000,5);
        row = 1;
        
        %For each hexagonal position
        for j = 1:len
            %Convert it to a representation on a square grid based on the
            %   shape in the hexagon file
            for rowI = 1:14
                for colI = 1:12
                    if (shape{rowI}(colI) == '+')
                        Data(row,:) = [X(j,1,:),  X(j,2,:),  X(j,3,:), X(j,4,:)*11 + rowI, X(j,5,:)*6+colI ];
                        row = row + 1;
                    end
                end
            end
        end
        
        %Write the new file 
        fid = fopen(pathWrite, 'wt'); % Open for writing
        for k = 1 : (row-1)

            fprintf(fid,'%f\t%f\t%f\t%f\t%f\n', Data(k,:) );
        end
        fclose(fid);
        
end