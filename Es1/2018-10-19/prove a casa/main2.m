clear;
close all;
clc;

%%
% Regression in monodimensional case
% Polynomial regression
% y = x^2, x \in [0,1]

m = 1000;
sigma = .05; % Variance of the noise

% Definisco la funzione da approssimare
XT = linspace(0,1,m)';
YT = XT.^2;

% Nuovo problema: trovare il miglior grado p per il polinomio di
% regressione variando il numero di campioni
for n = [3,6,10,15,30]
    % Definisco X e Y -> campioni
    X = rand(n,1);
    Y = X.^2 + sigma*randn(n,1);
    
    AL = [];
    for p = 0:5
        AL = [X.^p];
        AT = [XT.^p];
        c = (AL'*AL)\(AL'*Y);
        YP = AT*c; % YP -> Y predicted
        err = mean(abs(YT-YP));
        fprintf('%.3e \t', err);
    end
    fprintf('\n');
end