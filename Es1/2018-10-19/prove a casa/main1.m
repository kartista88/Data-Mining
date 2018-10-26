clear;
close all;
clc;

%%
% Regreassione di una funzione nel caso monodimensionale
% 
% y = x^2 \x in [0,1]

m = 1000; % Numero di punti sull'asse delle x
n = 10; % Numero di campioni usato

sigma = 0.1; % Varianza del rumore

% Operatore . point wise -> esegue l'operazione per ogni elemento della
% matrice
XT = linspace(0,1,m)'; % XT -> x test : disposizione lineare sull'asse delle x
YT = XT.^2; % YT -> y test : vero valore di y

X = rand(n,1); % Gli n punti sull'asse x dove ho il campione
Y = X.^2 + sigma*randn(n,1); % Gli n campioni con sommato rumore gaussiano

figure, grid on, box on, hold on;
plot(XT,YT,'g'); % Disegno la vera funzione in verde
plot(X,Y,'ob'); % Disegno i campioni come punti

%%

% Costruisco il polinomio regressore

p = 3; % Grado della funzione regressore usata per la stima

A = [];
for i = 0:p
    A = [A, X.^i];
end
c = (A'*A)\(A'*Y);

A = [];
for i = 0:p
    A = [A, XT.^i];
end

% Stimo la funzione
YP = A*c; % YP -> y predicted


err = mean(abs(YT - YP));

plot(XT, YP, 'r'); % Disegno YP in rosso

title(sprintf('err: %e', err))






