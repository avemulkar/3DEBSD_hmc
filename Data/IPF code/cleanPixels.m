function [Mclean outlier] = cleanPixels(M,stdevs)
% cleans pixels outside of stdevs standard deviations of the mean.

avg = mean(M);
stdev = std(M);

outlier = false(size(M,1),1);

for i = 1:3
    outlier  = outlier|(M(:,i)>avg(i)+stdevs*stdev(i));
end

M(outlier,:) = [];

Mclean = M;