alpha=2.25274;
gamma1=1.71063;
gamma2=gamma1-0.0524;
beta=5.69505;
noiseDegree=1;
b1 = -cos((alpha-gamma1)./2) .* sin(beta./2);
c1 = sin((alpha-gamma1)./2) .* sin(beta./2);
d1 = -sin((alpha+gamma1)./2) .* cos(beta./2);
a1 = cos((alpha+gamma1)./2) .* cos(beta./2);
b2 = -cos((alpha-gamma2)./2) .* sin(beta./2);
c2 = sin((alpha-gamma2)./2) .* sin(beta./2);
d2 = -sin((alpha+gamma2)./2) .* cos(beta./2);
a2 = cos((alpha+gamma2)./2) .* cos(beta./2);
addpath(fullfile('..','FMSC Boundaries','FMSC code'))
[~,val]=qmisbrute([a1 b1 c1 d1],[a2,b2,c2,d2]);
val
qA=[a1 b1 c1 d1];
qB=[a2 b2 c2 d2];
map=zeros(50,75,4);
noisemap=map;
for i=1:50
for j=50:75
    b = -cos((alpha-gamma2)./2) .* sin(beta./2);
    c = sin((alpha-gamma2)./2) .* sin(beta./2);
    d = -sin((alpha+gamma2)./2) .* cos(beta./2);
    a = cos((alpha+gamma2)./2) .* cos(beta./2);
    noisemap(i,j,:)=[a b c d];
end
end
for i=1:50
for j=1:25
    b = -cos((alpha-gamma1)./2) .* sin(beta./2);
    c = sin((alpha-gamma1)./2) .* sin(beta./2);
    d = -sin((alpha+gamma1)./2) .* cos(beta./2);
    a = cos((alpha+gamma1)./2) .* cos(beta./2);
    noisemap(i,j,:)=[a b c d];
end
end
for i=1:50
    for j=26:49
        noisemap(i,j,1) =cos((alpha+((j-26)*gamma2+(49-j)*gamma1)/23)./2) .* cos(beta./2);
        noisemap(i,j,2) =-cos((alpha-((j-26)*gamma2+(49-j)*gamma1)/23)./2) .* sin(beta./2);
        noisemap(i,j,3) = sin((alpha-((j-26)*gamma2+(49-j)*gamma1)/23)./2) .* sin(beta./2);
        noisemap(i,j,4) = -sin((alpha+((j-26)*gamma2+(49-j)*gamma1)/23)./2) .* cos(beta./2);
    end
end
for i=1:50
    for j=1:75
        noisemap(i,j,:)=noisemap(i,j,:)/norm([noisemap(i,j,1) noisemap(i,j,2) noisemap(i,j,3) noisemap(i,j,4)]);
    end
end
for i=1:50
for j=50:75
    b = -cos(pi/360*rand(1)*noiseDegree+(alpha-gamma2)./2) .* sin(beta./2+pi/360*rand(1)*noiseDegree);
    c = sin(pi/360*rand(1)*noiseDegree+(alpha-gamma2)./2) .* sin(pi/360*rand(1)*noiseDegree+beta./2);
    d = -sin(pi/360*rand(1)*noiseDegree+(alpha+gamma2)./2) .* cos(pi/360*rand(1)*noiseDegree+beta./2);
    a = cos(pi/360*rand(1)*noiseDegree+(alpha+gamma2)./2) .* cos(pi/360*rand(1)*noiseDegree+beta./2);
map(i,j,:)=[a b c d];
end
end
for i=1:50
for j=1:25
    b = -cos(pi/360*rand(1)*noiseDegree+(alpha-gamma1)./2) .* sin(beta./2+pi/360*rand(1)*noiseDegree);
    c = sin(pi/360*rand(1)*noiseDegree+(alpha-gamma1)./2) .* sin(pi/360*rand(1)*noiseDegree+beta./2);
    d = -sin(pi/360*rand(1)*noiseDegree+(alpha+gamma1)./2) .* cos(pi/360*rand(1)*noiseDegree+beta./2);
    a = cos(pi/360*rand(1)*noiseDegree+(alpha+gamma1)./2) .* cos(pi/360*rand(1)*noiseDegree+beta./2);
map(i,j,:)=[a b c d];
end
end
for i=1:50
    for j=26:49
        map(i,j,1) =cos(pi/360*rand(1)*noiseDegree+(alpha+((j-26)*gamma2+(49-j)*gamma1)/23)./2) .* cos(beta./2+pi/360*rand(1)*noiseDegree);
        map(i,j,2) =-cos(pi/360*rand(1)*noiseDegree+(alpha-((j-26)*gamma2+(49-j)*gamma1)/23)./2) .* sin(beta./2+pi/360*rand(1)*noiseDegree);
        map(i,j,3) = sin(pi/360*rand(1)*noiseDegree+(alpha-((j-26)*gamma2+(49-j)*gamma1)/23)./2) .* sin(beta./2+pi/360*rand(1)*noiseDegree);
        map(i,j,4) = -sin(pi/360*rand(1)*noiseDegree+(alpha+((j-26)*gamma2+(49-j)*gamma1)/23)./2) .* cos(beta./2+pi/360*rand(1)*noiseDegree);
    end
end
for i=1:50
    for j=1:75
        map(i,j,:)=map(i,j,:)/norm([map(i,j,1) map(i,j,2) map(i,j,3) map(i,j,4)]);
    end
end
l1=(map(:,:,1)-min(min(map(:,:,1))))/(max(max(map(:,:,1)))-min(min(map(:,:,1))));
l2=(map(:,:,2)-min(min(map(:,:,2))))/(max(max(map(:,:,2)))-min(min(map(:,:,2))));
l3=(map(:,:,3)-min(min(map(:,:,3))))/(max(max(map(:,:,3)))-min(min(map(:,:,3))));
image=zeros(50,75,3);
image(:,:,1)=l1;
image(:,:,2)=l2;
image(:,:,3)=l3;
imshow(image);
NNlist=[];
PointsList=zeros(size(map,1)*size(map,2),7);
for i=1:size(map,1)
    for j=1:size(map,2)
        templist=[];
        if i>1
            templist=[templist, (i-2)*size(map,2)+j];
        end
        if i<size(map,1)
            templist=[templist, (i)*size(map,2)+j];
        end
        if j>1
            templist=[templist, (i-1)*size(map,2)+j-1];
        end
        if j<size(map,2)
            templist=[templist, (i-1)*size(map,2)+j+1];
        end
        NNlist=[NNlist, {templist}];
        PointsList((i-1)*size(map,2)+j,:)=[map(i,j,1),map(i,j,2),map(i,j,3),map(i,j,4),i,j,1];
    end
end
size(map)
size(noisemap)
% Var=VarianceCheck(map, noisemap)

%% Saving as EBSD data
data = zeros(50*75,6);




for x = 1:50
    for y = 1:75
        q = map(x,y,:);
        p1 = atan2(2*(q(1)*q(2) + q(3)*q(4)),1-2*(q(1)^2+q(2)^2));
        P = asin(2*(q(1)*q(3)-q(4)*q(2)));
        p2 = atan2(2*(q(1)*q(4) + q(2)*q(3)),1-2*(q(3)^2+q(4)^2));
        E = real([p1 P p2]);
        data(75*(x-1)+y,:) = [E(1) E(2) E(3) y/10 (50-x+1)/10 1];
    end
end



dlmwrite('scanClean1.txt',data,'delimiter','\t','newline','pc');

%% Overlay Boundary Points
load('C:\Users\Andrew\Desktop\Research\3DEBSDrepos\Data\Cleaned Data\toy\toyImage.mat')
imageB = image;

for i = 1:length(boundarylist)
    imageB(round(boundarylist(i,5)/.1),round(boundarylist(i,4)/.1),:) = [0 0 0];
end
imshow(imageB)
    








