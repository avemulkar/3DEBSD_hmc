function [qBrotated, qmis, qmisval] = qmisbrute(qA,qB)
%Input: qA, qB - Quaternions vectors
%Output: qmis - Minimum misorientation angle between quaternions (radians)
%Calculates the minimum angle between two quaternions in a brute force
%fashion by performing all 24x24 rotations.
%source: "Interfaces in crystalline materials,Sutton, AP and Balluffi RW,
%Oxford University Press, 1995"
%
%% rotation matrices for qA and qB
qA = [qA(1),qA(2),qA(3),qA(4)];
if abs(norm(qA)-1)>.01
    'WARNING: Norm is larger than 1%'
end
qA = [qA(1),qA(2),qA(3),qA(4)]/norm(qA);
% QA = zeros(24,4);
% q = qA;
% QA(1,:)  = q;
% QA(2,:)  = [q(4),q(3),-1*q(2),-1*q(1)];
% QA(3,:)  = [-1*q(3),q(4),q(1),-1*q(2)];
% QA(4,:)  = [q(2),-1*q(1),q(4),-1*q(3)];
% QA(5,:)  = [q(1)+q(4)+q(2)-q(3),q(2)+q(4)+q(3)-q(1),q(3)+q(4)+q(1)-q(2),q(4)-q(1)-q(2)-q(3)]/2;
% QA(6,:)  = [q(1)-q(4)-q(2)+q(3),q(2)-q(4)-q(3)+q(1),q(3)-q(4)-q(1)+q(2),q(4)+q(1)+q(2)+q(3)]/2;
% QA(7,:)  = [q(1)-q(4)+q(2)-q(3),q(2)+q(4)-q(3)-q(1),q(3)+q(4)+q(1)+q(2),q(4)+q(1)-q(2)-q(3)]/2;
% QA(8,:)  = [q(1)+q(4)-q(2)+q(3),q(2)-q(4)+q(3)+q(1),q(3)-q(4)-q(1)-q(2),q(4)-q(1)+q(2)+q(3)]/2;
% QA(9,:)  = [q(1)+q(4)+q(2)+q(3),q(2)-q(4)+q(3)-q(1),q(3)+q(4)-q(1)-q(2),q(4)-q(1)+q(2)-q(3)]/2;
% QA(10,:) = [q(1)-q(4)-q(2)-q(3),q(2)+q(4)-q(3)+q(1),q(3)-q(4)+q(1)+q(2),q(4)+q(1)-q(2)+q(3)]/2;
% QA(11,:) = [q(1)+q(4)-q(2)-q(3),q(2)+q(4)+q(3)+q(1),q(3)-q(4)+q(1)-q(2),q(4)-q(1)-q(2)+q(3)]/2;
% QA(12,:) = [q(1)-q(4)+q(2)+q(3),q(2)-q(4)-q(3)-q(1),q(3)+q(4)-q(1)+q(2),q(4)+q(1)+q(2)-q(3)]/2;
% QA(13,:) = [q(2)-q(3),q(4)-q(1),q(4)+q(1),-q(2)-q(3)]/sqrt(2);
% QA(14,:) = [q(4)+q(2),q(3)-q(1),q(4)-q(2),-q(1)-q(3)]/sqrt(2);
% QA(15,:) = [q(4)-q(3),q(4)+q(3),q(1)-q(2),-q(1)-q(2)]/sqrt(2);
% QA(16,:) = [-q(2)-q(3),q(4)+q(1),-q(4)+q(1),-q(2)+q(3)]/sqrt(2);
% QA(17,:) = [q(4)-q(2),q(3)+q(1),-q(4)-q(2),-q(1)+q(3)]/sqrt(2);
% QA(18,:) = [q(4)+q(3),-q(4)+q(3),-q(1)-q(2),-q(1)+q(2)]/sqrt(2);
% QA(19,:) = [q(1)+q(4),q(2)+q(3),q(3)-q(2),q(4)-q(1)]/sqrt(2);
% QA(20,:) = [q(1)-q(3),q(2)+Bq(4),q(3)+q(1),q(4)-q(2)]/sqrt(2);
% QA(21,:) = [q(1)+q(2),q(2)-q(1),q(3)+q(4),q(4)-q(3)]/sqrt(2);
% QA(22,:) = [q(1)-q(4),q(2)-q(3),q(3)+q(2),q(4)+q(1)]/sqrt(2);
% QA(23,:) = [q(1)+q(3),q(2)-q(4),q(3)-q(1),q(4)+q(2)]/sqrt(2);
% QA(24,:) = [q(1)-q(2),q(2)+q(1),q(3)-q(4),q(4)+q(3)]/sqrt(2);
qB = [qB(1),qB(2),qB(3),qB(4)];
QB = zeros(24,4);
q = qB;
QB(1,:)  = q;
QB(2,:)  = [q(4),q(3),-1*q(2),-1*q(1)];
QB(3,:)  = [-1*q(3),q(4),q(1),-1*q(2)];
QB(4,:)  = [q(2),-1*q(1),q(4),-1*q(3)];
QB(5,:)  = [q(1)+q(4)+q(2)-q(3),q(2)+q(4)+q(3)-q(1),q(3)+q(4)+q(1)-q(2),q(4)-q(1)-q(2)-q(3)]/2;
QB(6,:)  = [q(1)-q(4)-q(2)+q(3),q(2)-q(4)-q(3)+q(1),q(3)-q(4)-q(1)+q(2),q(4)+q(1)+q(2)+q(3)]/2;
QB(7,:)  = [q(1)-q(4)+q(2)-q(3),q(2)+q(4)-q(3)-q(1),q(3)+q(4)+q(1)+q(2),q(4)+q(1)-q(2)-q(3)]/2;
QB(8,:)  = [q(1)+q(4)-q(2)+q(3),q(2)-q(4)+q(3)+q(1),q(3)-q(4)-q(1)-q(2),q(4)-q(1)+q(2)+q(3)]/2;
QB(9,:)  = [q(1)+q(4)+q(2)+q(3),q(2)-q(4)+q(3)-q(1),q(3)+q(4)-q(1)-q(2),q(4)-q(1)+q(2)-q(3)]/2;
QB(10,:) = [q(1)-q(4)-q(2)-q(3),q(2)+q(4)-q(3)+q(1),q(3)-q(4)+q(1)+q(2),q(4)+q(1)-q(2)+q(3)]/2;
QB(11,:) = [q(1)+q(4)-q(2)-q(3),q(2)+q(4)+q(3)+q(1),q(3)-q(4)+q(1)-q(2),q(4)-q(1)-q(2)+q(3)]/2;
QB(12,:) = [q(1)-q(4)+q(2)+q(3),q(2)-q(4)-q(3)-q(1),q(3)+q(4)-q(1)+q(2),q(4)+q(1)+q(2)-q(3)]/2;
QB(13,:) = [q(2)-q(3),q(4)-q(1),q(4)+q(1),-q(2)-q(3)]/sqrt(2);
QB(14,:) = [q(4)+q(2),q(3)-q(1),q(4)-q(2),-q(1)-q(3)]/sqrt(2);
QB(15,:) = [q(4)-q(3),q(4)+q(3),q(1)-q(2),-q(1)-q(2)]/sqrt(2);
QB(16,:) = [-q(2)-q(3),q(4)+q(1),-q(4)+q(1),-q(2)+q(3)]/sqrt(2);
QB(17,:) = [q(4)-q(2),q(3)+q(1),-q(4)-q(2),-q(1)+q(3)]/sqrt(2);
QB(18,:) = [q(4)+q(3),-q(4)+q(3),-q(1)-q(2),-q(1)+q(2)]/sqrt(2);
QB(19,:) = [q(1)+q(4),q(2)+q(3),q(3)-q(2),q(4)-q(1)]/sqrt(2);
QB(20,:) = [q(1)-q(3),q(2)+q(4),q(3)+q(1),q(4)-q(2)]/sqrt(2);
QB(21,:) = [q(1)+q(2),q(2)-q(1),q(3)+q(4),q(4)-q(3)]/sqrt(2);
QB(22,:) = [q(1)-q(4),q(2)-q(3),q(3)+q(2),q(4)+q(1)]/sqrt(2);
QB(23,:) = [q(1)+q(3),q(2)-q(4),q(3)-q(1),q(4)+q(2)]/sqrt(2);
QB(24,:) = [q(1)-q(2),q(2)+q(1),q(3)-q(4),q(4)+q(3)]/sqrt(2);

QB = [QB ; QB];
for i = 1:24;
    QB(i+24,4) = -QB(i+24,4);
end
qE=zeros(48,4);
QBn=zeros(48,1);
qAt=abs(qA);
QBt=zeros(1,4);
QBn=inf*ones(48,1);
qmisval=zeros(48,4);
for i=1:48
    QB(i,:)=QB(i,:)/norm(QB(i,:));
    list1=1:4;
        for j=1:4
            QBt(1)=QB(i,list1(j));
            list2=list1;
            list2(j)=[];
            for k=1:3
                QBt(2)=QB(i,list2(k));
                list3=list2;
                list3(k)=[];  
                for l=1:2
                    QBt(3)=QB(i,list3(l));
                    list4=list3;
                    list4(l)=[];
                    QBt(4)=QB(i,list4);
                    qE(i,4)=abs(qAt)*abs(QBt)';
                    if QBn(i)>2*acosd(min(qE(i,4),1));
                        QBn(i)=2*acosd(min(1, qE(i,4)));
                        qmisval(i,:)=QBt;
                    end
                end
            end
        end
end
        
[qmis,J] = min(QBn);
qBrotated=sort(abs(qmisval(J,:)));
[~,I]=sort(abs(qA));
qBrotated(I)=qBrotated;
qBrotated=sign(qA).*qBrotated;

%% Perform dot protduct
%qmisval = zeros(24,1);
%for i = 1:24;
    %for j = 1:24;
        %dot product!
        %qmisval = 2*acosd(qBrotated*qA');
        %qmisval = 2*acosd((-QB*qA'));
        %size(qmisval)
        %qmisval = 2*acosd(abs(dot(qA,QB(i,:))));
        %end
%end


%qBrotated = QB(J,:);