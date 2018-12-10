clear
close all
clc

%% Leggo i dati
X = load('./NN_Datasets/face_x.txt');
Y = load('./NN_Datasets/face_y.txt');

%% Divido il dataset in LS e VS
nl = round(.5 * size(X,1));
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
err = sum(YV.*fV <= 0);

%% Show the weigths as image
figure
subplot(1,2,1);
imshow(mat2gray(reshape(abs(w'), [60,60])')); title('ABS');
subplot(1,2,2);
imshow(mat2gray(reshape(w', [60,60])')); title('No ABS');

%% Plot a face
figure
subplot(1,2,1);
imshow(mat2gray(reshape(X(1,:), [60,60])')); title('Male');
subplot(1,2,2);
imshow(mat2gray(reshape(X(2,:), [60,60])')); title('Female');




