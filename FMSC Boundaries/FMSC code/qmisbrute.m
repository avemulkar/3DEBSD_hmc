function [qBrotated, qmis] = qmisbrute(qA,qB)
%Input: qA, qB - Quaternions vectors
%Output: qmis - Minimum misorientation angle between quaternions (radians)
%Calculates the minimum angle between two quaternions in a brute force
%fashion by performing all 24x24 rotations.
%source: "Interfaces in crystalline materials,Sutton, AP and Balluffi RW,
%Oxford University Press, 1995"
%
%% rotation matrices for qA and qB
qA = [qA(1),qA(2),qA(3),qA(4)]/norm(qA);
qB = [qB(1),qB(2),qB(3),qB(4)]/norm(qB);
QB = zeros(24,4);

%make local variables
q1 = qB(1);
q2 = qB(2);
q3 = qB(3);
q4 = qB(4);

QB(1,:)  = qB;
QB(2,:)  = [q4,q3,-1*q2,-1*q1];
QB(3,:)  = [-1*q3,q4,q1,-1*q2];
QB(4,:)  = [q2,-1*q1,q4,-1*q3];

QB(5,:)  = [q1+q4+q2-q3,q2+q4+q3-q1,q3+q4+q1-q2,q4-q1-q2-q3];
QB(6,:)  = [q1-q4-q2+q3,q2-q4-q3+q1,q3-q4-q1+q2,q4+q1+q2+q3];
QB(7,:)  = [q1-q4+q2-q3,q2+q4-q3-q1,q3+q4+q1+q2,q4+q1-q2-q3];
QB(8,:)  = [q1+q4-q2+q3,q2-q4+q3+q1,q3-q4-q1-q2,q4-q1+q2+q3];
QB(9,:)  = [q1+q4+q2+q3,q2-q4+q3-q1,q3+q4-q1-q2,q4-q1+q2-q3];
QB(10,:) = [q1-q4-q2-q3,q2+q4-q3+q1,q3-q4+q1+q2,q4+q1-q2+q3];
QB(11,:) = [q1+q4-q2-q3,q2+q4+q3+q1,q3-q4+q1-q2,q4-q1-q2+q3];
QB(12,:) = [q1-q4+q2+q3,q2-q4-q3-q1,q3+q4-q1+q2,q4+q1+q2-q3];

QB(5:12,:)=QB(5:12,:)/2;

QB(13,:) = [q2-q3,q4-q1,q4+q1,-q2-q3];
QB(14,:) = [q4+q2,q3-q1,q4-q2,-q1-q3];
QB(15,:) = [q4-q3,q4+q3,q1-q2,-q1-q2];
QB(16,:) = [-q2-q3,q4+q1,-q4+q1,-q2+q3];
QB(17,:) = [q4-q2,q3+q1,-q4-q2,-q1+q3];
QB(18,:) = [q4+q3,-q4+q3,-q1-q2,-q1+q2];
QB(19,:) = [q1+q4,q2+q3,q3-q2,q4-q1];
QB(20,:) = [q1-q3,q2+q4,q3+q1,q4-q2];
QB(21,:) = [q1+q2,q2-q1,q3+q4,q4-q3];
QB(22,:) = [q1-q4,q2-q3,q3+q2,q4+q1];
QB(23,:) = [q1+q3,q2-q4,q3-q1,q4+q2];
QB(24,:) = [q1-q2,q2+q1,q3-q4,q4+q3];

QB(13:24,:) = QB(13:24,:)/sqrt(2);


qAt=sort(abs(qA));
QBt=sort(abs(QB'));

QBt = bsxfun(@rdivide,QBt,sqrt(sum(QBt.^2,1)));

qE = qAt * QBt;

[qBn,J] = max(qE);
qmis= real(2*acosd(qBn));

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