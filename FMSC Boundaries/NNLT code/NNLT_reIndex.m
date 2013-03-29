function transfMLT = NNLT_reIndex(transfMLTstruct,lengths123,startIndex)

lengthTransfM = size(transfMLTstruct,1);
transfMLT = cell(lengthTransfM,1);

for pts = 1:lengthTransfM
    transfMLT{pts}= [transfMLTstruct{pts,1}-lengths123(1)+startIndex,...
                     transfMLTstruct{pts,2}+startIndex,...
                     transfMLTstruct{pts,3}+lengths123(2)+startIndex];
end
