%Convert the real data positions into indexes on a hexagon grid

%A row is defined by the vertical distance between adjacent rows
%An index is defined as half a hexagon
%This allows us to simplify the handling of even/odd rows
function hexPos(i)

        path = ['scanCrop', int2str(i), '.txt'];
        pathWrite = ['scanHPos', int2str(i), '.txt'];
        X = importfileData(path);
        
        len = length(X);
        Data = [];
        row = 1;
        index = 1;
        ypos = 0;
        
        %For each data entry, convert its real location to a hexagonally
        %   indexed location
        for j = 1:len
            %Checked to see if we've reached the next row, if we have then
            %increase the row and update the index to reflect even/odd row
            if (ypos ~= X(j,5,:))
                ypos = X(j,5,:);
                row = row + 1;
                index = 1+~mod(row,2);
            end
            Data(j,:) = [X(j,1,:),  X(j,2,:),  X(j,3,:),  row, index];
            %We increment index by two since each index is only half a
            %hexagon width
            index = index + 2;
        end
        
        fid = fopen(pathWrite, 'wt'); % Open for writing
        for k = 1:len
            fprintf(fid,'%f\t%f\t%f\t%f\t%f\n', Data(k,:) );
        end
        fclose(fid);
end