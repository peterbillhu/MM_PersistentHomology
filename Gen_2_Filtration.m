clc; clear;

A = imread('Fu_190_190_Noised.png');
A = rgb2gray(A);

%% Gray to Binary
A = Gray_to_Binary(A);
% imwrite(255 * A,'Bi_Filtration\Fu_190_190_Noised.png');

%% For the opeing part
for o = 1 : 5
    SEo = strel('square', o);
    I = imopen(A, SEo);
    for c = 1 : 5
        SEc = strel('square', c);
        I = imclose(I, SEc); 
        imwrite(255 * I,['Bi_Filtration\Fu_',num2str(c),'_',num2str(o),'.png']);
    end
end