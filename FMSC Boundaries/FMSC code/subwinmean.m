function [N V] = subwinmean(A)
%Input:  A - 3x3x4 matrix to be averaged using quaternion math
%Output: N - 4x1 vector which is the average of the 9 input quaternions
%        V - a scalar which represents the "variance" of the matrix M

M = zeros(4,1);
M(1) = sum(sum(A(:,:,1)));
M(2) = sum(sum(A(:,:,2)));
M(3) = sum(sum(A(:,:,3)));
M(4) = sum(sum(A(:,:,4)));

N = M/norm(M);
V = 0;
for i = 1:3;
    for j = 1:3;
        a = zeros(4,1);
        a(1) = A(i,j,1);
        a(2) = A(i,j,2);
        a(3) = A(i,j,3);
        a(4) = A(i,j,4);
        V = V+qmisrollett(a,N)^2;
    end
end%for
V = V/8;
end%function