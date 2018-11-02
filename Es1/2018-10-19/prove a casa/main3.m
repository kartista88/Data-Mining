clear;
close all;
clc;

%%
% Regreassione di una funzione nel caso monodimensionale
% Regressione polinomiale 
% y = x^2 \x in [0,1]

m = 1000;
sigma = 10; % Variance of the noise

XT = linspace(0,1,m)';
YT = XT.^2;

% Per rendere più preciso il calcolo dell'errore devo ripetere l'intero
% procedimento più volte

nValues = [6,10,15,30];
pValues = 0:3;
kIters  = 30;
err = zeros(length(nValues),length(pValues));

for k = 1:kIters
    % prolema: trovare il miglior grado del polinomio variando il numero
    % di campioni n
    i1 = 0;
    for n = nValues
        i1 = i1 + 1;
        X = rand(n,1);
        Y = X.^2 + sigma*randn(n,1); 
        AL = []; % L -> learning
        AT = []; % T -> testing
        i2 = 0;
        for p = pValues
            i2 = i2 + 1;
            AL = [AL, X.^p]; %#ok<AGROW>
            AT = [AT, XT.^p]; %#ok<AGROW>
            c = (AL'*AL)\(AL'*Y);
            YP = AT*c; % YP -> Y predicted
            err(i1,i2) = err(i1,i2) + mean(abs(YT-YP));
        end
    end
end
err = err / kIters;

fprintf('\t\t');
for i = pValues
    fprintf('p = %d\t\t', i);
end
fprintf('\n');

n = nValues;
for i = 1:size(err,1)
    fprintf('n = %d\t', n(i));
    for j = 1:size(err,2)
        fprintf('%.3e\t', err(i,j));
    end
    fprintf('\n');
end

figure, grid on, box on, hold on;
legend;
for i = 1:size(err,1)
    plot(pValues, err(i,:), 'o-', 'DisplayName', sprintf('n=%d',n(i)));
end


