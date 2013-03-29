function mapedges(image,nextmask,rows,cols, yoff,xoff)
for i=1:rows
    for j=1:cols
        if i==1||j==1||i==rows||j==cols
            image(i+yoff,j+xoff,1)=0;
            image(i+yoff,j+xoff,2)=0;
            image(i+yoff,j+xoff,3)=0;
        elseif sum(sum(nextmask(i-1:i+1,j-1:j+1)))/9~=nextmask(i,j)
            image(i+yoff,j+xoff,1)=0;
            image(i+yoff,j+xoff,2)=0;
            image(i+yoff,j+xoff,3)=0;
         end
    end
end
imshow(image);
end