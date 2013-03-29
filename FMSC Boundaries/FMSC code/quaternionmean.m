function qmean=quaternionmean(Q,W)
qmean=Q(1,:);
wsum=W(1);
for i=2:size(Q,1)
    [qBrotated qmis] = qmisbrute(qmean,Q(i,:));
    qmean=wsum*qmean+W(i)*qBrotated;
    wsum=wsum+W(i);
    qmean=qmean/norm(qmean);
end
    