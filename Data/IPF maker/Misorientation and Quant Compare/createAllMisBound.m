function [Bound, pos]= createAllMisBound(row, index, value)

len = length(row);
for i = 1 : len
    [bound, pos] = createMisBound(row(i), index(i), value(i));
    Bound{i}= bound;
end