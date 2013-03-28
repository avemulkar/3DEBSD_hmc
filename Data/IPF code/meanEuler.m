function meanEul = meanEuler(eulers,CS,SS)
% computes the mean of a list of euler angles
% requires the mtex toolbox
% input - Nx3 list of Bunge eulers in rad
% ouptut - 3x1 Bunge euler in rad

% convert to rotation object
rotEuler = rotation('Euler',eulers);

% project to fundamental region
if nargin > 1
    rot_ref = rotation('Euler',0,0,0);
    rotEuler = project2FundamentalRegion(rotEuler,CS,SS,rot_ref); 
end

%average
meanEul = mean(rotEuler);
[eul1 eul2 eul3] = Euler(meanEul);
meanEul = [eul1 eul2 eul3];