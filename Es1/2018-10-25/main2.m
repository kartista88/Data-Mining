clear;
close all;
clc;

%%
% Usinge 2 or more we use the method of the kernel
% We use 2 dimensions as example but the formulas are general

% 
m = 1000;
n = 100; % samples num.
d = 1; % dimension of problem

sigma = .1; % Anche con molto rumore non è vero che non si può ricostruire:
% 1 se si conosce la forma del segnale
% 2 se non si conosce la forma del segnale si usano un maggior numero di 
% campioni 

% quando la potenza del rumore è troppo alta gli strumnti che misurano il
% rumore misurano misurerebbero con precisione insufficente il rumore
% rispetto al segnale

XT = linspace(-2*pi,2*pi,m)';
YT = sinc(XT);

X = rand(n,d)*4*pi-2*pi; % I punti sono distribuiti tra -2pi e 2pi
Y = sinc(X) + sigma*randn(n,1);

figure, hold on, box on, grid on;
plot(XT,YT,'g');
plot(X,Y,'ob');

%%
% Usiamo kernel perché caso multidimnsionale i dati non starebbero in
% memoria su un pc
% we use gaussian kernel
% min_w || X w - y ||^2 + lambda ||w||^2
% X = [phi(x_1)';...;phi(x_n)']
% alpha = (Q + lambda I)^{-1} y
% Q_{i,j} = phi(x_i)'*phi(x_j) = exp(gamma*||x_i - x_j||^2) % gaussian kernel
% f(x) = w'phi(x) = sum_{i = 1}^n alpha_i phi(x_i) phi(x)
%                 = sum_{i = 1}^n alpha_i exp(-gamma*||x_i - x||^2)


%%
% loop su lambda e gamma
% cerco le migliori lambda e gamma, vanno splitati i dati e ne uso una
% parte per calcolarle e una parte per verificare 

% validation procedure, slpit the data in learning and validation

nl = round(.7*n); %learning
nv = n - nl;% validation
PD = pdist2(X,X); % la pairwise distance può essere calcolata qui, fuoridai loop
err = zeros(30*30,1); % per ogni lambda e gamma
for k = 1:30
    % scrivendo il loop su k fuori riduco la varinaza che deriverebbe dalla
    % scelta di validatione set e learning set
    % si avrebbe rumore dovuto alla splitting procedure
    % rumore dovuto a i = randperm(n); il = sort(i(1:nl)); iv = sort(i(nl+1:end));
    
%     XL
%     XV
%     YL
%     YV
    i = randperm(n);
    il = sort(i(1:nl));
    iv = sort(i(nl+1:end));
    j = 0;
    for gamma = logspace(-4,3,30)
        QL = exp(-gamma*PD(il,il));
        QV = exp(-gamma*PD(iv,il));
        for lambda = logspace(-4,3,30)
            j = j + 1;
            alpha = (QL+lambda*eye(nl,nl))\Y(il);
            YP = QV*alpha;
            err(j) =  err(j) + mean(abs(YP - Y(iv)))/30;
        end
    end
end

err_best = Inf;
j = 0;
for gamma = logspace(-4,3,30)
    for lambda = logspace(-4,3,30)
        j = j + 1;
        if (err(j) < err_best)
            err_best = err(j);
            gamma_best = gamma;
            lambda_best = lambda;
        end
    end
end


%lambda = lambda_best; % High lambda => more flat function low lambda => more complex solution
%gamma = gamma_best; % parametro che aumentando aumenta la non linearità del modello

Q = exp(-gamma_best*pdist2(X,X)); % O(n^2 * d)
alpha = (Q + lambda_best*eye(n,n))\Y; % O(n^2) --> comp. is important because i have to solve for many values of lambda and gamma
YP = exp(-gamma_best*pdist2(XT,X))*alpha; % O(m*n*d)


plot(XT,YP,'r'); % Il grafico anche aumentando gamma non passa da tutti i 
                 % punti a causa della precisione a 64 bit che non è in 
                 % grado di raggiungere tutti i punti


