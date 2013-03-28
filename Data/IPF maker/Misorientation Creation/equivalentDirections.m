function [Poles]= equivalentDirections(Direct)
uniqueNum=unique(Direct);
Type=length(uniqueNum);

NumVec=[Direct(1)  Direct(2)  Direct(3);
        -Direct(1) -Direct(2) -Direct(3)];
    
%Step 1 generate all possibilities
N=1;
    for i=1:6
        h=NumVec(i);
        for p=1:6
            k=NumVec(p);
            
            if ((rem(p/2,1)==0 && (p-1)~=i && p~=i)) 
                    for j=1:6
                        if  j~=i && j~=p && rem(j/2,1)==0 && (j-1)~=i && (j-1)~=p
                            l=NumVec(j);
                            PolePos(N,:)=[h k l]; %#ok<AGROW>
                            N=N+1;
                        else if (j+1)~=i && j~=i && j~=p && (j+1)~=p && rem(j/2,1)~=0 
                            l=NumVec(j);
                            PolePos(N,:)=[h k l]; %#ok<AGROW>
                            N=N+1;
                            end
                        end
                    end
            else if (rem(p/2,1)~=0 && (p+1)~=i && p~=i)
                    for j=1:6
                        if  j~=i && j~=p && rem(j/2,1)==0 && (j-1)~=i && (j-1)~=p
                            l=NumVec(j);
                            PolePos(N,:)=[h k l]; %#ok<AGROW>
                            N=N+1;
                        else if (j+1)~=i && j~=i && j~=p && (j+1)~=p && rem(j/2,1)~=0 
                            l=NumVec(j);
                            PolePos(N,:)=[h k l]; %#ok<AGROW>
                            N=N+1;
                            end
                        end
                    end
                end
            end
        end
    end
    %Step 1a Gen only possibilities of interest
    
%Step 2 delete similiar directions
%There are 48 PolePossibilites thus we will make sure that each is unique
N=1;
for i=1:48
    assert=0;
    row=PolePos(i,:);
    for j=(i+1):48
        if row==PolePos(j,:);
            assert=1;
            break
        end
    end
    if assert==0
        Poles(N,:)=row;
        N=N+1;
    end
end
