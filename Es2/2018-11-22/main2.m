clear 
close all
clc

% Commento Mauro
%
% epsilon is the precision  
% alpha is the starting point that ha to be inside domain because satisfy box constraint and linear constraint 
% how I can see if the solution is correct 
% 1 plot solution to see if KKT constraint are satisfy 
% the point on support iperplane 
% the where each alpha = C 
% to be sure that all point are corrected classified we have to compute duality gap  
% in particular for points near to margin
 
%%
n = 100;
d = 2;
X = [randn(n/2,d)+2;randn(n/2,d)-2];
Y = [ones(n/2,1);-ones(n/2,1)];

%% Normalizzo
for i = 1:d
    mi = min(X(:,i));
    ma = max(X(:,i));
    di = ma - mi;
    X(:,i) = 2*(X(:,i)-mi)/di-1;
end
 
%%
figure, hold on, box on, grid on
plot(X(Y<0,1),X(Y<0,2),'ob')
plot(X(Y>0,1),X(Y>0,2),'or')

%%
C = 1;
Q = diag(Y)*X*X'*diag(Y);
% min_alpha .5 * alpha' Q alpha - 1 alpha  Q_ij = y_i y_j x'_i x_j
% s.t. y'*alpha = 0, 0 <= alpha <= C
alpha = quadprog(Q,-ones(n,1),[],[],Y',0,zeros(n,1),C*ones(n,1));
w = X'*diag(Y)*alpha;
i = find(alpha > 0+1e-5 | alpha < C-(1e-5)); i = i(1); % Non metto 0 per via della precisione numerica, numri molto piccoli vanno consierati 0
b = Y(i) - w'*X(i,:)';

%%
% Plot the separator
%%
ns = 10000;
XS = 2*rand(ns,d)-1;
YS = XS*w+b;
 
%%
plot(XS(YS<0,1),XS(YS<0,2),'.c','MarkerSize',1)
plot(XS(YS>0,1),XS(YS>0,2),'.m','MarkerSize',1)
plot(XS(YS<-1,1),XS(YS<-1,2),'.b','MarkerSize',1)
plot(XS(YS>+1,1),XS(YS>+1,2),'.r','MarkerSize',1)
% small C -> planes less obliquous
% lasrge C -> i care about have a small error not great margin

%%
% Usiamo algoritmo scritto dal prof
C = 1;
Q = diag(Y)*X*X'*diag(Y);
% Note that in this algo i should have put y'alfa = 0
[~,err,alpha,b] = SMO2_ab(n,Q,-ones(n,1),Y',zeros(n,1),C*ones(n,1)...
                             ,1000000,.0001,zeros(n,1));
if (err ~= 0)
    warning('Problem in SMO');
end
        
w = X'*diag(Y)*alpha;
 
%%
ns = 10000;
XS = 2*rand(ns,d)-1;
YS = XS*w+b;
 
%%
plot(XS(YS<0,1),XS(YS<0,2),'.c','MarkerSize',1)
plot(XS(YS>0,1),XS(YS>0,2),'.m','MarkerSize',1)
plot(XS(YS<-1,1),XS(YS<-1,2),'.b','MarkerSize',1)
plot(XS(YS>+1,1),XS(YS>+1,2),'.r','MarkerSize',1)

%%
% Check the solution
plot(X(alpha==0,1),X(alpha==0,2),'sg','MarkerSize',10,'linewidth',5)
plot(X(alpha>0&alpha<C,1),X(alpha>0&alpha<C,2),'sk','MarkerSize',10,'linewidth',5)
plot(X(alpha==C,1),X(alpha==C,2),'sy','MarkerSize',10,'linewidth',5)

%%
%Compute the duality gap
dualcost = -(.5*alpha'*Q*alpha-ones(n,1)'*alpha);
% .5 |w|^2 + C \sum_i=1^n max(0,1-y_i (w'x_i+b))
primalcost = .5*w'*w+C*sum(max(0,1-diag(Y)*(X*w+b)));
dualitygap = abs(dualcost-primalcost);
title(sprintf('DG: %e', dualitygap));








