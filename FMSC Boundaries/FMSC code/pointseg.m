function pointseg(AllSals, Ucover, x, y, rows, cols, Urel)

poss= find(Ucover((x-1)*rows+y,:)>.5)
[I, M]=min(AllSals(poss))
nextmask=zeros(rows,cols);
for i=1:rows
    for j=1:cols

        nextmask(i,j)=Urel((i-1)*rows+j, poss(M));
%         if nextmask(i,j)>.2
%             nextmask(i,j)=1;
%         end
    end
end
colormapping(nextmask)