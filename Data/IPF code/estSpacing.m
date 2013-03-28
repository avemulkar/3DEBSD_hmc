function [spacing newavg] = estSpacing(v)
% estimates the discrete spacing of a vector with noise

vDiff = diff(v);
vDiff(vDiff<0) = [];
avg = mean(vDiff);
stdev = std(vDiff);

outliers  = (vDiff>avg+2*stdev)|(vDiff<avg-2*stdev);
vDiff(outliers) = [];
newavg = mean(vDiff);

spacing = roundsd(newavg,1);

if spacing == .09
    spacing = .1;
end

%sprintf(['   mean spacing: %g\n'...
%         'assumed spacing: %g'],newavg,spacing)