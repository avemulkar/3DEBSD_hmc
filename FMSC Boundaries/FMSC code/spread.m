%function [Pwrite Psize] = spread(Psize,sindex)
%SP-Read

PstorageName = ['Ps' int2str(sindex) '.mat'];
PstorageFolder = 'temp_files';
PstoragePath = [PstorageFolder '\' PstorageName];


P = importdata(PstoragePath);

P = sparse(P(:,1),P(:,2) ,P(:,3),Psize(sindex,1),Psize(sindex,2));

delete(PstoragePath);