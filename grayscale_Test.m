%clear; clc;

%% loadImage
A = imread('Bruce_Li_and_Son.jpg');

%% Add Noise
A = rgb2gray(A);
A = imnoise(A,'salt & pepper');

figure
imshow(A);

%% Do thresholding and [o,c] estimations
% figure
Result = zeros(size(A));

for i = 1 : 255

    fprintf('i = %d\n', i);
    Buff = thresholding(A,i);
    Buff = Do_Morphology(Buff, 10, 0.00008);
    Result = Result + double(Buff);
    imshow(Result, []);

end


