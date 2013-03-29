function [assignmentsN flag contPoints] = clustBreaker(assignmentsN, point, assignments, flag, NNlist, oldClust, newClust, xRange, contPoints, rDepth, rLimit)
%Recursively assigns points based on neighboring assignments
%If flag == 0, the point is fresh, 
%           1, the point is set
%           >1, the point belongs to a cluster that may have run into the
%           recusion limit

neighs = NNlist{point};

% Weed out assigned points
if ((flag(point) == 0) || (flag(point) > 1))
    flag(point) = 1;
    
    %Check for cardinal neighbors to see if single point
    xneighs = neighs(abs(neighs - point) == 1);
    yneighs = neighs(abs(neighs - xRange - point) == 0);
    cardneighs = [xneighs yneighs];
    if sum(assignments(cardneighs) == oldClust) == 0;
        flag(point) = -1;
        assignmentsN(point) = -1;

        
    else
        %Group with similar neighbors
        for n = neighs
            if ((assignments(n,1) == oldClust) && (flag(n) == 0))
                flag(n) = newClust;     %Reserve the similar point
                if rDepth < rLimit      %Don't break MATLAB...
                    [assignmentsN flag contPoints] = clustBreaker(assignmentsN, n, assignments, flag, NNlist, oldClust, newClust, xRange, contPoints, rDepth + 1, rLimit);
                    assignmentsN(n,1) = newClust;
                    else
                    contPoints = [contPoints n];
                end
            end
        end
    end
end
end

