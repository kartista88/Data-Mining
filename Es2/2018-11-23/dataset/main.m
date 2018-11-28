clear;
close all;
clc;

% Creazione dataset
dataset = readtable('Iris.csv', 'Delimiter', ',', 'ReadVariableNames', true);
labels = table2array(dataset(:,6));
data = table2array(dataset(:,2:5));
classes = strings(150,1);

for i=1:150
   classes(i) = labels(i); 
end
clear i;

% Visualizzazione distribuzioni
% figure
% histogram(table2array(data(:,1))); title('Sepal length');
% figure
% histogram(table2array(data(:,2))); title('Sepal width');
% figure
% histogram(table2array(data(:,3))); title('Petal length');
% figure
% histogram(table2array(data(:,4))); title('Petal width');

% Voglio classificare solo Iris-setosa e Iris-versicolor
data = data(1:100,:);
classes = classes(1:100);
figure, hold on, box on, grid on
scatter3(data(classes=='Iris-setosa', 1), data(classes=='Iris-setosa', 3), data(classes=='Iris-setosa', 4), 'o');
scatter3(data(classes=='Iris-versicolor', 1), data(classes=='Iris-versicolor', 3), data(classes=='Iris-versicolor', 4), 'o');