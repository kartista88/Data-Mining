clear;
close all;
clc;

%%
% Reagressione nel caso monodimensionale
% Regressore polinomiale
%
% y = x^2 \[0,1]

m = 1000; % Numero di punti sull'asse delle x


% Operatore . point wise -> esegue l'operazione per ogni elemento della
% matrice
XT = linspace(0,1,m)'; % XT -> x test : disposizione lineare sull'asse delle x
YT = XT.^2; % YT -> y test : vero valore di y


% % figure, grid on, box on, hold on;
% % plot(X,Y,'ob');
% % plot(XT,YT,'g');

% In questo caso faccio uso di un bias -> lambda
%
% If lambda is big we don't care about making mistakes (first term) but we just care about making
% simple function that means polynomial of small degree. If lambda is too small we don't care about using a lot of
% coefcients so finding polynomial of high degree, we just care about making small error over data. In other words
% lambda represents my trust over the quality of data: if the quality is good there is small noise respect to the function
% that I'm searching for, so I'm able to fit the data. Else if data is corrupted by noise I cannot trust of minimize
% the error, I can just trust of selecting simple function to not fit the noise.
%
% Cambiare lambda invece del grado del polinomio consente una maggior
% granularità

% Con più rumore è meglio aumentare lambda ->  nel report mettere questo
% grafico

% Provo per più valori di n
lambda = 1;
sigma = 0.05; % Varianza del rumore

nValues = [3 6 10 15 30];
pValues = 0:5;
iterations = 30;
err = zeros(length(nValues), length(pValues));
for k = 1:iterations
    i1 = 0;
    for n = nValues
        i1 = i1 + 1;
        X = rand(n,1);
        Y = X.^2 + sigma*randn(n,1);
        i2 = 0;
        for p = pValues
            i2 = i2 + 1;
            AL = [];
            AT = [];
            AL = [AL,X.^p];
            AT = [AT,XT.^p];
            c = ((AL'*AL)+ lambda*eye(size(AL'*AL)))\(AL'*Y);
            YP = AT*c;
            err(i1,i2) = err(i1,i2) + mean(abs(YT-YP));
        end
    end
end
err = err/iterations;

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
