%function Wcoarse = coarsen7_fast(Wcoarse,Avesnew,Qvar,cmaha)

%% part 10
%Use the Qvar and misorientation to find the Mahalanobis distance, then use
%that to reweight the nodes.

% if s > 1  %3   %why greater than 3? AV 6/14/12
    
    %% calculate new values
    [rows, cols]=find(Wcoarse);
    
    
    
%     'parfor'
%     toc
    
    %if too much memory usage in qmmisbruge_fast_vector
    del = zeros(length(rows),1);
    
    parfor i = 1:length(rows)   %Misorientations between each pair of nodes
        %[~, deli, ~]=qmisbrute(Avesnew(rows(i),1:4) ,Avesnew(cols(i),1:4));
        deli=qmisbrute_fast(Avesnew(rows(i),1:4) ,Avesnew(cols(i),1:4));
        del(i) = deli;
    end
        
    %del = qmisbrute_fast_vector(Avesnew(rows,1:4),Avesnew(cols,1:4));
    
%     toc
    
    newRows = rows(abs(del)>1e-3); clear rows;
    newCols = cols(abs(del)>1e-3); clear cols;
    del = del(abs(del)>1e-3); clear deli;
    
    sqrtstuff = sqrt(min(Qvar(newRows),Qvar(newCols)));
    
    newVals = getsparse(Wcoarse,newRows,newCols).*...
                       exp(-cmaha*(abs(del)-1.*...      %why subtract one? -AL 5/22
                       sqrtstuff)./...
                       sqrtstuff);

    clear sqrtstuff; clear del;
    
    %% concatenate data
    Wcoarse = setsparse(Wcoarse,newRows,newCols,newVals);
    clear newRows; clear newCols; clear newVals;
    %{
    newSize = size(Wcoarse);

    %%function newSparse = sparseConcat(oldSparse,newRows,newCols,newVals,newSize)
    [Si Sj Sv] = find(Wcoarse); clear Wcoarse;

    %if oldSparse empty, newSparse = newValues
    if isempty(Sv)
        Wcoarse = sparse(newRows,newCols,newVals,... 
                           newSize(1),newSize(2));
    %if newValues empty, newSparse = oldSparse
    elseif isempty(newVals)
        Wcoarse = sparse(Si,Sj,Sv,newSize(1),newSize(2));
    %if neither empty, newSParse = oldSparse with newVals
    else
        idx = ismember([Si Sj],[newRows newCols],'rows');
        idx = ~idx;
        Wcoarse = sparse([Si(idx);newRows],...
                           [Sj(idx);newCols],...
                           [Sv(idx);newVals],...
                           newSize(1),newSize(2));
    end

    clear newRows; clear newCols; clear newVals;
    clear Si; clear Sj; clear Sv;
    clear idx;
    %}

% end

%% original code
%{
if s>3
    for i=1:length(rows)
        [~, del, ~]=qmisbrute(Avesnew(rows(i),1:4) ,Avesnew(cols(i),1:4));
        if abs(del)>1e-3
            Wcoarse(rows(i),cols(i))=Wcoarse(rows(i), cols(i))*...
                exp(-cmaha*(abs(del)-1*sqrt(min(Qvar(rows(i)),Qvar(cols(i)))))/...
                sqrt(min(Qvar(rows(i)),Qvar(cols(i)))));
        end
    end
end
%}
