%Convert a set of euler angles contained in the raw data
%   to ipf positional information

function ipfConversion(N)

%Step 1 state loop and read in first image
for q=1:N
    q
    path    =['scanHPos', int2str(q), '.txt'];
    Data=importfile(path);
    ipfData=ipfPlotter(Data);
    clear Data %delete giant text file from memory
    clear path
%Step 2 create new text file with ipfData
    
    path   =['ipf', int2str(q), '.txt'];
    
    fid = fopen(path, 'wt'); % Open for writing
    for i=1:(numel(ipfData)/5)
        fprintf(fid, '  %7.5f   %7.5f   %7.5f      %7.5f      %7.5f  \n', ipfData(i,:) );
    end
    fclose(fid);
    
    clear path
    clear ipfData
    clear Data
end