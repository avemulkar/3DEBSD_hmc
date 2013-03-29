function Imatrix = imap(Red,Green,Blue,transXY,xRange,yRange)

transXY = 10*transXY;
xRange = 10*xRange; 
yRange = 10*yRange;

r = ones(max(yRange),max(xRange)); g=r; b=r;

numPts = length(transXY);
for i=1:numPts
   x=round(transXY(i,1));
   y=round(transXY(i,2));
   if ( (x>0)&&(x<=max(xRange))&&...
        (y>0)&&(y<=max(yRange)) )
       r(y,x)=Red(i);
       g(y,x)=Green(i);
       b(y,x)=Blue(i);
   end
end

Imatrix=cat(3, r, g, b);