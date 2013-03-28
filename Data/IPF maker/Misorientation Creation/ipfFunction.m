%WHat this is
%Creating ipf from euler angles
%What we have:
%   3 variables for RD TD ND directions
%   3 inputs for 3 euler angles
%   3 outputs for each direction each of which are 1x3 matrices containing
%       [x; y; z] cordinates



function [Ans]= ipfFunction(phi1, PHI, phi2)
    RD=[1; 0; 0]; % not sure on these values, fix as necessary
    TD=[0; 1; 0];
    ND=[0; 0; 1];
    Axis=[RD TD ND];
    
    %rotations taken from http://mathworld.wolfram.com/EulerAngles.html
    %step 1 rotate around ND using phi1
    firstR=[ cos(phi1)       sin(phi1)   0;
        -1*sin(phi1)    cos(phi1)       0;
        0               0               1];
    
    %step 2 rotate around new RD using PHI
    secondR=[1        0           0;
             0   cos(PHI)    sin(PHI);
             0  -1*sin(PHI) cos(PHI)];
    
    %step 3 rotate around new ND using phi2
    thirdR=[cos(phi2)        sin(phi2)   0;
       -1*sin(phi2)     cos(phi2)        0;
       0                0                1];
   
   %Step 4: rotation matrix rotation=firstR*secondR*thirdR;
   %rotation=firstR*secondR*thirdR;
   rotation=thirdR*secondR*firstR;
   RD=rotation*RD;
   TD=rotation*TD;
   ND=rotation*ND;
   
   Ans=[RD TD ND];

%    for i=1:6 %due for each vector axis in newAxis
%        v=newAxis(:,i); %take a vector v
%        Z=v(3)+1; %take the Z element in vector v, and increment by 1 this is the height of the point from pole
%        scale=1/Z; %make the height 1 or at the plane of pole figure
%        newAxis(:,i)=scale*v; %scale all element in vector V and replace in newAxis
%    end
