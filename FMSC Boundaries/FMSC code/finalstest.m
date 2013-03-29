for blah=s:-1:1
%blah=s-2

testmask=zeros(rows,cols,4);
index=zeros(rows*cols,2);
image=matrix;
xoff=200;
yoff=125;
for i=1:rows
     for j=1:cols
            index((i-1)*cols+j,:)=[i;j];
     end
end
for i=1:length(storage(blah).Ws)
            U=zeros(lengths(blah),1);
            U(i)=1;
            %this calculates which data points are in the node
            for j=blah:-1:2
                %U(U>.8)=ones(length(find(U>.8)),1);
                U(U<.05)=zeros(length(find(U<.05)),1);
                U=storage(j).Ps*U;
            end
            maskeles=find(U>.1);
             %if length(maskeles)>20 %&& length(newmask(index(maskeles,1), index(maskeles,2),2)>.5)<.5*length(maskeles)
                %add each data point 
                for j=1:length(maskeles)
                    %pn is the point number of a data point that should be
                    %added to this nodes segment
                    pn=maskeles(j);
                    if z==0
                        if testmask(index(pn,1), index(pn,2),2)<U(pn)%&&newmask(index(pn,1), index(pn,2),2)==0
                            testmask(index(pn,1), index(pn,2),2)=U(pn);
                            testmask(index(pn,1), index(pn,2),1)=i;
                            n=1;
                        end
                    end
                end
                %mapedges(matrix, testmask(:,:,1), rows, cols, 125,100);
                %figure
%                 colormapping(testmask(:,:,1));
%                 figure
%                 imshow(testmask(:,:,2))
                %close all
             %end
end
% figure
% mapedges(matrix, testmask(:,:,1), rows, cols, 50,100);
figure
colormapping(testmask(:,:,1));
% figure
% imshow(testmask(:,:,2))
% for i=1:rows
%     for j=1:cols
%         if testmask(i,j,2)==1
%             image(i+yoff,j+xoff,1)=0;
%             image(i+yoff,j+xoff,2)=0;
%             image(i+yoff,j+xoff,3)=0;
%         end
%     end
% end
% imshow(image);
end