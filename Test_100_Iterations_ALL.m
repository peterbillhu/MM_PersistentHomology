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
    
    Noised_IOUs = [];
    Noised_beta_0s = [];
    Noised_beta_1s = [];
    Noised_PSNRs = [];
    Noised_SSIMs = [];
    
    Our_IOUs = [];
    Our_beta_0s = [];
    Our_beta_1s = [];
    Our_PSNRs = [];
    Our_SSIMs = [];
    
    DNN_IOUs = [];
    DNN_beta_0s = [];
    DNN_beta_1s = [];
    DNN_PSNRs = [];
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
        IOU_score = IOU(uint8(Buff), A);
        [beta_0, beta_1] = getBettis(Buff);
        PSNR = psnr(255 * Buff, 255 * A); 
        SSIM = ssim(255 * Buff, 255 * A); 
        
        Noised_IOUs = [Noised_IOUs, IOU_score];
        Noised_PSNRs = [Noised_PSNRs, PSNR];
        Noised_SSIMs = [Noised_SSIMs, SSIM];
        Noised_beta_0s = [Noised_beta_0s, beta_0];
        Noised_beta_1s = [Noised_beta_1s, beta_1];
        
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
        IOU_score = IOU(uint8(Buff_2), A);
        [beta_0, beta_1] = getBettis(Buff_2);
        %imshow(A, []);
        PSNR = psnr(255 * Buff_2, 255 * A);         
        SSIM = ssim(255 * Buff_2, 255 * A); 
        
        Our_IOUs = [Our_IOUs, IOU_score];
        Our_PSNRs = [Our_PSNRs, PSNR];
        Our_SSIMs = [Our_SSIMs, SSIM];
        Our_beta_0s = [Our_beta_0s, beta_0];
        Our_beta_1s = [Our_beta_1s, beta_1];
        
        %% DNN
        Buff_3 = denoiseImage(uint8(255 * int32(Buff)),net);
        idx = find(Buff_3 >= 128);
        idx_0 = find(Buff_3 < 128);
        Buff_3(idx) = 1;
        Buff_3(idx_0) = 0;
        PSNR = psnr(255 * Buff_3, 255 * A); 
        SSIM = ssim(255 * Buff_3, 255 * A); 
        IOU_score = IOU(uint8(Buff_3), A);
        [beta_0, beta_1] = getBettis(Buff_3);
        
        DNN_IOUs = [DNN_IOUs, IOU_score];
        DNN_PSNRs = [DNN_PSNRs; PSNR];        
        DNN_SSIMs = [DNN_SSIMs; SSIM];
        DNN_beta_0s = [DNN_beta_0s, beta_0];
        DNN_beta_1s = [DNN_beta_1s, beta_1];
        
    end

    Noised_mu_IOU(d) = mean(Noised_IOUs);
    Noised_sigma_IOU(d) = std(Noised_IOUs);
    Noised_mu_PSNR(d) = mean(Noised_PSNRs);
    Noised_sigma_PSNR(d) = std(Noised_PSNRs);
    Noised_mu_SSIM(d) = mean(Noised_SSIMs);
    Noised_sigma_SSIM(d) = std(Noised_SSIMs);
    Noised_mu_beta_0(d) = mean(Noised_beta_0s);
    Noised_sigma_beta_0(d) = std(Noised_beta_0s);
    Noised_mu_beta_1(d) = mean(Noised_beta_1s);
    Noised_sigma_beta_1(d) = std(Noised_beta_1s);
    
    Our_mu_IOU(d) = mean(Our_IOUs);
    Our_sigma_IOU(d) = std(Our_IOUs);
    Our_mu_PSNR(d) = mean(Our_PSNRs);
    Our_sigma_PSNR(d) = std(Our_PSNRs);
    Our_mu_SSIM(d) = mean(Our_SSIMs);
    Our_sigma_SSIM(d) = std(Our_SSIMs);
    Our_mu_beta_0(d) = mean(Our_beta_0s);
    Our_sigma_beta_0(d) = std(Our_beta_0s);
    Our_mu_beta_1(d) = mean(Our_beta_1s);
    Our_sigma_beta_1(d) = std(Our_beta_1s);
    
    DNN_mu_IOU(d) = mean(DNN_IOUs);
    DNN_sigma_IOU(d) = std(DNN_IOUs);
    DNN_mu_PSNR(d) = mean(DNN_PSNRs);
    DNN_sigma_PSNR(d) = std(DNN_PSNRs);
    DNN_mu_SSIM(d) = mean(DNN_SSIMs);
    DNN_sigma_SSIM(d) = std(DNN_SSIMs);
    DNN_mu_beta_0(d) = mean(DNN_beta_0s);
    DNN_sigma_beta_0(d) = std(DNN_beta_0s);
    DNN_mu_beta_1(d) = mean(DNN_beta_1s);
    DNN_sigma_beta_1(d) = std(DNN_beta_1s);
    
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























