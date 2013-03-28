% This is to test Kevin King's own IPF coloring against MTEX and two years
% of work since Cullen (who aparently had it right)
clc; clear; close all;

cs = symmetry('cubic');
ss  = symmetry('cubic');

% red = orientation('Miller', [1 0 0], [1 0 0], cs, ss)
% green = orientation('Miller', [1 0 1], [1 0 1], cs, ss)
% blue = orientation('Miller', [1 1 1], [1 0 1], cs, ss)

% % (001) -- Red
% Rphi1 = asin(1*sqrt(1));
% RPHI = acos(1/sqrt(1));
% Rphi2= acos(0/1);
% 
% % (101) -- Green
% Gphi1 = asin(1/sqrt(2)*sqrt(2));
% GPHI = acos(1/sqrt(2));
% Gphi2= acos(1/1);
% 
% % (111) -- Blue
% Bphi1 = asin(1/sqrt(3)*sqrt(3/2));
% BPHI = acos(1/sqrt(3));
% Bphi2= acos(0/1);
% 
% red = orientation('Euler',Rphi1,RPHI,Rphi2 ,cs, ss)
% green = orientation('Euler',Gphi1,GPHI,Gphi2, cs, ss)
% blue = orientation('Euler',Bphi1,BPHI,Bphi2 ,cs, ss)

red = orientation('Euler',0 ,0 ,0 ,cs, ss)
green = orientation('Euler',pi/4, 0, 0, cs, ss)
blue = orientation('Euler', pi/4, pi/4, 0, cs, ss)
%149*pi/180, 54*pi/180, 45*pi/180

if 1
    r = orientation2color(red,'ipdf','antipodal')
    g = orientation2color(green,'ipdf','antipodal')
    b = orientation2color(blue,'ipdf','antipodal')
else
    r = orientation2color(red,'hkl','antipodal')
    g = orientation2color(green,'hkl','antipodal')
    b = orientation2color(blue,'hkl','antipodal')
end

A = cat(3,[r(1) g(1) b(1)], [r(2) g(2) b(2)], [r(3) g(3) b(3)]);

imshow([A])


%% Make test set
length = 30;
width = 5;
Ktest = zeros(length*width*3,5);
X = zeros(length*width,1);
Y = zeros(length*width,1);
for x = 1:length
    for y = 1:6*width
        if y <= width
            Ktest(x+length*(y-1),:) = [.00001,.00001,0.00001,x,y];
        elseif y <= 2*width
            Ktest(x+length*(y-1),:) = [pi/8,0.00001,0.00001,x,y];%[Euler(mean([orientation('Euler',[0,0,0],cs,ss),orientation('Euler',[pi/4,0,0],cs,ss)],1)),x,y];
        elseif y <= 3*width
            Ktest(x+length*(y-1),:) = [pi/4,0.00001,0.00001,x,y];
        elseif y <= 4*width
            Ktest(x+length*(y-1),:) = [[pi/4,pi/8,0.00001],x,y];
        elseif y <= 5*width
            Ktest(x+length*(y-1),:) = [pi/4,pi/4,0.00001,x,y];
        elseif y <= 6*width
            Ktest(x+length*(y-1),:) = [pi/8,pi/4,0.00001,x,y];        
        end
        X(x+length*(y-1)) = x;
        Y(x+length*(y-1)) = y;
    end
end



%% Test EDAX coloring
[ipfC] = ipfplotter(Ktest);
[Red, Green, Blue, posX, posY] = EDAX(ipfC(:,1), ipfC(:,2), ipfC(:,4), ipfC(:,5));    
IPFcolors=cat(2,Red,Green,Blue);
scatter(posY, posX,500,IPFcolors,'square','filled');

%% Test MTEX coloring
o = orientation('Euler',Ktest(:,1:3),cs,ss);
[fundEulers,~] = Euler(project2FundamentalRegion(o));
% IPFcolors = myeuler2rgb(fundEulers);
IPFcolors = myeuler2rgb(Ktest(:,1:3));
scatter(Y,X,500,IPFcolors,'square','filled');

%% more KK
colorPlotnew(Ktest)

%% Test Fundamental Region, Projections
% % o(1) = orientation('Euler',[0,0,0],cs,ss);
% % o(2) = orientation('Euler',[pi/8,0,0],cs,ss);
% % o(3) = orientation('Euler',[pi/4,0,0],cs,ss);
% % o(4) = orientation('Euler',[pi/4,pi/8,0],cs,ss);
% % o(5) = orientation('Euler',[pi/4,pi/4,0],cs,ss);
% % o(6) = orientation('Euler',[pi/8,pi/4,0],cs,ss);
% 
% % o(2) = mean([orientation('Euler',[0,0,0],cs,ss),orientation('Euler',[pi/4,0,0],cs,ss)],1);
% % o(4) = mean([orientation('Euler',[pi/4,pi/4,0],cs,ss),orientation('Euler',[pi/4,0,0],cs,ss)],1);
% % o(6) = mean([orientation('Euler',[0,0,0],cs,ss),orientation('Euler',[pi/4,pi/4,0],cs,ss)],1);

% o =(project2FundamentalRegion(o))
% plot(o(1))
% hold on
% plot(o(2))
% plot(o(3))
% plot(o(4))
% plot(o(5))
% plot(o(6))
% hold off

e(1,:) = [0,0,0];
e(2,:) = [pi/8,0,0];
e(3,:) = [pi/4,0,0];
e(4,:) = [pi/4,pi/8,0];
e(5,:) = [pi/4,pi/4,0];
e(6,:) = [pi/8,pi/4,0];

[hkl uvw] = myeuler2hkl(e(:,1), e(:,2), e(:,3));

% m = Miller(hkl(:,1), hkl(:,2), hkl(:,3),cs,ss);

% m = Miller([0;0;1],[0;-1;-1],[1;1;1],cs,ss);

m = Miller(1,0,0,cs,ss);
hold on
plot(m,'color',IPFcolors)



        