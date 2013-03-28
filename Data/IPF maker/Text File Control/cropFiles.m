%cropFiles

%Method
%   Crops a text file such that extraneous information is removed
%   This is specific to the Quadir text files
function cropFiles(i)
        %Path to read from
        path = ['scan', int2str(i), '.txt'];
        %Path to Write to
        pathWrite = ['scanCrop', int2str(i), '.txt'];
        
        %Import that data from path. X can be seen as a 1xN matrix of
        %   strings
        X = importfile(path);

        len = length(X);
        Data = [];
        row = 1;
        %For each string in X, check if it is commented (has a #), if it is
        %not commented, grab the euler angles (positions 3:9 13:19 23:29)
        %and the position of the data point (36:42 49:55)
        for j = 1:len
            if (X{j}(1) ~= '#')
       
                Data(row,:)= [str2num(X{j}(2:10)), str2num(X{j}(12:20)), str2num(X{j}(22:30)), str2num(X{j}(35:43)), str2num(X{j}(48:56)), str2num(X{j}(64:71))];
                row = row + 1;
                
               
            end
        end
        
        for j=1:length(Data)
            if Data(j,6) < 0.3
                Data(j,1) = 0;
                Data(j,2)= 0;
                Data(j,3)= 0;
            end
        end
        Data2= []; 
        Data2= [Data(:,1), Data(:,2), Data(:,3), Data(:,4), Data(:,5)];

        %Write the cropped strings back to a text file for later use
        fid = fopen(pathWrite, 'wt'); % Open for writing
        for k = 1:row-1
            %Data(k,:)
            fprintf(fid,'%f\t%f\t%f\t%f\t%f\n', Data2(k,:) );
        end
        fclose(fid);

end
      
                