clear;
close all;
clc;

%%
% Regression in monodimensional case
% Polynomial regression
% y = x^2, x \in [0,1]

m = 1000;
sigma = .05; % Variance of the noise

XT = linspace(0,1,m)';
YT = XT.^2;

% Nuovo prolema: trovare il miglior grado del polinomio variando il numero
% di campioni n
for n = [3,6,10,15,30]
    X = rand(n,1);
    Y = X.^2 + sigma*randn(n,1);
    AL = [];
    for p = 0:5
        AL = [X.^p]; % L -> learning
        AT = [XT.^p]; % T -> test
        c = (AL'*AL)\(AL'*Y);
        YP = AT*c; % YP -> Y predicted
        err = mean(abs(YT-YP));
        fprintf('%.3e \t', err);
    end
    fprintf('\n');
end
