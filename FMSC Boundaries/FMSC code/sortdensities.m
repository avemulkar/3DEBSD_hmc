function iorder=sortdensities(W)
    sumW=sum(W);
    for i=1:length(W)
        sumW(i)=sumW(i)/nnz(W(i, :));
    end
   [~,iorder] = sort(sumW, 'ascend');
    