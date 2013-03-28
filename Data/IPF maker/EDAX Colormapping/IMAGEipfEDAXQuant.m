%Create images using the EDAX ipf colormapping
%   A colorquantization is applied to the image using
%   NumCol

function [C]= IMAGEipfEDAXQuant(Data, NumCol)

lines=length(Data);

%Create room in memmory for RGB matrices
r(150,200)=0;
g(150,200)=0;
b(150,200)=0;

R=Data(:,1);
Th=Data(:,2);
[Red, Green, Blue, posY, posX]=EDAX(R, Th, Data(:,4), Data(:,5));


for i=1:lines
   x=posX(i);
   y=posY(i);
   r(y,x)=Red(i);
   g(y,x)=Green(i);
   b(y,x)=Blue(i);

   
end

% eps= 0.001;
% for i= 1:length(r(:,1))
%     for j= 1:length(r(:,:,1))
%         if r(i,j)< 1.0+eps && r(i,j)> 1.0- eps;
%             if b(i,j)< 0.8724+eps && b(i,j)> 0.8724- eps;
%                 if g(i,j)< 0.4593+eps && g(i,j)> 0.4593- eps;
%                     r(i,j)=0;
%                     b(i,j)= 0;
%                     g(i,j)=0;
%                 end
%             end
%         end
%     end
% end

Imatrix=cat(3, r, g, b);

% x= length(Imatrix(:,1))
% y= length(Imatrix)
% 
% for i=1:(x)
%     for j= 1: (y)
%         for m= 1:3
%             if Imatrix(i, j, m)< 0.0
%                Imatrix(i, j, m)= 0;
%             end
%         end
%     end
% end

figure, image(Imatrix)
hold on
y1= [0,0; 0,50];
plot(y1(:,2)+15, y1(:,1)+140, 'LineWidth',5, 'color',[1,1,1])
[X_no_dither, map]= rgb2ind(Imatrix,NumCol,'nodither');
C = ind2rgb(X_no_dither, map);