clear
close all
clc

%% Leggo i dati
X = load('./NN_Datasets/or_x.txt');
Y = load('./NN_Datasets/or_y.txt');

%% Divido il dataset in LS e VS
nl = round(1 * size(X,1));
i  = randperm(size(X,1));
il = i(1:nl);
iv = i(nl+1:end);

XL = X(il,:);
YL = Y(il);
XV = X(iv,:);
YV = Y(iv);

clear Y nl i il iv

%% Inizializzo i parametri
w = (2*rand(size(XL,2),1)-1)';
w_init = w;
b = 2*rand(1,1)-1;
b_init = b;

%% Learning phase

f = (w*XL')' + b;
err = sum(YL.*f <= 0);

%% Learning loop
it = 0;
i = 1;
while err > 0
    f = w*XL(i,:)' + b;
    if (YL(i)*f <= 0)
        w = w + YL(i)*XL(i,:);
        b = b + YL(i);
        f = (w*XL')' + b;
        err = sum(YL.*f <= 0);
    end
    i = i+1;
    if (i > size(XL,1))
        i = 1;
    end
    it = it + 1
end

%% Validation
fV = (w*XV')' + b;
errV = sum(YV.*fV <= 0);

%% Plot the the 'or' dataset and their linear separator
figure, hold on, grid on
separator = [-b/w(1), -b/w(2)];
% dataset points: class 1 is blue, class -1 is red
plot(XL(YL == 1, 1), XL(YL == 1, 2), 'ob');
plot(XL(YL == -1, 1), XL(YL == -1, 2), 'or');
plot([0,separator(2)],[separator(1),0], 'g');   % separator line
title('OR separator');
xlim([0 1]); ylim([0 1]);                       % axes are limited between 0 and 1






