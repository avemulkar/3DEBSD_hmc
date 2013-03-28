%Convert the real data positions into indexes on a hexagon grid

%A row is defined by the vertical distance between adjacent rows
%An index is defined as a square side
%Modified by Benyue Emma Liu from Kevin King's mfile HexPos.m
function SquarePos(i)

        path = ['scanCrop', int2str(i), '.txt'];
        pathWrite = ['scanSPos', int2str(i), '.txt'];
        X = importfileData(path);
        
        len = length(X);
        Data = [];
        row = 1;
        index = 1;
        ypos = 0;
        
        %For each data entry, convert its real location to a square
        %   indexed location
        for j = 1:len
            %Checked to see if we've reached the next row, if we have then
            %increase the row 
            if (ypos ~= X(j,5,:))
                ypos = X(j,5,:);
                row = row + 1;
                index=1;
            end
            Data(j,:) = [X(j,1,:),  X(j,2,:),  X(j,3,:),  row, index];
            %We increment index by one
            index = index + 1;
        end
        
        fid = fopen(pathWrite, 'wt'); % Open for writing
        for k = 1:len
            fprintf(fid,'%f\t%f\t%f\t%f\t%f\n', Data(k,:) );
        end
        fclose(fid);
end