%draws a square of set size color and transparency
function fh = block(ss,loc,color)
xc=loc(1);
yc=loc(2);
z=loc(3)*ones(1,4);
s=(ss)/2;
x=[xc-s xc+s xc+s xc-s];
y=[yc-s yc-s yc+s yc+s];
fh=1;
fh=fill3(x,y,z,color);
alpha(fh,0.7)   %transparency of squares (close to 1 is less transparent)
return