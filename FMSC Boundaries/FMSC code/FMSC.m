function [mask, W, Sal, index]=FMSC(path, Kpasses)%, r, rmn, Sc, St)
[W, rows, cols, filtered]=runspec(path, Kpasses);
mask=zeros(rows, cols);
nextmask=mask;
for i=1:rows
    for j=1:cols
        nextmask(i,j)=(i-1)*cols+j;
    end
end
index=zeros(rows*cols,1);
for i=1:rows*cols
    index(i)=i;
end
Sal=Inf*ones(length(W),1);
s=0
while ~(isequal(nextmask,mask))
    mask=nextmask;
    [nextmask, W, index, Sal]=CoarsenGraph(mask, W, .2, index, Sal);
    s=s+1
    nextmask==mask;
    %figure;
    %colormapping(mask);
end
colormapping(mask);