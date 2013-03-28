function [C, map]= IMAGEipfEDAX(Data)

%Data is a list of points and euler angles
%IMAGE converts data to a picture
%lines is the # of lines in txt 
lines=length(Data);
theta=acos(dot([1/sqrt(2) 0 1/sqrt(2)], [1/sqrt(3), 1/sqrt(3), 1/sqrt(3)]));
%Create room in memmory for RGB matrices
r(1750,1750)=0;
g(1750,1750)=0;
b(1750,1750)=0;

R=Data(:,1);
Th=Data(:,2);
[Red, Green, Blue, posY, posX]=EDAX(R, Th, Data(:,4), Data(:,5));
'done';
for i=1:lines
   x=posX(i);
   y=posY(i);
   r(y,x)=Red(i);
   g(y,x)=Green(i);
   b(y,x)=Blue(i);

   
end
2
Imatrix=cat(3, r, g, b);
% image(Imatrix);
figure,
image(Imatrix)
C=0;

% [X_no_dither, map]= rgb2ind(Imatrix,4,'nodither');
% C=map;
% figure, imshow(X_no_dither, map)
% C = ind2rgb(X_no_dither, map);