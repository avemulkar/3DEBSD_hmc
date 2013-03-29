function [check,mask]=noisecheck(mask)
[rows,cols]=find(mask==0);
check=0;
for i=1:length(rows)
    list=[];
    if rows(i)>1
        list=[list, mask(rows(i)-1,cols(i))]; 
%         if mask(rows(i)-1,cols(i))==0
%             check=0;
%         end
    end
    if rows(i)<size(mask,1)
        list=[list, mask(rows(i)+1,cols(i))]; 
%         if mask(rows(i)+1,cols(i))==0
%             check=0;
%         end
    end
    if cols(i)>1
        list=[list, mask(rows(i),cols(i)-1)]; 
%         if mask(rows(i),cols(i)-1)==0
%             check=0;
%         end
    end
    if cols(i)<size(mask,2)
        list=[list, mask(rows(i),cols(i)+1)]; 
%         if mask(rows(i),cols(i)+1)==0
%             check=0;
%         end
    end
    if mode(list)~=0
        mask(rows(i),cols(i))=mode(list); 
    end
end