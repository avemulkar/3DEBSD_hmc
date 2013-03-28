function colorPlotnew(Data)

%Data is a list of points and euler angles
%IMAGE converts data to a 3d plot of the color pts in Data
%lines is the # of lines in txt 
hold on;
lines=length(Data)
r(1900,1900)=0;
g(1900,1900)=0;
b(1900,1900)=0;
for i=1:lines
   x=round(Data(i,4)/.0041666666667+1);
   y=round(Data(i,5)/.0041666667+1 );

   
   x=round(Data(i,4)/.0041666666667+1);
   y=round(Data(i,5)/.0041666667+1 );
 
   a=Data(i,1);
   d=Data(i,2);
   c=Data(i,3);
   
   w=pi/2-d;
   p=a;
   
   d=cos(w);
   
   [x1,y1,z1] = sph2cart(p,w,d);
   
   r(y,x)=(x1+1)/2;
   g(y,x)=(y1+1)/2;
   b(y,x)=(z1+.5);
   
   plot3( r(y,x), g(y,x), b(y,x), 'r*')
   
   
end

grid on;
hold off;

xlabel('Red')
ylabel('Green')
zlabel('Blue')