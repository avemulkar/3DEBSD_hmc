function [A, rows, cols, slices, filtered, Q,Aves, Sig]=setup(path, Kpasses,z)
%Sets up everything FMC needs to run
if z==1
    [filtered,original]=quaternion_kuwahara3D(path, Kpasses,94);
    filtered=filtered(25:100, 50:135,:);
    [rows, cols, slices, qs]=size(filtered);
    Q=zeros(rows*cols*slices,7,7);
    Aves=zeros(rows*cols*slices,7);
    Sig=zeros(rows*cols*slices,1);
else
    slices=0;
    [~,filtered]=quaternion_kuwahara(path,Kpasses,97);
    filtered=filtered(30:end-10,15:end-30 ,:);
    %filtered=filtered(50:150, 50:250,:);
    [rows, cols, qs]=size(filtered);
    Q=zeros(rows*cols,6,6);
    Aves=zeros(rows*cols,6);
    Sig=zeros(rows*cols,1);
end
%Q is the expected value of Xl*Xm
%Aves are the averages of each point
%Sig is the Sigma at each point

A=abs(Matrix2AffwithTM3D(filtered));


Sigtemp=Siggen(filtered);

for i=1:rows
    for j=1:cols
        if z==0
            %target=[1    -.33   -1    0.33]/norm([1    -.33   -1    0.33]);
            qBrotated=[filtered(i,j,1),filtered(i,j,2),filtered(i,j,3),filtered(i,j,4)];
            Sig((i-1)*cols+j)=Sigtemp(i,j);
            Aves((i-1)*cols+j,:)=[qBrotated/norm(qBrotated),i,j];
            for k=1:6
                for l=1:6
                    Q((i-1)*cols+j,k,l)=Aves((i-1)*cols+j,k)*Aves((i-1)*cols+j,l);
                end
            end
        else
            for k=1:slices
                Sig(((i-1)*cols+j-1)*slices+k)=Sigtemp(i,j,k);
                qBrotated=[filtered(i,j,k,1),filtered(i,j,k,2),filtered(i,j,k,3),filtered(i,j,k,4)];
                Aves(((i-1)*cols+j-1)*slices+k,:)=[qBrotated/norm(qBrotated),i,j,k];
                for l=1:7
                    for m=1:7
                        Q(((i-1)*cols+j-1)*slices+k,l,m)=Aves(((i-1)*cols+j-1)*slices+k,l)*Aves(((i-1)*cols+j-1)*slices+k,m);
                    end
                end
            end
        end
    end
end