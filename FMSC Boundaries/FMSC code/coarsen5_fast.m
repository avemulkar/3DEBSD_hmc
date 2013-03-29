function W=CleanerForBrian(W)
for i=1:length(W)
   sumT=sum(W(:,i));
   elementsT=find(W(:,i));
   lengthT=length(elementsT);
   for j=1:lengthT
       if W(elementsT(j),i)<sumT/(3*length(elementsT))
           W(elementsT(j),i)=0;
       end
   end
end