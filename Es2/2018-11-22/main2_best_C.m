clear 
close all
clc

n = 100;
d = 2;
X = [randn(n/2,d)+2;randn(n/2,d)-2];
Y = [ones(n/2,1);-ones(n/2,1)];

for i = 1:d
    mi = min(X(:,i));
    ma = max(X(:,i));
    di = ma - mi;
    X(:,i) = 2*(X(:,i)-mi)/di-1;
end

figure, hold on, box on, grid on
plot(X(Y<0,1),X(Y<0,2),'ob','MarkerSize',10)
plot(X(Y>0,1),X(Y>0,2),'or','MarkerSize',10)

index_best = 0;
i = 0;
max_alpha_null = 0;
w_best = [];
for C = logspace(-4,3,30)
    i = i + 1;
    Q = diag(Y)*(X*X')*diag(Y);
    
    [~,err,alpha,b] = SMO2_ab(n,Q,-ones(n,1),Y',zeros(n,1),C*ones(n,1),...
                              1000000,.0001,zeros(n,1));
    if (err ~= 0)
        warning('Problem in SMO')
    end
    w = X'*diag(Y)*alpha;
    
    if(length(alpha(alpha==0)) > max_alpha_null)
        max_alpha_null = length(alpha(alpha==0));
        index_best = i;
        w_best = w;
    end
    
end

C_best = logspace(-4,3,30);
C_best = C_best(index_best);
C_best

%%
% Plot the separator
ns = 10000;
XS = 2*rand(ns,d)-1;
YS = XS*w_best+b;

%%
plot(XS(YS<0,1),XS(YS<0,2),'.c','MarkerSize',1)
plot(XS(YS>0,1),XS(YS>0,2),'.m','MarkerSize',1)
plot(XS(YS<-1,1),XS(YS<-1,2),'.b','MarkerSize',1)
plot(XS(YS>+1,1),XS(YS>+1,2),'.r','MarkerSize',1)

%%
% Check the solution
plot(X(alpha==0,1),X(alpha==0,2),'sg','MarkerSize',10)
plot(X(alpha>0&alpha<C_best,1),X(alpha>0&alpha<C_best,2),'sk','MarkerSize',10)
plot(X(alpha==C_best,1),X(alpha==C_best,2),'sy','MarkerSize',10)

%%
% Compute the duality gap
dualcost = -(.5*alpha'*Q*alpha-ones(n,1)'*alpha);
% .5 |w|^2 + C \sum_i=1^n max(0,1-y_i (w'x_i+b))
primalcost = .5*w_best'*w_best+C_best*sum(max(0,1-diag(Y)*(X*w+b))); 
dualitygap = abs(dualcost-primalcost);
title(sprintf('DG: %e   C_{best}: %e',dualitygap,C_best))