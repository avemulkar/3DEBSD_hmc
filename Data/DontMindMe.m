clc
addpath('IPF code')
cs = symmetry('cubic');
ss = symmetry('cubic');

o1 = orientation('Euler',1.03000000000000,0.424200000000000,0.162200000000000,cs,ss);
o2 = orientation('Euler',1.06700000000000,0.384800000000000,0.0905400000000000,cs,ss)

o3 = orientation('Euler',3.27200000000000,0.422600000000000,0.00424100000000000,cs,ss);

e1 = [1.03000000000000,0.424200000000000,0.162200000000000];
e2 = [1.06700000000000,0.384800000000000,0.0905400000000000];
eulers = [e1;e2];

oo1 = orientation('Euler',115.432*degree, 71.0595*degree, 347.054*degree,cs,ss);


% checkFundamentalRegion(o1)
% checkFundamentalRegion(o2)

o1P = project2FundamentalRegion(o1,cs);
o2P = project2FundamentalRegion(o2,cs);
o3P = project2FundamentalRegion(o3,cs)

% checkFundamentalRegion(o1P)
% checkFundamentalRegion(o2P)

angle(o1,o2)
angle(o1P,o2P)
angle(o1,oo1)

[Eulers,~] = Euler([((o1P)); ...
    ((o2P))])
ipfc = myeuler2rgb(Eulers);

%         figure(2)
% scatter([0 1],[0 0],10000,ipfc,'filled','square')

% p1 = 1.03000000000000;
% p = 0.424200000000000;
% p2 = 0.162200000000000;
% 
% % p1 = 1.06700000000000;
% % p = 0.384800000000000;
% % p2 = 0.0905400000000000;


% hkl = [0.0665    0.4062    0.9114];
% uvw = [0.3819   -0.8542    0.3529];

% hkl = [0.0339    0.3738    0.9269];
% uvw = [0.4074   -0.8520    0.3287];

m1 = Miller(0.0665 ,   0.4062   , 0.9114, cs);
 m2 = Miller(0.0339  ,  0.3738 ,   0.9269, cs);
 m3 = Miller(0.3246   , 0.2119  ,  0.9218, cs);
 

figure(1)
hold on
%   (plot(symmetrise(m1,'antipodal')))
%   (plot(symmetrise(m2,'antipodal')))
%   (plot(symmetrise(m3,'antipodal')))
  plot([m1,m2,m3],'label',{'m1','m2','m3'},'grid','grid_res',45*degree)
%   plot(m2)
%   plot(m3)
    hold off
%     
%     figure(2)
% hold on
%   (plot(symmetrise(m1)))
%   (plot(symmetrise(m2)))
%   (plot(symmetrise(m3)))
%   plot([m1,m2,m3],'label',{'m1','m2','m3'},'grid','grid_res',45*degree)
%   hold off

