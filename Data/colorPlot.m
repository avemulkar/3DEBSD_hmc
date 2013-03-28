function colorPlot(Data)

%Inputs:   Data is a matrix containing [ euler1,euler2,euler 3, x,y]
%colorPlot plots the unique samples taken in the original data and 
%          plots them for a visual representation of the color space

%lines is the # of rows in matrix
figure, subplot(2,2, 1)
plot3(0 ,0, 0, 'g*')
hold on;
lines=length(Data)
cords.x(lines)= 0;
cords.y(lines)= 0;
cords.z(lines)= 0;
for i=1:lines
   x=round(Data(i,4)/.0041666666667+1);
   y=round(Data(i,5)/.0041666667+1 );

   
   r(y,x)=sin(Data(i,1));
   g(y,x)=cos(Data(i,2));
   b(y,x)=cos(Data(i,3));
   cords.x(i)= r(y,x);
   cords.y(i)= g(y,x);
   cords.z(i)= b(y,x);
   plot3( r(y,x), g(y,x), b(y,x), 'r*')
   %if (mod(i, 100)==0)
   %   i
   %end
   
end

plot3( cords.x, cords.y, cords.z, 'r*') 
grid on;
hold off;
xlabel('Red')
ylabel('Green')
zlabel('Blue')


subplot(2,2,2)
hold on
plot(cords.x, cords.y, 'r*')
xlabel('Red')
ylabel('Green')
hold off
hist(cords.x,500)

subplot(2,2,3)
hold on
plot(cords.x, cords.z, 'g*')
xlabel('Red')
ylabel('Blue')
hold off
hist(cords.y,500)

subplot(2,2,4)
hold on
plot(cords.z, cords.y, 'b*')
xlabel('Blue')
ylabel('Green')
hold off
hist(cords.z,500)



