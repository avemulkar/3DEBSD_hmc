clc; clear;
%% coarsen1_NN speed test
a = sprand(100000,1000000,.00005);
f=true(1,1000000);
b = a(1,:);
clear b;

%% method1
tic
[~,ind2] = find(a(1,:));
ans2 = ind2(f(ind2));
sum(a(1,ans2))
toc

clear b;

%% method2
tic
[~,ind1] = find(a(1,f));
sum(a(1,ind1))
toc

clear b

%% method3
tic
sum(a(1,f|a(1,:)>0))
toc

clear b

%% conclusion
%{
method1 is faster than method2 and method 3
if you swap the code so method1 does not executes first,
method1 shows even more improvement over method2 and mothod3
therefore, method 1 is hands down da bes

evaluating the sparserow(indices(booleans(indices))) i.e. method 1
is better than
evaluating the sparserow(indices(sparserows(booleans)))
is btter than
evaluating the sparserow(booleans|indices)
%}