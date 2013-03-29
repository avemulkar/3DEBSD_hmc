function Misval = quatmis(X,degbound)
%Input: X - Quaternion matrix
%      degbound -- degree of seperation to draw boundary (degrees)
%Outputs: Contour of the misorientation information scaled by 3x.

%radbound = degbound*(pi/180);

%path = 'scan1.txt';
%X = quaternion_kuwahara(path);

dim = size(X);
Mis = zeros(round(dim(1)*3),round(dim(2)*3));
Misval = zeros(round(dim(1)),round(dim(2)));
for i = 1:dim(1) %this is for y
    for j = 1:dim(2) %this is for x
        %boundary Cases
        home = (X(i,j,:));

            if i == 1 && j == 1; %top left point
                up = home;
                right = X(i,j+1,:);
                down = X(i+1,j,:);
                left = home;
            elseif i == 1 && j == length(X(1,:,1)) %top right point
                up = home;
                right = home;
                down = X(i+1,j,:);
                left = X(i,j-1,:);
            elseif i == length(X(:,1,1)) &&  j == 1; %bottom left point
                up = X(i-1,j,:);
                right = X(i,j+1,:);
                down = home;
                left = home;
            elseif i == length(X(:,1,1)) && j == length(X(1,:,1)) %bottom right point
                up = X(i-1,j,:);
                right = home;
                down = home;
                left = X(i,j-1,:);
            elseif i == 1 %top side
                up = home;
                right = X(i,j+1,:);
                down  = X(i+1,j,:);
                left  = X(i,j-1,:);
            elseif j == length(X(1,:,1)) %right side
                up = X(i-1,j,:);
                right = home;
                down = X(i+1,j,:);
                left = X(i,j-1,:);
            elseif i == length(X(:,1,1))%down side
                up = X(i-1,j,:);
                right = X(i,j+1,:);
                down = home;
                left = X(i,j-1,:);
            elseif j == 1;%left side
                up = X(i-1,j,:);
                right = X(i,j+1,:);
                down = X(i+1,j,:);
                left = home;
            else %on interior
                up = X(i-1,j,:);
                right = X(i,j+1,:);
                down = X(i+1,j,:);
                left = X(i,j-1,:);
            end
%             angleup = 2*acos(dot(home,up))*(180/pi);
%             angleright = 2*acos(dot(home,right))*(180/pi);
%             angledown = 2*acos(dot(home,down))*(180/pi);
%             angleleft = 2*acos(dot(home,left))*(180/pi);
%              angleup = qmisbrute(home,up);
%              angleright = qmisbrute(home,right);
%              angledown = qmisbrute(home,down);             
%              angleleft = qmisbrute(home,left);             
             angleup = qmisrollett(home,up)*(180/pi);
             angleright = qmisrollett(home,right)*(180/pi);
             angledown = qmisrollett(home,down)*(180/pi);             
             angleleft = qmisrollett(home,left)*(180/pi);   

            if angleup >= degbound
                Mis((i-1)*3+1,(j-1)*3+1) = 1;
                Mis((i-1)*3+1,(j-1)*3+2) = 1;
                Mis((i-1)*3+1,(j-1)*3+3) = 1;               
            end
            if angleright >= degbound
                Mis((i-1)*3+1,(j-1)*3+3) = 1;
                Mis((i-1)*3+2,(j-1)*3+3) = 1;
                Mis((i-1)*3+3,(j-1)*3+3) = 1;
            end
            if angledown >= degbound
                Mis((i-1)*3+3,(j-1)*3+1) = 1;
                Mis((i-1)*3+3,(j-1)*3+2) = 1;
                Mis((i-1)*3+3,(j-1)*3+3) = 1;
            end
            if angleleft >= degbound
                Mis((i-1)*3+1,(j-1)*3+1) = 1;
                Mis((i-1)*3+2,(j-1)*3+1) = 1;
                Mis((i-1)*3+3,(j-1)*3+1) = 1;
            end
            
            Misval(i,j) = max([angleup angleright angledown angleleft]);
    end
end
figure
image(Mis*40)
title('Quaternion Misorientation Contour')
end