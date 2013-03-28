%creates a polefigure from a list of points

%Bugs when plotting unit vectors on edge of circle, sometimes will flip
% see 2pi/3 about ND

function [ipfC] = ipfplotter(Data)
%Data is a list of points and euler angles

%A List of control variables
% We start by building matrices of pts for
% RD, TD and ND directions. i is a counter of overall number of accepted
% pts

lines=length(Data(:,1));

%%%%%%%%%%%%%%%%%%%%
%Notes for optimization
%Allocate memory for RD TD ND poles and then eliminate extra space
%%%%%%%%%%%%%%%%%%%%

N=1;
IPF=zeros(lines*1,3);
IPFColor=zeros(lines*1,5);
%debug var
%IPF=zeros(1,3)

for k=1:lines
   %For each point, we take the euler angles 
   phi1=    Data(k,1);
   PHI=     Data(k,2);
   phi2=    Data(k,3);
   x=       Data(k,4);
   y=       Data(k,5);
   
   
   b=abs(sin(Data(k,3)));
   if ((Data(k,1)==3.14159)) && (b==0) && (Data(k,2)==1.5708)       
   else
        
       %Convert euler angle into a 3x6 matrix of vectors 
       % [RD TD ND] which have been projected onto give
       % pole
       
       SA=ipfFunction(phi1, PHI, phi2); %sample axis
       CD=SA(:,3); %ND or the crystal direction
       %Now generate all equivalent CD
       ED=equivalentDirections(CD);
       %ED=1/sqrt(2)*[1 0 1]

%eliminate symmetric pointss
       for i=1:numel(ED)/3
           row=ED(i,:);
           if row(3)>=0 && row(1)>=0 && row(2)>=0 && row(2)<=row(1) && atan(row(3)/row(1))>=pi/4
                IPF(N,:)=row;
                IPFColor(N,:)=[row, x, y];
                N=N+1;
           end
       end
       IPF;

   end
end

% figure
% plot3(IPF(:,1), IPF(:,2), IPF(:,3), 'b*')
% hold on
% greatCircle
% hold off
% 
% 
% [THETA,PHI,R] = cart2sph(IPF(:,1), IPF(:,2), IPF(:,3));

temp=zeros(N-1,3);
temp2=zeros(N-1,5);
for i=1:N-1
    temp(i,:)=IPF(i,:);
    temp2(i,:)=IPFColor(i,:);    
end
IPF=temp;
IPFColor=temp2;

for i=1:numel(IPF)/3 %for each ED
   v=IPF(i,:); %take a vector v
   rowC=IPFColor(i,:);
   Z=v(3)+1; %take the Z element in vector v, and increment by 1 this is the height of the point from pole
   scale=1/Z; %make the height 1 or at the plane of pole figure
   IPF(i,:)=scale*v; %scale all element in vector V and replace in newAxis
   %See paper for explanation on following steps
   D=v(1);
   E=v(3);
   C=v(1)*scale;
   h=(D*C+D-C-E*C)/(E-D+1);
   scaleC=(h+1+v(1)*scale)/Z;
   IPFColor(i,:)=[scaleC*v rowC(4) rowC(5)];
   
end

Z=50*ones(numel(IPF)/3, 1);
IPF=[IPF(:,1), IPF(:,2), Z]; %#ok<NASGU>

%R=zeros(numel(Z),1);
%Theta=zeros(numel(Z),1);
for i=1:numel(Z)
    row=IPFColor(i,:);
    R=sqrt( (row(1)/cos(pi/4))^2 + row(2)^2);
    Theta=asin(row(2)/R);
    IPFColor(i,:)=[R Theta 0 row(4) row(5)];
end
IPF;
ipfC=IPFColor;
