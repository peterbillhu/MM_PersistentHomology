clc

%% IOU
% Mean
IOU_Mean = [];
IOU_Mean = [IOU_Mean; Noised_mu_IOU];
IOU_Mean = [IOU_Mean; Our_mu_IOU];
IOU_Mean = [IOU_Mean; DNN_mu_IOU];
IOU_Mean = [IOU_Mean; NAMF_mu_IOU];

% Std
IOU_Std = [];
IOU_Std = [IOU_Std; Noised_sigma_IOU];
IOU_Std = [IOU_Std; Our_sigma_IOU];
IOU_Std = [IOU_Std; DNN_sigma_IOU];
IOU_Std = [IOU_Std; NAMF_sigma_IOU];

plot_table_rows(IOU_Mean', IOU_Std', -4);

%% beta_0
% Mean
beta_0_Mean = [];
beta_0_Mean = [beta_0_Mean; Noised_mu_beta_0];
beta_0_Mean = [beta_0_Mean; Our_mu_beta_0];
beta_0_Mean = [beta_0_Mean; DNN_mu_beta_0];
beta_0_Mean = [beta_0_Mean; NAMF_mu_beta_0];

% Std
beta_0_Std = [];
beta_0_Std = [beta_0_Std; Noised_sigma_beta_0];
beta_0_Std = [beta_0_Std; Our_sigma_beta_0];
beta_0_Std = [beta_0_Std; DNN_sigma_beta_0];
beta_0_Std = [beta_0_Std; NAMF_sigma_beta_0];

plot_table_rows(beta_0_Mean', beta_0_Std', -2);

%% beta_1
% Mean
beta_1_Mean = [];
beta_1_Mean = [beta_1_Mean; Noised_mu_beta_1];
beta_1_Mean = [beta_1_Mean; Our_mu_beta_1];
beta_1_Mean = [beta_1_Mean; DNN_mu_beta_1];
beta_1_Mean = [beta_1_Mean; NAMF_mu_beta_1];

% Std
beta_1_Std = [];
beta_1_Std = [beta_1_Std; Noised_sigma_beta_1];
beta_1_Std = [beta_1_Std; Our_sigma_beta_1];
beta_1_Std = [beta_1_Std; DNN_sigma_beta_1];
beta_1_Std = [beta_1_Std; NAMF_sigma_beta_1];

plot_table_rows(beta_1_Mean', beta_1_Std', -2);

%% PSNR
% Mean
PSNR_Mean = [];
PSNR_Mean = [PSNR_Mean; Noised_mu_PSNR];
PSNR_Mean = [PSNR_Mean; Our_mu_PSNR];
PSNR_Mean = [PSNR_Mean; DNN_mu_PSNR];
PSNR_Mean = [PSNR_Mean; NAMF_mu_PSNR];

% Std
PSNR_Std = [];
PSNR_Std = [PSNR_Std; Noised_sigma_PSNR];
PSNR_Std = [PSNR_Std; Our_sigma_PSNR];
PSNR_Std = [PSNR_Std; DNN_sigma_PSNR];
PSNR_Std = [PSNR_Std; NAMF_sigma_PSNR];

plot_table_rows(PSNR_Mean', PSNR_Std', -4);

%% SSIM
% Mean
SSIM_Mean = [];
SSIM_Mean = [SSIM_Mean; Noised_mu_SSIM];
SSIM_Mean = [SSIM_Mean; Our_mu_SSIM];
SSIM_Mean = [SSIM_Mean; DNN_mu_SSIM];
SSIM_Mean = [SSIM_Mean; NAMF_mu_SSIM];

% Std
SSIM_Std = [];
SSIM_Std = [SSIM_Std; Noised_sigma_SSIM];
SSIM_Std = [SSIM_Std; Our_sigma_SSIM];
SSIM_Std = [SSIM_Std; DNN_sigma_SSIM];
SSIM_Std = [SSIM_Std; NAMF_sigma_SSIM];

plot_table_rows(SSIM_Mean', SSIM_Std', -4);