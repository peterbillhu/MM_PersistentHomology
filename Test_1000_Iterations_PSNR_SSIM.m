clear; clc;

%% loadImage

net = denoisingNetwork('DnCNN');

A = imread('Fu.png');
A = imresize(A,0.5);
A = rgb2gray(A);

%% Gray to Binary
A = Gray_to_Binary(A);
[GT_beta_0, GT_beta_1] = getBettis(A);
imshow(A, []);

for d = 1 : 10
    
    fprintf('d = %f\n', d * 0.1);
    
    density = d * 0.1;
    
    Original_PSNRs = [];
    PSNRs = [];
    DNN_PSNRs = [];
    
    Original_SSIMs = [];
    SSIMs = [];
    DNN_SSIMs = [];
    
    NAMF_IOUs = [];
    NAMF_PSNRs = [];
    NAMF_SSIMs = [];
    NAMF_beta_0s = [];
    NAMF_beta_1s = [];

    %% Add Noise
    for i = 1 : 100
        
        %% Add pepper and salts
        Buff = Add_Salt_Pepper(A, density);
        PSNR = psnr(255 * Buff, 255 * A); 
        Original_PSNRs = [Original_PSNRs, PSNR];
        SSIM = ssim(255 * Buff, 255 * A); 
        Original_SSIMs = [Original_SSIMs, SSIM];
        
        
        %% NAMF
        Buff_4 = NAMF(255 * Buff, 2, 20, 0.8);
        Buff_4_2 = Buff_4;
        idx = find(Buff_4_2 >= 128);
        idx_0 = find(Buff_4_2 < 128);
        Buff_4_2(idx) = 1;
        Buff_4_2(idx_0) = 0;
        IOU_score = IOU(uint8(Buff_4_2), A);
        PSNR = psnr(uint8(Buff_4), 255 * A); 
        SSIM = ssim(uint8(Buff_4), 255 * A);
        [NAMF_beta_0, NAMF_beta_1] = getBettis(Buff_4_2);
        
        NAMF_IOUs = [NAMF_IOUs, IOU_score];
        NAMF_PSNRs = [NAMF_PSNRs, PSNR];
        NAMF_SSIMs = [NAMF_SSIMs, SSIM];
        NAMF_beta_0s = [NAMF_beta_0s, NAMF_beta_0];
        NAMF_beta_1s = [NAMF_beta_1s, NAMF_beta_1];

        %% Do morphology
        Buff_2 = Do_Morphology(Buff, 10, 0.0007);
        %imshow(A, []);
        PSNR = psnr(255 * Buff_2, 255 * A); 
        PSNRs = [PSNRs, PSNR];
        SSIM = ssim(255 * Buff_2, 255 * A); 
        SSIMs = [SSIMs, SSIM];
        
        %% DNN
        Buff_3 = denoiseImage(uint8(255 * int32(Buff)),net);
        idx = find(Buff_3 >= 128);
        idx_0 = find(Buff_3 < 128);
        Buff_3(idx) = 1;
        Buff_3(idx_0) = 0;
        PSNR = psnr(255 * Buff_3, 255 * A); 
        DNN_PSNRs = [DNN_PSNRs; PSNR];        
        SSIM = ssim(255 * Buff_3, 255 * A); 
        DNN_SSIMs = [DNN_SSIMs; SSIM];
        
    end

    old_mu_psnr(d) = mean(Original_PSNRs);
    old_sigma_psnr(d) = std(Original_PSNRs);
    
    old_mu_ssim(d) = mean(Original_SSIMs);
    old_sigma_ssim(d) = std(Original_SSIMs);
    
    DNN_mu_psnr(d) = mean(DNN_PSNRs);
    DNN_sigma_psnr(d) = std(DNN_PSNRs);
    
    DNN_mu_ssim(d) = mean(DNN_SSIMs);
    DNN_sigma_ssim(d) = std(DNN_SSIMs);

    mu_psnr(d) = mean(PSNRs);
    sigma_psnr(d) = std(PSNRs);
    
    mu_ssim(d) = mean(SSIMs);
    sigma_ssim(d) = std(SSIMs);
    
    NAMF_mu_IOU(d) = mean(NAMF_IOUs);
    NAMF_sigma_IOU(d) = std(NAMF_IOUs);
    
    NAMF_mu_PSNR(d) = mean(NAMF_PSNRs);
    NAMF_sigma_PSNR(d) = std(NAMF_PSNRs);
    
    NAMF_mu_SSIM(d) = mean(NAMF_SSIMs);
    NAMF_sigma_SSIM(d) = std(NAMF_SSIMs);
    
    NAMF_mu_beta_0(d) = mean(NAMF_beta_0s);
    NAMF_sigma_beta_0(d) = std(NAMF_beta_0s);
    
    NAMF_mu_beta_1(d) = mean(NAMF_beta_1s);
    NAMF_sigma_beta_1(d) = std(NAMF_beta_1s);
end























