clear
close all
clc

%%
X = load('Iris.csv');
Y = X(:,end);
%X = [X(:,2) X(:,4:5)];
X = X(:,2:5);

[n, d] = size(X);
c = length(unique(Y));

%% Normalization
for i = 1:d
    mi = min(X(:,i));
    ma = max(X(:,i));
    di = ma - mi;
    X(:,i) = 2*(X(:,i)-mi)/di-1;
end

%% Learning and validation
nl = round(.7*n);
nv = n - nl;

err = zeros(10, 1);
for k = 1:30
    i = randperm(n);
    il = sort(i(1:nl));
    iv = sort(i(nl+1:end));
    j = 0;
    
    XL = X(il,:);
    YL = Y(il);
    XV = X(iv,:);
    YV = Y(iv);
    
    for depth = 1:3
        j = j + 1;
        % Learning phase: I create the tree
        T = DT_learn(XL,YL,depth);
        
        % Classification phase
        YS = DT_forw(T,XV);
        err(j) = err(j) + sum(YS ~= YV)/30;
    end
end

% I find the best depth
j = 0;
err_best = Inf;
for depth = 1:3
   j = j + 1;
   if (err(j) < err_best)
      err_best = err(j);
      depth_best = depth;
   end
end

% I re-compute the tree T using the best depth and all data
T = DT_learn(X,Y,depth_best);

% Plotting the dataset
colors = 'bygkcmr';
figure, box on, grid on, hold on
for i = 1:c
    plot3(X(Y==i,1),X(Y==i,2),X(Y==i,3),['o',colors(i)],'MarkerSize',10)
end

% I use the model T with the best depth to plot a lot of points
% to see the lines
ns = 10000;
XS = 2 * rand(ns, d) - 1;
YS = DT_forw(T,XS);
for i = 1:c 
    plot3(XS(YS==i,1),XS(YS==i,2),XS(YS==i,3),['.',colors(i)],'MarkerSize',1)
end

% Print the best depth and the best error on the figure
title(sprintf("Classes: %d      Error_{best}: %e    Depth_{best}: %d", c, err_best, depth_best));