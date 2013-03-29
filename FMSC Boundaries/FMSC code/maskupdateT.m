function [mask]=maskupdate(mask, I, index, Celements)
imsize=size(mask);
for i=1:imsize(1)
    for j=1:imsize(2)
        mask(i,j)=index(Celements(I(mask(i,j)==index)));
    end
end