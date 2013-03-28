for n=1:32
    'Slice',int2str(n),'f'= [];
end



for i= 1:length(Firstcell);
    for n= 1:32;
        if Firstcell(i,1)=n;
            if Firstcell(i,2)=1;
                ['Slice', n,'f']= ['Slice',int2str(n),'f';Firstcell(i,:)];
            end
        end
    end
end
