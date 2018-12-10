clear
close all
clc

%% Leggo i dati
X = load('./NN_Datasets/iris_x.txt');
Y = load('./NN_Datasets/iris_y.txt');

% Riduco il dataset Iris classification problem ad un problema di 
% clasificazione binaria.
% -> Le classi 2 e 3 vengono consideratre assieme come una nuova classe -1
Y(Y > 1) = -1;

%% Normalizzazione
% Normalizzazione di X tra 0 e 1
for i = 1:size(X,2)
   % for each feature I compute the max and min value; then I find the line s.t.
   % the normalization is 0 when value = min and 1 when value = max. I use
   % this line to normalize the dataset
   mi = min(X(:,i));                            % min value
   ma = max(X(:,i));                            % max value
   m = 1 / (ma - mi);                           % angular coeff
   q = -m * mi;                                 % constant term
   X(:,i) = m * X(:,i) + q;                     % normalization of a feature
end


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

%% Plot the the 'iris' dataset and their linear separator
figure, hold on, grid on
separator = [-b/w(1), -b/w(2)];
% dataset points: class 1 is blue, class -1 is red
plot(XL(YL == 1, 1), XL(YL == 1, 2), 'ob');
plot(XL(YL == -1, 1), XL(YL == -1, 2), 'or');
plot([0,separator(2)],[separator(1),0], 'g');   % separator line
xlim([0 1]); ylim([0 1]);                       % axes are limited between 0 and 1






