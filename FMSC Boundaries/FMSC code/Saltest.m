function [mask, Wcoarse, Celements, P, sal]=Saltest(P,W, Celements)
L=laplaceW(W);
Wcoarse=P'*W*P;
Lcoarse=P'*L*P;
[M, I]=max(P');
U=sparse(length(Celements), length(W));
for i=1:length(W)
    U(I(i),i)=1;
end
size(Wcoarse)
size(Lcoarse)
size(U'*Lcoarse*U)
size(U'*Wcoarse*U)
Sal=sum((U'*Lcoarse*U)./(0.5.*(U'*Wcoarse*U)));
for i=1:length(PrevSal)
    if Sal(i)>PrevSal(i)
        P(i,:)=zeros(size(P(i,:)));
        P=[P;zeros(length(W))];
        P(i,length(Celements)+1)=1;
        Celements=[Celements, i];
    end
end
Wcoarse=P'*W*P;
%Add Saliency measure, check if adding point to the coarse node decreases.
mask=maskupdate(mask, I, index, Celements);
for i=1:length(Celements)
    Celements(i)=index(Celements(i));
end