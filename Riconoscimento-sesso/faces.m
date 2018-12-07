clear
close all
clc

%% Leggo i dati
X = load('./NN_Datasets/face_x.txt');
Y = load('./NN_Datasets/face_y.txt');

prova = reshape(X(3,:),[60,60])';
I = mat2gray(prova);
imshow(I)

%% Inizializzo i parametri
w = (2*rand(size(X,2),1)-1)';
b = 2*rand(1,1)-1;

%% Algoritmo
err = 0;
for j=1:size(Y)
    f = w*X(j,:)' + b;
    if (Y(j)*f <= 0)
        err = err + 1;
    end    
end

%%
i = 1;
while (err > 0)
    f = w*X(i,:)' + b;
    if (Y(i)*f <= 0)
        w = w + Y(i)*X(i,:);
        b = b + Y(i);
        err = 0;
        for j=1:size(Y)
            f = w*X(j,:)' + b;
            if (Y(j)*f <= 0)
                err = err + 1;
            end
        end
    end
    i = i+1;
    if (i > size(Y))
        i = 1;
    end
end

res = zeros(size(Y));
for i = 1:size(Y)
    f = w*X(i,:)' + b;
    if (f>=0)
        res(i) = 1;
    else
        res(i) = -1;
    end
end




