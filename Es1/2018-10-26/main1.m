clear;
close all;
clc;

%% Real world problem
D = load('wine-red.csv');

%%
% 1 - capire il problema
% spiegare cos'è e come mai può essere svolto in quel modo
% 2 - dati
% gestire categorical feature
% missing values
% numerical problems
% 
% X1 \in [0 - 10^4]
% X2 \in [0 - 10^-4]
% ... + lambda ||w||^2 a causa di questo darei un peso minimo a X2

% quindi normalizzo i dati, prendo il massimo e il minimo 
% ad esempio posso usare normalizzazione tra -1 e 1 (simmetrica, easy to implement, not sensible to outlair)

for i = 1:size(D,2)
    % Normalizzo
    mi = min(D(:,i));
    ma = max(D(:,i));
    di = ma - mi;
    
    if (di > 1e-6) % se di > 0 (numero molto piccolo)
        D(:,i) = 2*(D(:,i) - mi)/di - 1; % normalizzo tra [-1,1]
    else
        D(:,1) = 0;
    end
end
clear i mi ma di

%%
X = D(:,1:end-1);
Y = D(:,end); % ultima colonna quality -> mi dice quanto è buono quel vino con quelle caratteristiche
clear D

%% Controllo dati
% controllo che i dati(siccome questi sono dati dati dalla natura) siano
% gaussiani
% hist(X(:,2),20)
% plot(Y,Y,'ob')
% hist(Y,20)

%% Learning set, validation set, test set
n = size(X,1);
nl = round(.6*n); % learning
nv = round(.2*n); % validation
% nt = n - nl - nv; % training

PD = pdist2(X,X); % la pairwise distance può essere calcolata qui, fuoridai loop
% % err_v = zeros(30*30,1);
% % err_t = zeros(30*30,1);
% % for k = 1:30
% %     i = randperm(n);
% %     il = sort(i(1:nl));
% %     iv = sort(i(nl+1:nl+nv));
% %     it = sort(i(nl+nv+1:end));
% %     j = 0;
% %     for gamma = logspace(-4,3,30)
% %         QLV = exp(-gamma*PD(il,il));
% %         QLT = exp(-gamma*PD([il,iv],[il,iv]));
% %         QV = exp(-gamma*PD(iv,il));
% %         QT = exp(-gamma*PD(it,[il,iv]));
% %         for lambda = logspace(-4,3,30)
% %             j = j + 1;
% %             alpha = (QLV+lambda*eye(nl,nl))\Y(il);
% %             YP = QV*alpha;
% %             err_v(j) = err_v(j) + mean(abs(YP-Y(iv)))/30;
% %             alpha = (QLT+lambda*eye(nl+nv,nl+nv))\Y([il,iv]);
% %             YP = QT*alpha;
% %             err_t(j) = err_t(j) + mean(abs(YP-Y(it)))/30;
% %             fprintf('%d %e %e\n',k,gamma,lambda);
% %         end
% %     end
% % end


% per velocizzare tolgo il ciclo su k
i = randperm(n);
il = sort(i(1:nl));
iv = sort(i(nl+1:nl+nv));
it = sort(i(nl+nv+1:end));
j = 0;
err_best = Inf;
for gamma = logspace(-4,3,30)
    QLV = exp(-gamma*PD(il,il));
    QLT = exp(-gamma*PD([il,iv],[il,iv]));
    QV = exp(-gamma*PD(iv,il));
    QT = exp(-gamma*PD(it,[il,iv]));
    for lambda = logspace(-4,3,30)
        j = j + 1;
        alpha = (QLV+lambda*eye(nl,nl))\Y(il);
        YP = QV*alpha;
        err_v = mean(abs(YP-Y(iv)));
        alpha = (QLT+lambda*eye(nl+nv,nl+nv))\Y([il,iv]);
        YP = QT*alpha;
        err_t = mean(abs(YP-Y(it)));
        fprintf('%d %e %e %e\n',gamma,lambda, err_v, err_t);
        if (err_v < err_best)
            err_best = err_v;
            err_model = err_t;
            gamma_best = gamma;
            lambda_best = lambda;
            YTrue = Y(it);
            YPred = YP;
        end
    end
end

% Plottiamo un diagramma scatter sulle x il vero valore su y quello predetto
% 
figure, box on, grid on, box on
plot(YTrue,YPred,'ob')
title(sprintf('err = %f',err_model))












