function [W, Aves, Sig]=setup3D_fast(NNlist, PointsList,cmaha0,numcores)
%A: affinity matrix
%Aves: Quaternion and position values of each point
%Sig: local scaling factor
%z:flag indicating 3D

percentile=0.7;
Aves=zeros(length(NNlist),7);

%% convert points to quaternions
% matlabpool(numcores)
parfor point=1:length(NNlist)
    %make list of quaternions from euler angles stored in raw data
        alpha = PointsList(point,1);
        beta = PointsList(point,2);
        gamma = PointsList(point,3);

            b = -cos((alpha-gamma)./2) .* sin(beta./2);
            c = sin((alpha-gamma)./2) .* sin(beta./2);
            d = -sin((alpha+gamma)./2) .* cos(beta./2);
            a = cos((alpha+gamma)./2) .* cos(beta./2);
            %q = euler2quat(heading,attitude,bank,'bunge')
            Aves(point,:)= [[a,b,c,d]/norm([a,b,c,d]) PointsList(point,4:6)];
end

% normalized rounding
Sig=zeros(length(NNlist),1);

%make local scaling factors   
% % % % parfor point=1:length(NNlist)
% % % %             qA=Aves(point,1:4);
% % % %             NNlistpoint = NNlist{point};
% % % %             listlen=length(NNlistpoint);
% % % %             list=zeros(1,listlen);
% % % %             for m = 1:listlen
% % % %                 k = NNlistpoint(m);
% % % %                 list(m)=qmisbrute_fast(qA,Aves(k,1:4) );
% % % %                 %list(m)=del;
% % % %             end
% % % %             
% % % %             if ~isempty(list)
% % % %                list=sort(list);
% % % %                Sig(point)=list(round(percentile*listlen));
% % % %             end
% % % %             
% % % %          
% % % %             
% % % % %             list=sort(list);
% % % % %             Sig(point)=list(floor(percentile*length(list)));
% % % % %             Sig(point);
% % % % end
 Sig=ones(length(NNlist),1); %Why is this reset? -AL 5/21
% matlabpool close

%allocate memory for A
numNNpts = sum(cellfun(@numel,NNlist)); %total numer of neighbors of all points combined
W = zeros(numNNpts,3);
Aindex = 1;
for point=1:length(NNlist)  
    %make affinity matrix
    qA=Aves(point,1:4);
    for k=NNlist{point}
        del=qmisbrute_fast(qA,Aves(k,1:4) ); %Try using 
        if Sig(point)>1e-10 && Sig(k)>1e-10
            %[~, del, ~]=qmisbrute(qA,Aves(k,1:4) );
            %A(point, k)=...
            %     real(exp(-sp*(del/min(Sig(k),Sig(point)))));
            W(Aindex,:)=[point k real(exp(-cmaha0*(del/min(Sig(k),Sig(point)))))];
            Aindex = Aindex+1;
        %Otherwise, if the distance between them is zero set
        %the affinity to 1.  If neither condition is met the
        %affinity should be zero.
        elseif del<1e-10
            %A(point, k)=1;
            W(Aindex,:)=[point k 1];
            Aindex = Aindex+1;
        end
    end
end
W(Aindex:end,:)=[];

%construct sparse matrix
W = sparse(W(:,1),W(:,2),W(:,3));

% %% visualize sparsity of W
% figure
% spy(W)
% title('sparsity of Winitial')
% 
% %% visualize distribution of W
% [~,~,v]=find(W);
% figure
% hist(v,20)
% title('distribution of Winitial')
