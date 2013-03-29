%% Break up non-adjecent (Michigan) clusters
rLimit = 802;
set(0,'RecursionLimit',rLimit)
addpath(fullfile('..','MB visual code'))

xrange = length(unique(data(:,4)));
flag = zeros(length(data),1);
assignmentsX = zeros(length(data),1);
for point = 1:length(flag)
    if assignmentsX(point) == 0
        oldClust = assignments(point,1);
        newClust = point;
        if flag(point)>1
            newClust = flag(point);
        end
        assignmentsX(point) = newClust;
        rDepth = 1;

        [assignmentsX flag] = clustBreaker(assignmentsX, point, assignments, flag, LT, oldClust, newClust, xrange, rDepth, rLimit-2);

        
    end
end

assignmentsY = assignments(:,2);
Assignments = [assignmentsX assignmentsY];

hold off;
figure(3);
[clusters M] = plot3assignments(data,Assignments,boundarylist);
view(0,90)