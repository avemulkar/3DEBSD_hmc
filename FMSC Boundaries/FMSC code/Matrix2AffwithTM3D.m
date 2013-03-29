function A=Matrix2AffwithTM3D(Q)
%This code takes in a 2D or 3D matrix of 
%angles and outputs an Affinity matrix A

%scaling parameter

sp=0.1;

%z determines whether or not the matrix is 2D or 3D
z=0;

%setup the size of A
if length(size(Q))>3
    z=1;
    [Rows, Columns, slices, Qs]=size(Q);
    A=sparse((Rows)*(Columns)*slices,(Rows)*(Columns)*slices);
else
    [Rows, Columns, Qs]=size(Q);
    A=sparse((Rows)*(Columns),(Rows)*(Columns));
end

%Create local scalling factors from Q.
Sigma=Siggen(Q);
%Sigma=ones(length(Q));

for i=1:Rows
    for j=1:Columns
        %3D case
        if z==1
            for k=1:slices
               
                %store the quaternion for current position, qA
                qA1=Q(i,j,k,1);
                qA2=Q(i,j,k,2);
                qA3=Q(i,j,k,3);
                qA4=Q(i,j,k,4);
                %make sure qA is normalized
                qA=[qA1, qA2, qA3, qA4]/norm([qA1, qA2, qA3, qA4]);
                %Create link to the row one lower
                if i>1
                    %store qB of the row below
                    qB1=Q(i-1,j,k,1);
                    qB2=Q(i-1,j,k,2);
                    qB3=Q(i-1,j,k,3);
                    qB4=Q(i-1,j,k,4);
                    %if the Sigma of each point is non-zero,
                    %set the affinity normally
                    [~, del, ~]=qmisbrute(qA, [qB1, qB2, qB3, qB4]);
                    if Sigma(i-1,j,k)>1e-10 && Sigma(i,j,k)>1e-10
                        A(((i-1)*Columns+j-1)*slices+k, ((i-2)*Columns+j-1)*slices+k)=...
                                            exp(-sp*(del/min(Sigma(i-1,j,k),Sigma(i,j,k))));
                    %Otherwise, if the distance between them is zero set
                    %the affinity to 1.  If neither condition is met the
                    %affinity should be zero.
                    elseif del<1e-10
                        A(((i-1)*Columns+j-1)*slices+k, ((i-2)*Columns+j-1)*slices+k)=1;
                    end
                end
                %repeat in each direction.
                if i<Rows
                    qB1=Q(i+1,j,k,1);
                    qB2=Q(i+1,j,k,2);
                    qB3=Q(i+1,j,k,3);
                    qB4=Q(i+1,j,k,4);
                    [~, del, ~]=qmisbrute(qA, [qB1, qB2, qB3, qB4]);
                     if Sigma(i+1,j,k)>1e-10 && Sigma(i,j,k)>1e-10
                        A(((i-1)*Columns+j-1)*slices+k, ((i)*Columns+j-1)*slices+k)=...
                                        exp(-sp*(del/min(Sigma(i+1,j,k),Sigma(i,j,k))));
                     elseif del<1e-10
                       A(((i-1)*Columns+j-1)*slices+k, ((i)*Columns+j-1)*slices+k)=1;
                     end
                end
                if j>1
                    qB1=Q(i,j-1,k,1);
                    qB2=Q(i,j-1,k,2);
                    qB3=Q(i,j-1,k,3);
                    qB4=Q(i,j-1,k,4);
                    if Sigma(i,j-1,k)>1e-10 && Sigma(i,j,k)>1e-10               
                        A(((i-1)*Columns+j-1)*slices+k, ((i-1)*Columns+j-1-1)*slices+k)=...
                                            exp(-sp*(del/min(Sigma(i,j-1,k),Sigma(i,j,k))));
                    elseif del<1e-10
                       A(((i-1)*Columns+j-1)*slices+k, ((i-1)*Columns+j-1-1)*slices+k)=1;
                    end
                end
                if j<Columns
                    qB1=Q(i,j+1,k,1);
                    qB2=Q(i,j+1,k,2);
                    qB3=Q(i,j+1,k,3);
                    qB4=Q(i,j+1,k,4);            
                    if Sigma(i,j+1,k)>1e-10 && Sigma(i,j,k)>1e-10 
                        A(((i-1)*Columns+j-1)*slices+k, ((i-1)*Columns+j-1+1)*slices+k)=...
                                             exp(-sp*(del/min(Sigma(i,j+1,k),Sigma(i,j,k))));
                    elseif del<1e-10
                       A(((i-1)*Columns+j-1)*slices+k, ((i-1)*Columns+j-1+1)*slices+k)=1;
                    end        
                end
                if k>1
                    qB1=Q(i,j,k-1,1);
                    qB2=Q(i,j,k-1,2);
                    qB3=Q(i,j,k-1,3);
                    qB4=Q(i,j,k-1,4);            
                    if Sigma(i,j,k-1)>1e-10 && Sigma(i,j,k)>1e-10 
                        A(((i-1)*Columns+j-1)*slices+k, ((i-1)*Columns+j-1)*slices+k-1)=...
                                             exp(-sp*(del/min(Sigma(i,j,k-1),Sigma(i,j,k))));
                    elseif del<1e-10
                       A(((i-1)*Columns+j-1)*slices+k, ((i-1)*Columns+j-1)*slices+k-1)=1;
                    end        
                end
                if k<slices
                    qB1=Q(i,j,k+1,1);
                    qB2=Q(i,j,k+1,2);
                    qB3=Q(i,j,k+1,3);
                    qB4=Q(i,j,k+1,4);            
                    if Sigma(i,j,k+1)>1e-10 && Sigma(i,j,k)>1e-10 
                        A(((i-1)*Columns+j-1)*slices+k, ((i-1)*Columns+j-1)*slices+k+1)=...
                                             exp(-sp*(del/min(Sigma(i,j,k+1),Sigma(i,j,k))));
                    elseif del<1e-10
                       A(((i-1)*Columns+j-1)*slices+k, ((i-1)*Columns+j-1)*slices+k+1)=1;
                    end        
                end
            end
        %2D case, basically the same as the 3D case
        else
            qA1=Q(i,j,1);
            qA2=Q(i,j,2);
            qA3=Q(i,j,3);
            qA4=Q(i,j,4);
            qA=[qA1, qA2, qA3, qA4]/norm([qA1, qA2, qA3, qA4]);
            
            if i>1
                qB1=Q(i-1,j,1);
                qB2=Q(i-1,j,2);
                qB3=Q(i-1,j,3);
                qB4=Q(i-1,j,4);  
                [~, del, ~]=qmisbrute([qA1, qA2, qA3, qA4], [qB1, qB2, qB3, qB4]/norm([qB1, qB2, qB3, qB4]));
                if Sigma(i-1,j)>1e-10 && Sigma(i,j)>1e-10
                    A((i-1)*Columns+j, (i-2)*Columns+j)=...
                                        exp(-sp*(del/min(Sigma(i-1,j),Sigma(i,j))));
                elseif del<1e-10
                    A((i-1)*Columns+j, (i-2)*Columns+j)=1;
                end
            end
            if i<Rows
                qB1=Q(i+1,j,1);
                qB2=Q(i+1,j,2);
                qB3=Q(i+1,j,3);
                qB4=Q(i+1,j,4);
                [~, del, ~]=qmisbrute(qA, [qB1, qB2, qB3, qB4]);
                 if Sigma(i+1,j)>1e-10 && Sigma(i,j)>1e-10
                    A((i-1)*Columns+j, (i)*Columns+j)=...
                                    exp(-sp*(del/min(Sigma(i+1,j),Sigma(i,j))));
                 elseif del<1e-10
                   A((i-1)*Columns+j, (i)*Columns+j)=1;
                 end
            end

            if j>1
                qB1=Q(i,j-1,1);
                qB2=Q(i,j-1,2);
                qB3=Q(i,j-1,3);
                qB4=Q(i,j-1,4);
                [~, del, ~]=qmisbrute(qA, [qB1, qB2, qB3, qB4]);
                if Sigma(i,j-1)>1e-10 && Sigma(i,j)>1e-10               
                    A((i-1)*Columns+j, (i-1)*Columns+j-1)=...
                                        exp(-sp*(del/min(Sigma(i,j-1),Sigma(i,j))));
                elseif del<1e-10
                   A((i-1)*Columns+j, (i-1)*Columns+j-1)=1;
                end
            end
            if j<Columns
                qB1=Q(i,j+1,1);
                qB2=Q(i,j+1,2);
                qB3=Q(i,j+1,3);
                qB4=Q(i,j+1,4); 
                [~, del, ~]=qmisbrute(qA, [qB1, qB2, qB3, qB4]);
                if Sigma(i,j+1)>1e-10 && Sigma(i,j)>1e-10 
                    A((i-1)*Columns+j, (i-1)*Columns+j+1)=...
                                         exp(-sp*(del/min(Sigma(i,j+1),Sigma(i,j))));
                elseif del<1e-10
                   A((i-1)*Columns+j, (i-1)*Columns+j+1)=1;
                end        
            end
        end
    end
end