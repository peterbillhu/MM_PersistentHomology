%% 
clc; clear;
Idx = 1 : 100;

%%
A = imread('Fu.png');
%A = imresize(A,0.5);
A = rgb2gray(A);

%% Gray to Binary
A = Gray_to_Binary(A); 
   
%%
for i = 1 : length(Idx)
   
    I = imread(['Special_Noise_Imgs\IMG_',num2str(Idx(i)),'.png']);
    I = I(:,:,1);
    Buff = I;
    idx = find(Buff >= 128);
    idx_0 = find(Buff < 128);
    Buff(idx) = 1;
    Buff(idx_0) = 0;
    
    %% Do_Morphology
   Buff_2 = Do_Morphology(Buff, 10, 0.0007);
%    Buff_RGB(:,:,1) = Buff_2;
%    Buff_RGB(:,:,2) = Buff_2;
%    Buff_RGB(:,:,3) = Buff_2;
   
   IOU_scores(i) = IOU(uint8(Buff_2), A);
   [beta_0, beta_1] = getBettis(Buff_2);
   Beta_0s(i) = beta_0;
   Beta_1s(i) = beta_1;
   PSNRs(i) = psnr(255 * Buff_2, 255 * A); 
   SSIMs(i) = ssim(255 * Buff_2, 255 * A);
   
   imwrite(255 * Buff_2, ['Special_Noise_Imgs\DD\Denoized_IMG_',num2str(Idx(i)),'.png']);    
end