%misorientation is a program which takes two sets of Euler angles,
%calculating the angle between the two orientations.
%Benyue Liu
%7-10-2008
function [angle]= misorientation(unitA1,Euler2)
%Input:
%Euler1 and Euler2 are two 1*3 matrices with three euler angles
%Output: misorientation angle between the two rotations in degrees.


%using inverse pole figure to calculate the rotated vectors.
%[unitA1]=ipfplotter(Euler1(1),Euler1(2),Euler1(3));
[unitA2]=ipfplotter(Euler2(1),Euler2(2),Euler2(3));

angle=180*acos(dot(unitA1,unitA2))/pi;

% the commented area below was the old approach using rotation matrix.
% didn't work very well.
% 
% %rotation matrix A1
% D1= [ cos(Euler1(1)) sin(Euler1(1)) 0;
%     -sin(Euler1(1)) cos(Euler1(1)) 0;
%     0     0    1];
% 
% C1=[1 0 0;
%     0 cos(Euler1(2)) sin(Euler1(2));
%     0 -sin(Euler1(2)) cos(Euler1(2))];
% 
% B1=[cos(Euler1(3)) cos(Euler1(3)) 0;
%     -sin(Euler1(3)) cos(Euler1(3)) 0;
%     0 0 1];
% 
% A1 = B1*C1*D1;
% 
% %rotation matrix A2
% D2= [ cos(Euler2(1)) sin(Euler2(1)) 0;
%     -sin(Euler2(1)) cos(Euler2(1)) 0;
%     0     0    1];
% 
% C2=[1 0 0;
%     0 cos(Euler2(2)) sin(Euler2(2));
%     0 -sin(Euler2(2)) cos(Euler2(2))];
% 
% B2=[cos(Euler2(3)) cos(Euler2(3)) 0;
%     -sin(Euler2(3)) cos(Euler2(3)) 0;
%     0 0 1];
% 
% A2 = B2*C2*D2;    
%     
% %the angle between the two rotations
% 
% unit=[0 0 1]';
% 
% unitA1=normc(A1*unit);
% 
% unitA2=normc(A2*unit);
