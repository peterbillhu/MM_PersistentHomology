clc; clear;

A = imread('O_190_190_Noised.png');
A = rgb2gray(A);

%% Gray to Binary
A = Gray_to_Binary(A);
imwrite(255 * A,'Toy_Example\O_190_190_Noised.png');

%% For the opeing part
for i  = 1 : 2 : 11
    SE = strel('square',i+1);
    
    I = imopen(A,SE);
    imwrite(255 * I,['Toy_Example\O_190_190_Opening_Filtration_', num2str(i),'.png']);
    
    J = imclose(A,SE);
    imwrite(255 * J,['Toy_Example\O_190_190_Closing_Filtration_', num2str(i),'.png']);    
end