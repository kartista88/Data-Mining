clear;
close all;
clc;

%%
% Usinge 2 or more dimensions we use the method of the kernel
% We use 2 dimensions as example but the formulas are general

% 
m = 1000;
n = 100; % samples num.
d = 1; % dimension of problem

sigma = .05; % ANche con molto rumore non è vero che non si può ricostruire:
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
% we use gaussian kernel
% min_w || X w - y ||^2 + lambda ||w||^2
% X = [phi(x_1)';...;phi(x_n)']
% alpha = (Q + lambda I)^{-1} y
% Q_{i,j} = phi(x_i)'*phi(x_j) = exp(gamma*||x_i - x_j||^2) % gaussian kernel
% f(x) = w'phi(x) = sum_{i = 1}^n alpha_i phi(x_i) phi(x)
%                 = sum_{i = 1}^n alpha_i exp(-gamma*||x_i - x||^2)

% Q = zeros(n,n);
% for i = 1:n
%     for j = 1:n
%         tmp = X(i,:)-X(j,:);
%         tmp = tmp * tmp';
%         Q(i,j) = exp(-gamma*tmp);
%     end
% end

% % Codice piùveloce anche se matlab si basa su fortran
% % la parte costosa è : tmp = X(i,:)-X(j,:);
% %                      tmp = tmp * tmp';
% for i = 1:n
%     for j = i:n
%         tmp = X(i,:)-X(j,:);
%         tmp = tmp * tmp';
%         Q(i,j) = exp(-gamma*tmp);
%         Q(j,i) = Q(i,j);
%     end
% end

% Codice non ottimizzato
% YP = zeros(m,1);
% for i = 1:m
%     for j = 1:n
%         % f(xt_i)
%         tmp = XT(i,:) - XT(j,:);
%         tmp = tmp*tmp';
%         YP(i) =  YP(i) + alpha(j)*exp(-gamma*tmp);
%     end
% end

% Codice coretto e ottimizzato
lambda = 0; % High lambda => more flat function low lambda => more complex solution
gamma = .0000000000001; % parametro che aumentando aumenta la non linearità del modello

Q = exp(-gamma*pdist2(X,X)); % O(n^2 * d)
alpha = (Q + lambda*eye(n,n))\Y; % O(n^2) --> comp. is important because i have to solve for many values of lambda and gamma
YP = exp(-gamma*pdist2(XT,X))*alpha; % O(m*n*d)


plot(XT,YP,'r'); % Il grafico anche aumentando gamma non passa da tutti i 
                 % punti a causa della precisione a 64 bit che non è in 
                 % grado di raggiungere tutti i punti
