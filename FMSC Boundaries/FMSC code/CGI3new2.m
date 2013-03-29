function [Wcoarse, Ucur, Lcoarse, Sal, vnew, P, Urel, Qnew, nextlinks, Avesnew, Signew, Qvar, Ucover]=CGI3new2(W, alpha, links, v, s,Q, Urel,storage, Qstart, Lin, Aves, Sig,Ucover, Varin)
size(W)
size(links)
F=ones(length(W),1);
'Calculate Coarse Nodes'
Celements=[];
[~,iorder] = sort(v, 'descend');
for i=iorder'
    sumK=W(i,:)*(1-F);
    sumV=sum(W(i,:))-W(i,i);
    if sumK<alpha*sumV
        F(i)=0;
        Celements=[Celements, i];
    end
end
for i=find(F)'
    F(i)=0;
    if max(W(i,Celements))<max(W(i,:).*F')
        Celements=[Celements, i];
    else
        F(i)=1;
    end
end
'Done initializing coarse nodes'
%Calculate P
P=sparse(length(W), length(Celements));
for i=1:length(W)  
    if F(i)==1
        P(i,:)=W(i, Celements);
    else
        P(i, Celements == i )=1;
    end
end
for i=1:length(W)
    if sum(P(i,:))>0
        P(i,:)=P(i,:)/sum(P(i,:));
    else
        Celements=[Celements,i];
        P(i, Celements == i )=1;
        F(i)=0;
    end
end

if s>4
    for i=find(F)'
        str=find(P(i,:)>0.5);
        if  ~isempty(str)
            F(str)=1;
            [maxi,~]=max(W(str,:)'.*(1-F));
            F(str)=0;
            if 10*W(i,str)<maxi
                P(i,str)=0;
                if sum(P(i,:))==0;
                    Celements=[Celements,i];
                    F(i)=0;
                    P=[P,zeros(length(W),1)];
                    P(i,length(Celements))=1;
                else
                    P(i,:)=P(i,:)/sum(P(i,:));
                end
            end
        end
    end
end
'done making P'
Wcoarse=P'*W*P;
nextlinks=P'*links*P;
    
Uout=speye(length(Celements));
Ucur=[];
U2=[];
Unew=sparse(length(Urel), length(Ucover));
size(Ucover)
size(Unew)
Unew(1:size(Ucover,1),:)=Ucover;
Ucover=Unew;

Avesnew=zeros(length(Celements),6);
Qnew=zeros(length(Celements),6,6);
for i=1:length(Celements)
    for j=1:6
        for k=1:6
            Qnew(i,j,k)=P(:,i)'*(v.*Q(:,j,k))/(P(:,i)'*v);
        end
    end
end
Signew=zeros(length(Celements),1);
for i=1:length(Celements)
    Signew(i)=(P(:,i)'*(v.*Sig))/(P(:,i)'*v);
end                 
vnew=P'*v;
[rows, cols]=find(Wcoarse);
Qvar=zeros(length(Wcoarse),1);
origsum=sum(Wcoarse);
Intorig=zeros(length(Wcoarse),1);
for i=1:length(Celements)
    elelist=find(P(:,i));
    Avesnew(i,:)=Aves(elelist(1),:);
    Qvar(i)=Varin(elelist(1));
    vcum=v(elelist(1));
    if length(elelist)>1
      for j=2:length(elelist)
          del=qmisrollett(Avesnew(i,1:4), Aves(elelist(j),1:4));
          vtmp=vcum+v(elelist(j));
          Avesnew(i,:)=((vcum*Avesnew(i,:))+(v(elelist(j))*Aves(elelist(j),:)))/vtmp;
          Avesnew(i,1:4)=Avesnew(i,1:4)/norm(Avesnew(i,1:4));
          Qvar(i)=vcum*Qvar(i)+v(elelist(j))*Varin(elelist(j))+(del^2*(vcum*v(elelist(j)))/vtmp);
          Qvar(i)=Qvar(i)/vtmp;
          vcum=vtmp;
      end
    end
  Intorig(i)=Wcoarse(i,i);
end
% if s>2
%     Covars=zeros(6,6,length(Celements));
%     FPA=zeros(length(Celements),6);
%     lambdas=zeros(length(Celements),2);
%     for i=1:length(Celements)
%         for j=1:6
%             for k=1:6
%                 Covars(j,k,i)=Qnew(i,j,k)-Avesnew(i,j)*Avesnew(i,k);
%             end
%         end
%         [V,D]=eig(full(Covars(:,:,i)));
%         [lambda, I]=sort(diag(D), 'descend');
%         FPA(i,:)=V(I);
%         lambdas(i,:)=lambda(1:2)';
%     end
%     for i=1:length(rows)
% %         Roc=((sqrt(lambdas(rows(i),1))+sqrt(lambdas(cols(i),1)))/2)^2/...
% %             (4*(sqrt(lambdas(rows(i),2))+sqrt(lambdas(cols(i),2))));
% %         CoM=abs(Avesnew(rows(i),:)-Avesnew(cols(i),:));
% %         CoME=sqrt(CoM(1,5:6)*CoM(1,5:6)');
% %         CoM=CoM/norm(CoM);
% %         phi1=acos(abs(FPA(rows(i),:))*CoM'/norm(FPA(rows(i),:)));
% %         phi2=acos(abs(FPA(cols(i),:))*CoM'/norm(FPA(cols(i),:)));
%         phi=acos(abs(FPA(rows(i),:))*abs(FPA(cols(i),:))');
%          %if exp(-(((phi1^2+phi2^2-phi1*phi2))))>.9
%          if exp(-abs(phi))>.9
%              Wcoarse(rows(i),cols(i))=2*Wcoarse(rows(i),cols(i));
%          end
%     end
% end           


% if s<3
%     for i=1:length(rows)
%         if qmisrollett(Avesnew(rows(i),1:4),Avesnew(cols(i),1:4))>0
%             Wcoarse(rows(i),cols(i))=Wcoarse(rows(i),cols(i))*...
%                 exp(-10*qmisrollett(Avesnew(rows(i),1:4),Avesnew(cols(i),1:4))/(1e-6+Signew(rows(i))+Signew(cols(i))));
%         end
%     end
% end
if s>0
    for i=1:length(rows)
        if qmisrollett(Avesnew(rows(i),:),Avesnew(cols(i),:))>0%sqrt(min(Qvar(rows(i)),Qvar(cols(i))))
            Wcoarse(rows(i),cols(i))=Wcoarse(rows(i), cols(i))*...
                exp(-5*(qmisrollett(Avesnew(rows(i),:),Avesnew(cols(i),:))-1*sqrt(min(Qvar(rows(i)),Qvar(cols(i)))))/...
                sqrt(min(Qvar(rows(i)),Qvar(cols(i)))));
        end
    end
end
% for i=1:length(Wcoarse)
%     if sum(Wcoarse(i,:))-Intorig>0
%         Wcoarse(i,:)=Wcoarse(i,:)*...
%                (origsum(i)-Intorig(i))/(sum(Wcoarse(i,:))-Intorig(i));
%         Wcoarse(i,i)=Intorig(i);
%     end
% end
Lcoarse=LaplaceW(Wcoarse);
Sal=zeros(size(Uout,2),1);
for i=1:size(Uout,2)
    %Sal(i)=2*(Uout(:,i)'*Lcoarse*Uout(:,i)*(nextlinks(i,i)))/(Uout(:,i)'*Wcoarse*Uout(:,i)*(sum(nextlinks(:,i))-nextlinks(i,i))+1e-10);
    Sal(i)=2*(Uout(:,i)'*Lcoarse*Uout(:,i))/(Uout(:,i)'*Wcoarse*Uout(:,i));
end
'Max Variance'

sqrt(max(Qvar))
sqrt(median(Qvar))