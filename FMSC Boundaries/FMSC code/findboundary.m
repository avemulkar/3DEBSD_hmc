function pointlist=findboundary(x,y, z, map)
segment=map(x,y)
pointlist=[];
for i=2:size(map,1)-1
    for j=2:size(map,2)-1
        if segment==map(i,j)&&((map(i-1,j)==map(i,j))||(map(i+1)==map(i,j))||...
                (map(i,j)==map(i,j-1))||(map(i,j)==map(i,j+1)))
            pointlist=[pointlist, [i;j;z]];
        end
    end
end
