clear; clc;

%% loadImage
A = imread('Fu.png');
A = imresize(A,0.5);
A = rgb2gray(A);
Noise_Density = 0.3;

%% Gray to Binary
A = Gray_to_Binary(A);
[GT_beta_0, GT_beta_1] = getBettis(A);
imshow(A, []);

%% Add salts and peppers
Buff = Add_Salt_Pepper(A, Noise_Density);
figure
imshow(Buff, []);

%% Erase the salts and peppers 
Buff_2 = Do_Morphology(Buff, 10, 0.0007);
IOU_score = IOU(uint8(Buff_2), A);
[beta_0, beta_1] = getBettis(Buff_2);
PSNR = psnr(255 * Buff_2, 255 * A);         
SSIM = ssim(255 * Buff_2, 255 * A);

figure
imshow(Buff_2, []);