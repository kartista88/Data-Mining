clear;
close all;
clc;

%%
% Regression in monodimensional case
% Polynomial regression
% With regularization
% y = x^2, x \in [0,1]

m = 1000;
n = 30;
p = 8; % Polynom degree
sigma = .05; % Variance of the noise

XT = linspace(0,1,m)';
YT = XT.^2;


X = rand(n,1);
Y = X.^2 + sigma*randn(n,1); % Elevo a potenza ogni elemento della matrice

figure, grid on, box on, hold on;
plot(X,Y,'ob');
plot(XT,YT,'g');

%%
% If lambda is big we don't care about making mistakes (first term) but we just care about making
% simple function that means polynomial of small degree. If lambda is too small we don't care about using a lot of
% coefcients so finding polynomial of high degree, we just care about making small error over data. In other words
% lambda represents my trust over the quality of data: if the quality is good there is small noise respect to the function
% that I'm searching for, so I'm able to fit the data. Else if data is corrupted by noise I cannot trust of minimize
% the error, I can just trust of selecting simple function to not fit the noise.

% Cambiare lambda invece del grado del polinomio consente una maggior
% granularità

% Con più rumore è meglio aumentare lambda ->  nel report mettere questo
% grafico
lambda = .1; % lambda ||c||
A = [];
for i = 0:p
    A = [A, X.^i];
end
c = (A'*A + lambda*eye(size(A'*A)))\(A'*Y);


A = [];
for i = 0:p
    A = [A, XT.^i];
end
YP = A*c; % YP -> Y predicted

err = mean(abs(YT-YP));

plot(XT, YP, 'r');

title(sprintf('err: %e', err))













