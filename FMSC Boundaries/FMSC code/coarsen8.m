%% function Sal = coarsen8(Wcoarse,nextlinks)
%Calculate L and Sal for the new nodes.
Lcoarse=laplaceW(Wcoarse);
Sal=zeros(length(Wcoarse),1);

parfor i=1:length(Wcoarse)
    Sal(i)=2*(Lcoarse(i,i)*(nextlinks(i,i)))/(Wcoarse(i,i)*(sum(nextlinks(:,i))-nextlinks(i,i)));
    %Sal(i)=2*(Lcoarse(i,i))/(Wcoarse(i,i));
end

% 'Max Variance'
% sqrt(max(Qvar))
% sqrt(median(Qvar))

clear Lcoarse;