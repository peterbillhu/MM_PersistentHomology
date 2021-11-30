%clear; clc;

%% loadImage
%A = imread('Bruce_Li_and_Son.jpg');
A = kanji;

%% Add Noise
%A = imnoise(A,'salt & pepper');
%A = rgb2gray(A);
figure
imshow(A);

%% Do thresholding and [o,c] estimations
Result = zeros(size(A));

for i = 1 : 255

    Buff = thresholding(A,i);
    
    %%
    Buff = imclose(Buff, sec);

    Result = Do_Morphology(Buff, 20, 0.001);

end

figure
imshow(Result);