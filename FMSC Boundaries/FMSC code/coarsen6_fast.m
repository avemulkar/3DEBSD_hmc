%% part 7
%function P = coarsen6_fast(P,W,links,Aves,Celements)

%Calculate the new W and links
Wcoarse=P'*W*P; clear W;
nextlinks=P'*links*P; clear links;

%Calculate the new aves and xlxm expected value.
Avesnew=Aves(Celements,:);

%calculate the number of data points in each new node            
vnew=P'*v;

%Qvar is the variance of each new node
Qvar=zeros(length(Wcoarse),1);

%estimate size of array
counter=1;
newRows = zeros(length(Celements),1);
newCols = zeros(length(Celements),1);

%Calculate the new quaternion variances and averages using 
%the online variance updating algorithm from Chan et al.
for i=1:length(Celements)
    elelist=find(P(:,i)>.05);
    elelist(elelist==Celements(i))=[];
    Qvar(i)=Varin(Celements(i));
    vcum=v(Celements(i));
    if ~isempty(elelist)
      for j=1:length(elelist)
          [qBrotated, del]=qmisbrute(Avesnew(i,1:4),Aves(elelist(j),1:4));
          del=abs(del);
          if del<quatmax
             % (Avesnew(i,1:4)-Aves(elelist(j),1:4))*(Avesnew(i,1:4)-Aves(elelist(j),1:4))'
              vele=v(elelist(j))*P(elelist(j),i);
              vtmp=vcum+vele;
              Avesnew(i,:)=((vcum*Avesnew(i,:))+(vele*[qBrotated, Aves(j,5:7)]))/vtmp;
              Avesnew(i,1:4)=Avesnew(i,1:4)/norm(Avesnew(i,1:4));
              Qvar(i)=vcum*Qvar(i)+vele*Varin(elelist(j))+(del^2*(vcum*vele)/vtmp);
              Qvar(i)=Qvar(i)/vtmp;
              vcum=vtmp;
          else
              %P(elelist(j),i)=0;
              newRows(counter) = elelist(j);
              newCols(counter) = i;
              counter=counter+1;
              %}
          end
       end
    end
    %vnew(i)=vcum;
end
 
%zero selected elements of P
newRows(counter:end)=[];
newCols(counter:end)=[];
newSize = size(P);

clear counter; 
clear v; clear vcum; clear vtemp; clear vele;
clear del; clear qBrotated; clear elelist;

addpath('C:\Users\Andrew\Desktop\Research\3DEBSDrepos\FMSC Boundaries\sparsesubaccess')

P = setsparse(P,newRows,newCols,zeros(length(newRows),1));
clear newRows; clear newCols; clear newVals;
%% function P = Psparse2one(P,newRows,newCols,newVals,newSize)
%{
[Si Sj Sv] = find(P); clear P;

%if oldSparse empty, newSparse = newValues
if isempty(Sv)
    P = sparse(newRows,newCols,zeros(length(newRows),1),... 
                       newSize(1),newSize(2));
%if newValues empty, newSparse = oldSparse
elseif isempty(newRows)
    P = sparse(Si,Sj,Sv,newSize(1),newSize(2));
%if neither empty, newSParse = oldSparse with newVals
else
    idx = ismember([Si Sj],[newRows newCols],'rows');
    idx = ~idx;
    P = sparse([Si(idx);newRows],...
                       [Sj(idx);newCols],...
                       [Sv(idx);zeros(length(newRows),1)],...
                       newSize(1),newSize(2));
end

clear newRows; clear newCols;
clear Si; clear Sj; clear Sv;
clear idx; clear newSize;
%}