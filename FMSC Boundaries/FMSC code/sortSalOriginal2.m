function [finalmask, elements]=sortSalOriginal2(AllSals, storage, lengths, mask, matrix)
[~,elements] = sort(AllSals,'ascend');
Ss=[ones(lengths(1),1)];
lengthsub=[0];
rows=size(mask,1);
cols=size(mask,2);
index=zeros(rows*cols,2);
for i=1:rows
    for j=1:cols
        index((i-1)*cols+j,:)=[i;j];
    end
end
for i=2:length(storage)
    Ss=[Ss; i*ones(lengths(i),1)];    
    lengthsub=[lengthsub, lengthsub(i-1)+lengths(i-1)];
end
i=1;
newmask=zeros(rows,cols,2);
g=1;
noisecheck(newmask)
while ~noisecheck(newmask) && i<=length(elements)
    if lengths(Ss(elements(i)))>1 && Ss(elements(i))>10
        n=0;        
        curele=elements(i);
        if AllSals(curele)>0
            curs=Ss(curele);
            U=zeros(lengths(curs),1);
            U(curele-lengthsub(curs))=1;
            for j=curs:-1:2
                U(U>.9)=ones(length(find(U>.9)),1);
                U(U<.1)=zeros(length(find(U<.1)),1);
                U=storage(j).Ps*U;
            end
            maskeles=find(U>.5);
    %         counter=0;
    %         for k=1:length(maskeles)
    %             if newmask(index(maskeles(k),1), index(maskeles(k),2),2)>0
    %                 counter=counter+1;
    %             end
    %         end
    %         if counter<.9*length(maskeles) || counter<5
             if length(maskeles)>10
                %if nnz(newmask(index(maskeles,1), index(maskeles,2),2))==0
                for j=1:length(maskeles)
                    if newmask(index(maskeles(j),1), index(maskeles(j),2),2)<U(maskeles(j))&&newmask(index(maskeles(j),1), index(maskeles(j),2),2)<.1
                        newmask(index(maskeles(j),1), index(maskeles(j),2),2)=U(maskeles(j));
                        newmask(index(maskeles(j),1), index(maskeles(j),2),1)=g;
                        n=1;
                    end
                end
            end
            % end
    %        end
            if n==1
                curs;
                curele;
                colormapping(newmask(:,:,1));
                %mapedges(matrix,newmask(:,:,1), rows, cols, 0,0);
                g=g+1;
%                 if length(Ucover(:,elements(i))>0)>0
% %                    AllSals(find(Ucover(:,elements(i))>0))=zeros(length(find(Ucover(:,elements(i)))),1);
%                 end
                AllSals(elements(i))
            end
        end
    end
    i=i+1;
end

%mapedges(matrix, newmask(:,:,1), rows, cols, 0,0);
finalmask=newmask(:,:,1);
newmask(:,:,1)=nosieremove(newmask(:,:,1));
colormapping(newmask(:,:,1));