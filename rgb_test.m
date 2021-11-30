clear; clc;

%% loadImage
A = imread('12188914_1710108625888644_5896274691483044188_n.jpg');
A = imresize(A, 0.3);

%% Add Noise
A = imnoise(A,'salt & pepper',0.2);

figure
imshow(A);

%% Do thresholding and [o,c] estimations
% figure
Result_R = zeros(size(A(:,:,1)));
Result_G = zeros(size(A(:,:,2)));
Result_B = zeros(size(A(:,:,3)));

alpha = 0.0004;

for i = 1 : 255

    fprintf('i = %d\n', i);

    %% R    
    Buff = thresholding(A(:,:,1),i);
    Buff = Do_Morphology(Buff, 10,alpha);
    Result_R = Result_R + double(Buff);
    
    %% G    
    Buff = thresholding(A(:,:,2),i);
    Buff = Do_Morphology(Buff, 10,alpha);
    Result_G = Result_G + double(Buff);

    %% B    
    Buff = thresholding(A(:,:,3),i);
    Buff = Do_Morphology(Buff, 10,alpha);
    Result_B = Result_B + double(Buff);

    rgbImg(:,:,1) = Result_R;
    rgbImg(:,:,2) = Result_G;
    rgbImg(:,:,3) = Result_B;

    rgbImg_gray = (Result_R + Result_G + Result_B) ./ 3;
    rgbImg = uint8(rgbImg);
    imshow(rgbImg_gray,[]);

end

v = VideoWriter('Monalisa.avi');
v.FrameRate = 1;
open(v);
writeVideo(v,F);
close(v)