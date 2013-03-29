%function [Pwrite Psize] = spwrite(P,s)

PstorageName = ['Ps' int2str(s) '.mat'];
PstorageFolder = 'temp_files';
PstoragePath = [PstorageFolder '\' PstorageName];

Psize(s,:) = size(P);

[Prow Pcol Pval] = find(P); clear P;
Pwrite = [Prow Pcol Pval]; clear Prow; clear Pcol; clear Pval;

[success,message,messageID] = mkdir(PstorageFolder);

if ~success
warning('failed to create temp folder for P')
end

save(PstoragePath,'Pwrite'); clear Pwrite;