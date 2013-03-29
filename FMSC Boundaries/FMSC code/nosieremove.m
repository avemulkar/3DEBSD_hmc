function oldmap=nosieremove(oldmap)
imsize=size(oldmap);
for i=1:imsize(1)
    for j=1:imsize(2)
        if oldmap(i,j)~=oldmap(max(i-1,1),j) && oldmap(i,j)~=oldmap(min(i+1, imsize(1)),j)&&...
                oldmap(i,j)~=oldmap(i,max(j-1,1))&&oldmap(i,j)~=oldmap(i,min(j+1, imsize(2)))
            oldmap(i,j)=oldmap(i-1,j);
        end
    end
end
                