clear 
close all
clc
 
%% y = x^2, x \in [0,1]
m = 1000;
n = 10;
sigma = .05;
p = 5;
 
XT = linspace(0,1,m)';
YT = XT.^2;
 
X = rand(n,1);
Y = X.^2 + sigma*randn(n,1);
 
figure, grid on, box on, hold on
xlim([0,1])
ylim([0,1])
plot(X,Y,'ob')
plot(XT,YT,'g')
 
%%
lambda = 0;
A = [];
for i = 0:p
    A = [A, X.^i]; %#ok<AGROW>
end
c = (A'*A+lambda*eye(size(A'*A)))\(A'*Y);
A = [];
for i = 0:p
    A = [A, XT.^i]; %#ok<AGROW>
end
YP = A*c;
 
err = mean(abs(YP-YT));
 
plot(XT,YP,'r')
 
title(sprintf('err: %e',err))