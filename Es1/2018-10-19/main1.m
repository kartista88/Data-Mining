clear;
close all;
clc;

%%
% Regression in monodimensional case
% Polynomial regression
% y = x^2, x \in [0,1]

m = 1000;
n = 30;
%d = 1;

sigma = .05; % Variance of the noise

XT = linspace(0,1,m)';
YT = XT.^2;


X = rand(n,1);
Y = X.^2 + sigma*randn(n,1); % Elevo a potenza ogni elemento della matrice

figure, grid on, box on, hold on;
plot(X,Y,'ob');
plot(XT,YT,'g');

%%
p = 8;

A = [];
for i = 0:p
    A = [A, X.^i];
end
% c = (A' A )^+ A'y
c = (A'*A)\(A'*Y);

A = [];
for i = 0:p
    A = [A, XT.^i];
end
YP = A*c; % YP -> Y predicted

err = mean(abs(YT-YP));

plot(XT, YP, 'r');

title(sprintf('err: %e', err))













