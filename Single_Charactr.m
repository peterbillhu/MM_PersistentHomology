clear; clc;

%% loadImage

net = denoisingNetwork('DnCNN');

A = imread('Fu.png');
A = imresize(A,0.5);
A = rgb2gray(A);

%% Gray to Binary
A = Gray_to_Binary(A);
imshow(A, []);

density = 0.7;

%% Add pepper and salts
Buff = Add_Salt_Pepper(A, density);
imshow(Buff, []);
imwrite(uint8(255 * Buff),['noised_Fu_density_',num2str(density),'.png']);

Buff_2 = Do_Morphology_Single_Test(Buff, 10, 0.0005);
imshow(Buff_2,[]);
imwrite(uint8(255 * Buff_2),['denoised_Fu_density_',num2str(density),'.png']);