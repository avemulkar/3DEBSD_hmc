function [Wcoarse, Sal, vnew, P, Qnew, nextlinks, Avesnew, Qvar]=Coarsen(W, alpha, links, v, s,Q, Aves, Varin,z, prevSal)
%Performs one coarsening step.



%F represents whether the nodes are Coarse nodes or not.
%0 means they are, 1 means they aren't
F=ones(length(W),1);
'Calculate Coarse Nodes'
%Celements is the list of nodes that are coarse nodes.
Celements=[];
%The nodes are considered in order of descending size
[~,iorder] = sort(v, 'descend');
%consider each node, and check whether or not
%to add it to the list of coarse nodes.
for i=iorder'
    sumK=W(i,:)*(1-F);
    sumV=sum(W(i,:))-W(i,i);
    if sumK<alpha*sumV
        F(i)=0;
        Celements=[Celements, i];
    end
end
%Go through each non-coarse node again.  Check if the strongest
%attachment the node has is to a coarse node.  If not add it to
%the list of coarse nodes.  Novel!
% for i=find(F)'
%     F(i)=0;
%     if max(W(i,Celements))<max(W(i,:).*F')
%         Celements=[Celements, i];
%     else
%         F(i)=1;
%     end
% end
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
%Divide P such that each row sums to 1.
for i=1:length(W)
    if sum(P(i,:))>0
        P(i,:)=P(i,:)/sum(P(i,:));
    else
        Celements=[Celements,i];
        P(i, Celements == i )=1;
        F(i)=0;
    end
end
% for i=1:length(W)
%     %gamma=1/(length(find(P(i,:)))*5);
%     gamma=.1;
%     if find(P(i,:)<gamma)<.2*length(find(P(i,:)))
%          P(i,P(i,:)<gamma)=zeros(1,length(find(P(i,:)<gamma)));
%     end
% end
for i=1:length(W)
    if sum(P(i,:))>0
        P(i,:)=P(i,:)/sum(P(i,:));
    else
        Celements=[Celements,i];
        P(i, Celements == i )=1;
        F(i)=0;
    end
end
%Implement anti-grouping measures, as done in ________
% if s>4
%     for i=find(F)'
%         str=find(P(i,:)>0.5);
%         if  ~isempty(str)
%             F(str)=1;
%             [maxi,~]=max(W(str,:)'.*(1-F));
%             F(str)=0;
%             if 10*W(i,str)<maxi
%                 P(i,str)=0;
%                 if sum(P(i,:))==0;
%                     Celements=[Celements,i];
%                     F(i)=0;
%                     P=[P,zeros(length(W),1)];
%                     P(i,length(Celements))=1;
%                 else
%                     P(i,:)=P(i,:)/sum(P(i,:));
%                 end
%             end
%         end
%     end
% end

'done making P'
%Calculate the new W and links
Wcoarse=P'*W*P;
nextlinks=P'*links*P;

%Calculate the new aves and xlxm expected value.
Avesnew=zeros(length(Celements),6+z);
Qnew=zeros(length(Celements),6+z,6+z);
for i=1:length(Celements)
    for j=1:6+z
        for k=1:6+z
            Qnew(i,j,k)=P(:,i)'*(v.*Q(:,j,k))/(P(:,i)'*v);
        end
    end
end
%calculate the number of data points in each new node            
vnew=P'*v;

%store the sums of the rows before reweighting

[rows, cols]=find(Wcoarse);
%Qvar is the variance of each new node
Qvar=zeros(length(Wcoarse),1);

Intorig=zeros(length(Wcoarse),1);
%Calculate the new quaternion variances and averages using 
%the online variance updating algorithm from Chan et al.
for i=1:length(Celements)
    elelist=find(P(:,i)>.1);
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
  Intorig(i)=sum(Wcoarse(i,:))-Wcoarse(i,i);
end
%PCA stuff.

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


%Use the Qvar and misorientation to find the Mahalanobis distance, then use
%that to reweight the nodes.
if s>3
    for i=1:length(rows)
        if qmisrollett(Avesnew(rows(i),:),Avesnew(cols(i),:))>0
            Wcoarse(rows(i),cols(i))=Wcoarse(rows(i), cols(i))*...
                exp(-5*(qmisrollett(Avesnew(rows(i),:),Avesnew(cols(i),:))-2*sqrt(min(Qvar(rows(i)),Qvar(cols(i)))))/...
                sqrt(min(Qvar(rows(i)),Qvar(cols(i)))));
        end
    end
end
for i=1:length(Wcoarse)
    if sum(Wcoarse(i,:))>0
        Wcoarse(i,:)=Wcoarse(i,:)*...
               (Intorig(i))/(sum(Wcoarse(i,:)));
        Wcoarse(i,i)=Intorig(i);
    end
end


%Calculate L and Sal for the new nodes.
Lcoarse=LaplaceW(Wcoarse);
Sal=zeros(length(Wcoarse),1);
for i=1:length(Wcoarse)
    Sal(i)=2*(Lcoarse(i,i)*(nextlinks(i,i)))/(Wcoarse(i,i)*(sum(nextlinks(:,i))-nextlinks(i,i)));
    %Sal(i)=2*(Lcoarse(i,i))/(Wcoarse(i,i));
end
'Max Variance'
sqrt(max(Qvar))
sqrt(median(Qvar))