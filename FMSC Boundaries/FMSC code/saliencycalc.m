function [Saliency, makeup]=saliencycalc(s, element, storage)
    if s==6
        Saliency=storage(s).Vs(element)*storage(s).Sals(element);
        makeup=[element,s];
    else
        Uslower=storage(s).Ps*storage(s).Us(:,element);
        Uslower(Uslower>.9)=ones(length(find(Uslower>.9)),1);
        Uslower(Uslower<.1)=zeros(length(find(Uslower<.1)),1);
        lowerelements=find(Uslower>.49);
        Saliencylower=0;
        makeuplow=[];
        for i=1:length(lowerelements)
            [Saliencylowertemp, indexlist]=saliencycalc(s-1, lowerelements(i), storage);
            makeuplow=[makeuplow;indexlist];
            Saliencylower=Saliencylower+Saliencylowertemp;
        end
        if storage(s).Vs(element)*storage(s).Sals(element)<Saliencylower
            Saliency=storage(s).Vs(element)*storage(s).Sals(element);
            makeup=[element, s];
        else
            Saliency=Saliencylower;
            makeup=makeuplow;
        end
    end
end