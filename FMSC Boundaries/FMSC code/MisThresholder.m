function image=MisThresholder(image, Q, theta)
[rows,cols,z]=size(Q)
for i=2:rows-1
    for j=2:cols-1
        [~, del, ~]=qmisbrute(Q(i,j,:), Q(i-1,j,:));
        [~, del2, ~]=qmisbrute(Q(i,j,:), Q(i+1,j,:));
        [~, del3, ~]=qmisbrute(Q(i,j,:), Q(i,j-1,:));
        [~, del4, ~]=qmisbrute(Q(i,j,:), Q(i,j+1,:));
         if del>theta || del2>theta|| del3>theta||...
             del4>theta
            image(i,j,:)=zeros(1,1,3);
        end
    end
end
imshow(image)