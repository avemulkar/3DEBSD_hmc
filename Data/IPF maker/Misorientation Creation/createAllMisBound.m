function [Bound, pos]= createAllMisBound(row, index, value)

len = length(row);

for i = 1 : len
    [Bound, pos] = createMisBound(row(i), index(i), value(i));
end