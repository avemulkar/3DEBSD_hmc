%TwoMatrix gives us the two matrices generated from the data p. 
%Benyue Liu
%7-10-2008
function [Odd,Even]=TwoMatrix(p)
%Input:
%p: points that are in scanned formats. (euler angles in the first three
%   columns,x,y positions in the fourth and fifth column. 

%Output:
%Odd : the Matrix with odd rows of the data according to the y positions.
%Even: the Matrix with even rows of the data according to the y positions.

%initialize the yvalue: the first one in the point data. 
yvalue=[p(1,4)];

%find the different y values.
for i=1:length(p)
    if not(ismember(p(i,4),yvalue))
        yvalue=[yvalue,p(i,4)]; %a vector of y values. 
    end
end

%initialize the Odd , Even and Array cells.
Odd={};
Even={};
Array={};


counter=1;
%ycur indicates the current y values. 
ycur=yvalue(counter);
    
for j=1:length(p)
    if p(j,4)==ycur

       Array={Array{1,:} p(j,1:5)}; %array of data for the same y value.
       
    else 
        if mod(counter,2)==1 % when the y values change (becuase in p, the y values are in order. 
            %if in p , y values are not in order, this program will have
            %bugs, you have to modify this program. 
            Odd=[Odd(:,:);Array];%when the counter is an Odd number, the data are in Odd matrix. 
        else
            Even=[Even(:,:);Array];%when the counter is an Even number, the data are in Even Matrix. 
        end
        counter=counter+1;%counter increment when y values changes. 
        ycur=yvalue(counter);
        Array={p(j,1:5)};
    end
end
            
            
        

