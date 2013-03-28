%creates a polefigure from a list of points

%Bugs when plotting unit vectors on edge of circle, sometimes will flip
% see 2pi/3 about ND

function [ipfV] = ipfplotter(phi1, PHI, phi2)


SA=ipfFunction(phi1, PHI, phi2);
CD=SA(:,3);
ED=equivalentDirections(CD);
for i=1:numel(ED)/3
   row=ED(i,:);
   if row(3)>=0 && row(1)>=0 && row(2)>=0 && row(2)<=row(1) && atan(row(3)/row(1))>=pi/4
        IPF=row;
   end
end

ipfV=IPF;
