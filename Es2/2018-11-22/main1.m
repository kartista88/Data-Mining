clear
close all
clc

%%
% We want to find a separator for the classes
nc = 30;
c = 7; % Number of classes
r = 5;
X = [];
Y = [];

% Cloud of points on a circle
for i = 1:c
    theta = i*(2*pi/c); % Angle in which we put our cloud of points
    X = [X; randn(nc,1) + r*cos(theta), randn(nc,1) + r*sin(theta)]; %#ok<AGROW>
    Y = [Y; i*ones(nc,1)]; %#ok<AGROW>
end
[n, d] = size(X);

%% Normalizzo i dati
for i = 1:d
    mi = min(X(:,i));
    ma = max(X(:,i));
    di = ma - mi;
    X(:,i) = 2*(X(:,i)-mi)/di-1; %#ok<SAGROW>
end

%%
colors = 'rbcmkyg';
figure, box on, grid on, hold on


for i = 1:c
    plot(X(Y==i,1), X(Y==i,2), ['o', colors(i)])
end

%% 
% Multi class classifier
% I have to use 1-vs-all, all-vs-all, ... binary
% --> The most effective is all-vs-all
% Prima di tutto devo trovare che modello usare
% posso usare un classificatore lineare perchè il problema è lineare

% I have to define the binary classification problem

% Forward phase
lambda = 1; % Regularization term
% Devo definire tutti i problemi che sono c*(c-1)/2
W = [];

% Definisco con 2 cicli il problema
% Nel ciclo esterno indico la classe che si scontra con le altre, in quello
% interno le altre classi

% La prima volta devo definire 1 against 2, 1 against 3 ...
% Poi definisco 2 against 3, 2 against 4,...
% ma non devo ridefinre 2 against 1
%  Specifico che 1 against 1 non avrebbe senso
for i1 = 1:c
    for i2 = i1+1:c
        % cp e cm sono le due classi
        % sort of mask that specifies which indexes belong to which class
        % All points are cp | cm
        cp = Y == i1;
        cm = Y == i2;
        all = cp | cm;
        Ytmp = cp*1 + cm*(-1); % Ytmp = 0 everywhere where the class is not i1 or i2 and Ytmp = {1 se Y=i1; -1 se Y=i2}
        W = [W, (X(all,:)'*X(all,:)+lambda*eye(d))\(X(all,:)'*Ytmp(all))]; %#ok<AGROW>
    end
end

%%
ns = 10000;
XS = 2*rand(ns,d)-1;
YS = zeros(ns,c*(c-1)/2);
i3 = 0;
for i1 = 1:c
    for i2 = i1+1:c
        i3 = i3 + 1;
        YS(:,i3) = XS*W(:,i3);
        YS(:,i3) = (YS(:,i3)>=0)*i1+(YS(:,i3)<0)*i2;
    end
end
YS = mode(YS,2); % Moda di YS sulla dimensione 2

%%
for i = 1:c
    plot(XS(YS==i,1),XS(YS==i,2),['.',colors(i)],'MarkerSize',1)
end

% Nella figura si vede che i separators passano tutti dall'origine, questo
% perché sono unbiased




















