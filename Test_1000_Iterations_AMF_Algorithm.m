clear; clc;

%% loadImage

% net = denoisingNetwork('DnCNN');

A = imread('Fu.png');
A = imresize(A,0.5);
A = rgb2gray(A);

%% Gray to Binary
A = Gray_to_Binary(A);
[GT_beta_0, GT_beta_1] = getBettis(A);
% imshow(A, []);

for d = 1 : 10
    
    fprintf('d = %f\n', d * 0.1);
    
    density = d * 0.1;
    
    Noized_IOUs = [];
    Noized_PSNRs = [];
    Noized_SSIMs = [];
    Noized_beta_0s = [];
    Noized_beta_1s = [];
    
    AMF_IOUs = [];
    AMF_PSNRs = [];
    AMF_SSIMs = [];
    AMF_beta_0s = [];
    AMF_beta_1s = [];

    %% Add Noise
    for i = 1 : 100
        
        %% Add pepper and salts
        Buff = Add_Salt_Pepper(A, density);
        IOU_score = IOU(uint8(Buff), A);
        PSNR = psnr(255 * Buff, 255 * A); 
        SSIM = ssim(255 * Buff, 255 * A); 
        [beta_0, beta_1] = getBettis(Buff);
        
        Noized_PSNRs = [Noized_PSNRs, PSNR];
        Noized_SSIMs = [Noized_SSIMs, SSIM];
        Noized_IOUs = [Noized_IOUs, IOU_score];
        Noized_beta_0s = [Noized_beta_0s, beta_0];
        Noized_beta_1s = [Noized_beta_1s, beta_1];
        imwrite(255 * Buff,['Noized_Img_density_',num2str(d),'.png']);
        
        
        %% AMF
        tic
        Buff_4 = AMF(255 * Buff);
        toc
        Buff_4_2 = Buff_4;
        idx = find(Buff_4_2 >= 128);
        idx_0 = find(Buff_4_2 < 128);
        Buff_4_2(idx) = 1;
        Buff_4_2(idx_0) = 0;
        IOU_score = IOU(uint8(Buff_4_2), A);
        PSNR = psnr(uint8(Buff_4), 255 * A); 
        SSIM = ssim(uint8(Buff_4), 255 * A);
        [AMF_beta_0, AMF_beta_1] = getBettis(Buff_4_2);
        
        AMF_IOUs = [AMF_IOUs, IOU_score];
        AMF_PSNRs = [AMF_PSNRs, PSNR];
        AMF_SSIMs = [AMF_SSIMs, SSIM];
        AMF_beta_0s = [AMF_beta_0s, AMF_beta_0];
        AMF_beta_1s = [AMF_beta_1s, AMF_beta_1];
        imwrite(255 * Buff_4_2,['AMF_Img_density_',num2str(d),'.png']);
        
    end

    Noized_mu_IOU(d) = mean(Noized_IOUs);
    Noized_sigma_IOU(d) = std(Noized_IOUs);
    
    Noized_mu_PSNR(d) = mean(Noized_PSNRs);
    Noized_sigma_PSNR(d) = std(Noized_PSNRs);
    
    Noized_mu_SSIM(d) = mean(Noized_SSIMs);
    Noized_sigma_SSIM(d) = std(Noized_SSIMs);
    
    Noized_mu_beta_0(d) = mean(Noized_beta_0s);
    Noized_sigma_beta_0(d) = std(Noized_beta_0s);
    
    Noized_mu_beta_1(d) = mean(Noized_beta_1s);
    Noized_sigma_beta_1(d) = std(Noized_beta_1s);
    
    %
    
    AMF_mu_IOU(d) = mean(AMF_IOUs);
    AMF_sigma_IOU(d) = std(AMF_IOUs);
    
    AMF_mu_PSNR(d) = mean(AMF_PSNRs);
    AMF_sigma_PSNR(d) = std(AMF_PSNRs);
    
    AMF_mu_SSIM(d) = mean(AMF_SSIMs);
    AMF_sigma_SSIM(d) = std(AMF_SSIMs);
    
    AMF_mu_beta_0(d) = mean(AMF_beta_0s);
    AMF_sigma_beta_0(d) = std(AMF_beta_0s);
    
    AMF_mu_beta_1(d) = mean(AMF_beta_1s);
    AMF_sigma_beta_1(d) = std(AMF_beta_1s);
end























