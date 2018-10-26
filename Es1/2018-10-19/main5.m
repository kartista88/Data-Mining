clear;
close all;
clc;

%%
imm = imread('download.jpg', 'jpg');
imagesc(imm);
imm = rgb2gray(imm);
imagesc(imm);
colormap gray;

[U,S,V] = svd(double(imm));

S(50:end,50:end) = 0;

imm = U*S*V';
imagesc(imm);