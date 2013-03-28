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
end
