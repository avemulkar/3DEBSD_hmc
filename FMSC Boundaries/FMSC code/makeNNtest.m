transfM=[];
for z=4:8
    for y=.4:.1:.8
        for x=.4:.1:.8
            transfM=[transfM; 1 1 1 x y 1 z];
            i=i+1;
        end
    end
end