function newimage=cleanimage(image)
[rows,cols,~]=size(image);
newimage=image;
for i=1:rows
    for j=1:cols
        if image(i,j,1)==0&&image(i,j,2)==0&&image(i,j,3)==0
            colorlist=[];
            for k=max(i-3,1):min(i+3,rows)
                for l=max(j-3,1):min(j+3,cols)
                    if image(k,l,1)~=0&&image(k,l,2)~=0&&image(k,l,3)~=0
                        colorlist=[colorlist;[image(k,l,1),image(k,l,2),image(k,l,3)]];
                    end
                end
            end
            if ~isempty(colorlist)
                newimage(i,j,1)=median(colorlist(:,1));
                newimage(i,j,2)=median(colorlist(:,2));
                newimage(i,j,3)=median(colorlist(:,3));
            end
        end
    end
end