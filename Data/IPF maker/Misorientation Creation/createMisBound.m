function [Bound, pos]= createMisBound(row, index, value)
%value is a 6bit number, each bit representing the presence of a
%   misorientation along that boundary
%row   is the row of the hexagon
%index is the hexgagons position as an index of possible position (each
%   index is half the width of a hexagon)
%Bound is a cell array of containing each edge segment

%Right side of hexagon corresponds to bit 1, then incrementing clockwise
side1= [12 4;
        12 5;
        12 6;
        12 7;
        12 8;
        12 9;
        12 10;
        12 11];
side2= [12 11;
        11 12;
        10 12;
        9 13;
        8 13;
        7 14];
side3= [6 14;
        5 13;
        4 13;
        3 12;
        2 12;
        1 11];
side4= [1 4;
        1 5;
        1 6;
        1 7;
        1 8;
        1 9;
        1 10;
        1 11];
side5= [1 4;
        2 3;
        3 3;
        4 2;
        5 2;
        6 1];
side6= [7 1;
        8 2;
        9 2;
        10 3;
        11 3;
        12 4];

Bound = {};
pos= [row, index];
entry = 1;
if (bitget(value, 1))
    Bound{entry} = [side1(:,1) + 6 * index, side1(:,2) + row * 11];
    entry = entry + 1;
end

if (bitget(value, 2))
    Bound{entry} = [side2(:,1) + 6 * index, side2(:,2) + row * 11];
    entry = entry + 1;
end

if (bitget(value, 3))
    Bound{entry} = [side3(:,1) + 6 * index, side3(:,2) + row * 11];
    entry = entry + 1;
end

if (bitget(value, 4))
    Bound{entry} = [side4(:,1) + 6 * index, side4(:,2) + row * 11];
    entry = entry + 1;
end

if (bitget(value, 5))
    Bound{entry} = [side5(:,1) + 6 * index, side5(:,2) + row * 11];
    entry = entry + 1;
end

if (bitget(value, 6))
    Bound{entry} = [side6(:,1) + 6 * index, side6(:,2) + row * 11];
end

for i = 1:length(Bound)
    hold on
    plot(Bound{i}(:,1), Bound{i}(:,2))
    hold on
end