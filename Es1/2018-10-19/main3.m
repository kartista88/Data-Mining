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

% Per rendere più preciso il calcolo dell'errore devo ripetere l'intero
% procedimento più volte
err = zeros(5,6);
for k = 3000
    % Nuovo prolema: trovare il miglior grado del polinomio variando il numero
    % di campioni n
    i1 = 0;
    for n = [3,6,10,15,30]
        i1 = i1 + 1;
        X = rand(n,1);
        Y = X.^2 + sigma*randn(n,1);
        AL = [];
        AT = [];
        i2 = 0;
        for p = 0:5
            i2 = i2 + 1;
            AL = [AL,X.^p]; % L -> learning
            AT = [AT,XT.^p]; % T -> test
            c = (AL'*AL)\(AL'*Y);
            YP = AT*c; % YP -> Y predicted
            err(i1,i2) = err(i1,i2) + mean(abs(YT-YP));
        end
    end
end
err = err / 3000;

for i = 1:size(err,1)
    for j = 1:size(err,2)
        fprintf('%.3e ', err(i,j));
    end
    fprintf('\n');
end





