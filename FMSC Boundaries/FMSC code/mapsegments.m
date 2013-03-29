function mask=mapsegments(storage,s, mask)
makeup=[];
for i=1:size(mask,1)
    for j=1:size(mask,2)
        index((i-1)*size(mask,2)+j,:)=[i;j];
    end
end
for i=1:length(storage(s).Us)
    [~, maketemp]=saliencycalc(s, i, storage);
    makeup=[makeup;maketemp];
end
g=1;
zeros(size(mask,1),size(mask,2),length(makeup));
for i=1:length(makeup)
    U=storage(makeup(i,2)).Us(:,makeup(i,1));
    no=0;
    for j=makeup(i,2):-1:1
            U=storage(j).Ps*U;
            U(U>.9)=ones(length(find(U>.9)),1);
            U(U<.1)=zeros(length(find(U<.1)),1);
    end
    maskeles=find(U>.49);
    if ~isempty(maskeles)
        for j=1:length(maskeles)
            if mask(index(maskeles(j),1), index(maskeles(j),2))~=0
                no=1;
            end
        end
        if no==0
            mask(index(maskeles,1),index(maskeles,2))=g;
            g=g+1;
        end
    end
end
colormapping(mask);
    