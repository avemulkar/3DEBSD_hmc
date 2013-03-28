%MisorientBoundary will give the misorientation boundary according to the
%lower and Upper values you specify. 
%Benyue Liu
%7-10-2008
function [Bound, value] = MisorientBoundary(Data,Lower,Upper)
%Input:
%Data :  is the matrix with the data(scanned pictures).It is n*5 matrix.
%       with the first three columns the three different Euler angles, the
%       last two columns are the x, y position values of the hexagonal
%       pixel centers. 
%Lower: the lower threshold of the angle range.
%Upper: the upper threshold of the anlge range. 

%Output:
%a picture with the boundary lines. 

%Because of the shapes of the hexagonal pixels, we seperate the data into
%two different matrices, odd and even matrices. 
[Odd,Even]=TwoMatrix(Data);
1
%OddAngle and EvenAngle are the two cell arrays. Each component has six misorientation
%angles at one position.(one pixel has six pixels adjacent to it) 
[OddAngle,EvenAngle]=AngleDiff(Odd,Even);
2
%Bound is the set of x, y positions when the pixel and one of its adjacent
%pixels misorient within the lower and upper limit. 
[Bound, value]=boundary1(Odd,Even,OddAngle,EvenAngle,Lower,Upper);

%The negative sign is to flip the image so that it is easier to compare it
%with the generated IPF pictures and quatized pictures. 
%plot(Bound(:,1),-Bound(:,2),'b*');

%Save the misorientation information incase we want to rerun the program
fid = fopen('vals.txt', 'wt'); % Open for writing
for k = 1:length(value)
    row = value(k,:);
    fprintf(fid,'%d\t%d\t%d\n', row);
end
fclose(fid);