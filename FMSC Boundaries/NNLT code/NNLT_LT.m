function transfMLTstruct = NNLT_LT(transfMXYstruct,transfMgridStruct,...
                             gridIndex,radius,radiusAdj)
% save transfM(x,y) to transfMstruct for above, current below slice
% then write data to file

%preliminary variables
[gridSizeY gridSizeX unused] = size(transfMgridStruct);
radiusI = ceil(10*radius);

%unpackage
transfMXY = transfMXYstruct{2};
transfMXYabove = transfMXYstruct{1};
transfMXYbelow = transfMXYstruct{3};
lengthTransfM = size(transfMXY,1);

transfMLTstruct = cell(lengthTransfM,3); %allocate memory

for point = 1:lengthTransfM
    %get real x,y coordinates
    x = transfMXY(point,1);
    y = transfMXY(point,2);
    %get index of nearest discrete grid point
    xGridIndex = gridIndex(point,1);
    yGridIndex = gridIndex(point,2);
    %get index of all grid points within a [2*radius X 2*radius box]
    %around that discrete grid point point (NN indices)
    xBox = [xGridIndex-radiusI:xGridIndex+radiusI];
    yBox = [yGridIndex-radiusI:yGridIndex+radiusI];
    
    %for each of these grid points within the box, and within xRange, yRange
    for xIndexNN = xBox((xBox>0)&(xBox<=gridSizeX)) %x index of nearest neigbor
        for yIndexNN = yBox((yBox>0)&(yBox<=gridSizeY)) %yindex of nearest neighbor
            
            %% find the nearest neigbors of each point in the slice
            %for each of the data points associated with that grid point
            %that is not itself
            NNguesses = transfMgridStruct{yIndexNN,xIndexNN,2};
            for LIguess = NNguesses(NNguesses~=point) %List Index of guess
                xGuess = transfMXY(LIguess,1); %x coord of guess
                yGuess = transfMXY(LIguess,2); %y coord of guess
                %if the data point is within the radius of the real point
                if (xGuess-x)^2+(yGuess-y)^2<=radius^2
                    %then add the index of that point to the cell
                    transfMLTstruct{point,2} = ...
                        [transfMLTstruct{point,2} LIguess];
                end
            end
            
            %% find the nearest neighbors of each point in the slice below
            NNguesses = transfMgridStruct{yIndexNN,xIndexNN,1}; 
            for LIguess = NNguesses %List Index of guess
                xGuess = transfMXYabove(LIguess,1); %x coord of guess
                yGuess = transfMXYabove(LIguess,2); %y coord of guess
                %if the data point is within the radius of the real point
                if (xGuess-x)^2+(yGuess-y)^2+radiusAdj^2<=radius^2
                    %then add the index of that point to the cell
                    transfMLTstruct{point,1} = ...
                        [transfMLTstruct{point,1} LIguess];
                end
            end

            %% find the nearest neighbors of each point in the slice above
            NNguesses = transfMgridStruct{yIndexNN,xIndexNN,3}; 
            for LIguess = NNguesses %List Index of guess
                xGuess = transfMXYbelow(LIguess,1); %x coord of guess
                yGuess = transfMXYbelow(LIguess,2); %y coord of guess
                %if the data point is within the radius of the real point
                if (xGuess-x)^2+(yGuess-y)^2+radiusAdj^2<=radius^2
                    %then add the index of that point to the cell
                    transfMLTstruct{point,3} = ...
                        [transfMLTstruct{point,3} LIguess];
                end
            end

        end
    end

end %end for every point loop