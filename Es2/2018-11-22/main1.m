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
% Prima di tutto devo trovare che modello usare
% posso usare un classificatore lineare

% I have to define the binary classification problem

% Forward phase
lambda = 1;
W = [];
for i1 = 1:c
    for i2 = i1+1:c
        cp = Y == i1;
        cm = Y == i2;
        all = cp | cm;
        Ytmp = cp*1 + cm*(-1);
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
%figure, box on, grid on, hold on
for i = 1:c
    plot(XS(YS==i,1),XS(YS==i,2),['.',colors(i)],'MarkerSize',1)
end

% Nella figura si vede che i separators passano tutti dall'origine, questo
% perché sono unbiased




















