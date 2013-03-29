%function [Wcoarse, Sal, vnew, P, nextlinks, Avesnew, Qvar]=Coarseninteresting_fast(quatmax, cmaha, W, alpha, links, v, s, Aves, Varin)

%Performs one coarsening step.

%ALL FUNCTIONS WRITTEN AS SCRIPTS TO SAVE MEMORY
%SCRIPTS DO NOT MAKE LOCAL COPIES OF VARIABLeS

%% part 0
% 'coarsen W'
% {'size W' size(W) nnz(W)}
%W = coarsenW_fast(W);
coarsenW_fast;
% {'size W' size(W) nnz(W)}

%% part 1
% 'coarsen 1'
%memory
% toc
%[Celements, F] = coarsen1(W,v,alpha);
coarsen1_NN;
% toc
% {'size W' size(W) nnz(W); ...
%  'size Celements' size(Celements) nnz(Celements); ...
%  'size F' size(F) nnz(F)}

%% part 3
% 'coarsen 2'
%memory
% toc
%P = coarsen2(W,Celements,F,P,blockSize);
coarsen2_fast;
% toc
% {'size W' size(W) nnz(W);...
%  'size P' size(P) nnz(P);...
%  'size Celements' size(Celements) nnz(Celements)}
clear F;

%% part 4
% 'coarsen3'
%memory
% toc
%[Celements, P, F] = coarsen3(W,Celements,F,P,blockSize);
coarsen3_fast;
% toc
% {'size W' size(W) nnz(W);...
%  'size P' size(P) nnz(P);...
%  'size Celements' size(Celements) nnz(Celements)}

%% part 5 **NOT USED
%{
'coarsen4'
memory
toc
gamma = .1;
%P = coarsen4(W,P,gamma);
coarsen4_fast;
toc
[size(W) nnz(W); size(P) nnz(P);...
 size(Celements) nnz(Celements)]
%}

%% part 6 **NOT USED
%{
'coarsen5'
memory
toc
%[Celements, P, F] = coarsen3(W,Celements,F,P,blockSize);
coarsen3_fast;
toc
[size(W) nnz(W); size(P) nnz(P);...
 size(Celements) nnz(Celements)]
%}

%% part 7
% 'coarsen 6'
%memory
% toc
%function P = coarsen6_fast(P,W,links,Aves,Celements)
coarsen6_fast;
% toc
% {'size Wcoarse' size(Wcoarse) nnz(Wcoarse);...
%  'size P' size(P) nnz(P)}
clear Celements; clear Aves;

%% part 10
% 'coarsen7'
%memory
% toc
%Wcoarse = coarsen7(Wcoarse,Avesnew,Qvar,cmaha);
coarsen7_fast;
% {'size Wcoarse' size(Wcoarse) nnz(Wcoarse);...
%  'size P' size(P) nnz(P)}
% toc

%% part11
% 'coarsen 8'
%memory
% toc
%Sal = coarsen8(Wcoarse,nextlinks)
coarsen8;
% toc

