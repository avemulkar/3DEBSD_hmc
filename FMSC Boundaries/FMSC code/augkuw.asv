function filtered = augkuw(original)
%Inputs: Original - a nxnx4 matrix of quaternion orientation data.
%        winsize - size of the Kuwahara filter window: legal values are
%                      5, 9, 13, ... = (4*k+1)
%
%Output: filtered - a nxnx4 matrix of filtered quaternion orientation data
% %% Incorrect input handling
% error(nargchk(2, 2, nargin, 'struct'));
% 
% % non-double data will be cast
% if ~isa(original, 'double')
%     original = double(original);
% end % if
% 
% % wrong-sized kernel is an error
% if mod(winsize,4)~=1
%     error([mfilename ':IncorrectWindowSize'],'Incorrect window size: %d',winsize)
% end % if


%% Zero/One pad matrix for boundary cases

[m n ell] = size(original);
pad = zeros(m+4,n+4,4);
pad(3:m+2,3:n+2,:) = original;
original = pad;

%% Calculate Standard deviation and Mean

filtered = zeros(m,n,ell);
for j = 1+2:m+2;
    for i = 1+2:n+2;            
        xbar = zeros(4,8);
        vari = zeros(1,8);
        [xbar(:,1),vari(1)] = subwinmean(original(j-2:j+0,i-2:i+0,:));
        [xbar(:,2),vari(2)] = subwinmean(original(j-2:j+0,i-1:i+1,:));
        [xbar(:,3),vari(3)] = subwinmean(original(j-2:j+0,i-0:i+2,:));
        [xbar(:,4),vari(4)] = subwinmean(original(j-1:j+1,i-2:i+0,:));
        [xbar(:,5),vari(5)] = subwinmean(original(j-1:j+1,i-0:i+2,:));
        [xbar(:,6),vari(6)] = subwinmean(original(j-0:j+2,i-2:i+0,:));
        [xbar(:,7),vari(7)] = subwinmean(original(j-0:j+2,i-1:i+1,:));
        [xbar(:,8),vari(8)] = subwinmean(original(j-0:j+2,i-0:i+2,:));
        [~,I] = min(vari);
        filtered(j-2,i-2,:) = xbar(:,I)/norm(xbar(:,I));
    end
end
end %function


