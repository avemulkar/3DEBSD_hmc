function [qBrotated, qmis, qmisval] = newqmisbrute(qA,qB)
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

%make local variables
q1 = q(1);
q2 = q(2);
q3 = q(3);
q4 = q(4);

QB(1,:)  = q;
QB(2,:)  = [q4,q3,-1*q2,-1*q1];
QB(3,:)  = [-1*q3,q4,q1,-1*q2];
QB(4,:)  = [q2,-1*q1,q4,-1*q3];
QB(5,:)  = [q1+q4+q2-q3,q2+q4+q3-q1,q3+q4+q1-q2,q4-q1-q2-q3]/2;
QB(6,:)  = [q1-q4-q2+q3,q2-q4-q3+q1,q3-q4-q1+q2,q4+q1+q2+q3]/2;
QB(7,:)  = [q1-q4+q2-q3,q2+q4-q3-q1,q3+q4+q1+q2,q4+q1-q2-q3]/2;
QB(8,:)  = [q1+q4-q2+q3,q2-q4+q3+q1,q3-q4-q1-q2,q4-q1+q2+q3]/2;
QB(9,:)  = [q1+q4+q2+q3,q2-q4+q3-q1,q3+q4-q1-q2,q4-q1+q2-q3]/2;
QB(10,:) = [q1-q4-q2-q3,q2+q4-q3+q1,q3-q4+q1+q2,q4+q1-q2+q3]/2;
QB(11,:) = [q1+q4-q2-q3,q2+q4+q3+q1,q3-q4+q1-q2,q4-q1-q2+q3]/2;
QB(12,:) = [q1-q4+q2+q3,q2-q4-q3-q1,q3+q4-q1+q2,q4+q1+q2-q3]/2;
QB(13,:) = [q2-q3,q4-q1,q4+q1,-q2-q3]/sqrt(2);
QB(14,:) = [q4+q2,q3-q1,q4-q2,-q1-q3]/sqrt(2);
QB(15,:) = [q4-q3,q4+q3,q1-q2,-q1-q2]/sqrt(2);
QB(16,:) = [-q2-q3,q4+q1,-q4+q1,-q2+q3]/sqrt(2);
QB(17,:) = [q4-q2,q3+q1,-q4-q2,-q1+q3]/sqrt(2);
QB(18,:) = [q4+q3,-q4+q3,-q1-q2,-q1+q2]/sqrt(2);
QB(19,:) = [q1+q4,q2+q3,q3-q2,q4-q1]/sqrt(2);
QB(20,:) = [q1-q3,q2+q4,q3+q1,q4-q2]/sqrt(2);
QB(21,:) = [q1+q2,q2-q1,q3+q4,q4-q3]/sqrt(2);
QB(22,:) = [q1-q4,q2-q3,q3+q2,q4+q1]/sqrt(2);
QB(23,:) = [q1+q3,q2-q4,q3-q1,q4+q2]/sqrt(2);
QB(24,:) = [q1-q2,q2+q1,q3-q4,q4+q3]/sqrt(2);


qE=zeros(24,4);
QBn=zeros(24,1);
qAt=sort(abs(qA)/norm(qA));
QBt=sort(abs(QB'));
qmisval=zeros(24,4);
for i=1:24
    QBt(:,i)=QBt(:,i)/norm(QBt(:,i));
end

qE = qAt * QBt;

[qBn,J] = max(qE);
    



        
qmis= 2*acosd(qBn);
qBrotated=QBt(:,J);
[~,I]=sort(abs(qA));
qBrotated(I)=qBrotated;
qBrotated=sign(qA).*qBrotated';
qBrotated=qBrotated/norm(qBrotated);

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