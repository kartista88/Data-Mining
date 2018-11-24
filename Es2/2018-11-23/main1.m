clear
close all
clc

%%
% We implement the decision tree
% We start to a binary classification problem
% We extend to multi class classification problem
 
%%
nc = 30;
c = 3;
r = 5;
X = [];
Y = [];
for i = 1:c
    theta = i*(2*pi/c);
    X = [X; randn(nc,1)+r*cos(theta), randn(nc,1)+r*sin(theta)]; %#ok<AGROW>
    Y = [Y; i*ones(nc,1)]; %#ok<AGROW>
end
[n, d] = size(X);
 
%%
% Decision tree sono numerical stable, quindi non è necessario normalizzare
% malo si fa lo stesso
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
    plot(X(Y==i,1),X(Y==i,2),['o',colors(i)],'MarkerSize',10,'linewidth',5)
end

% We haveb to train  the model

depth = 0; % Depth of the tree
T = DT_learn(X,Y,depth);

%%
% We have to classify some points in order to train the separator
ns = 10000;
XS = 2*rand(ns,d)-1;
YS = DT_forw(T,XS);
 
%%
for i = 1:c
    plot(XS(YS==i,1),XS(YS==i,2),['.',colors(i)],'MarkerSize',1)
end

% Dal grafico vediamo che il primo taglio è quello che divide a metà

% go in the uci take medical stuff and run this code

