function transData = BLtranform(Data,corners,desiredCorners)
% does a bilinear transformation of the data based on the corners
% Data: Matrix (N x 6) [euler1 euler2 euler3 x y conf]
% corners: Matrix (4 x 2)
% desiredCorners: Matrix (4 x 2)

%% define the corners
cx = corners(:,1);
cy = corners(:,2);

x1 = cx(1); y1 = cy(1);
x2 = cx(2); y2 = cy(2);
x3 = cx(3); y3 = cy(3);
x4 = cx(4); y4 = cy(4);

%% define the transformation matrices
cornermatrix = [1 x1 y1 (x1*y1); 1 x2 y2 (x2*y2); 1 x3 y3 (x3*y3); 1 x4, y4 (x4*y4)]; 
matrixa = (cornermatrix)\desiredCorners(:,1); %matrix for new x values
matrixb = (cornermatrix)\desiredCorners(:,2); %matrix for new y values

%% transform each point 
numPts = size(Data,1);
transData = Data;
for i=1:numPts

    oldU=Data(i,4);
    oldV=Data(i,5);

    %transformation
    transX= [ 1, oldU, oldV, (oldU*oldV) ]* matrixa; 
    transY= [ 1, oldU, oldV, (oldU*oldV) ]* matrixb;

    transData(i,4:5)=[transX transY]; %new point structure 
    
end