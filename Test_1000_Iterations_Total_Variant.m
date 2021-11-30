clear; clc;

%% loadImage
A = imread('Fu.png');
A = imresize(A,0.5);
A = rgb2gray(A);

%% Gray to Binary
A = Gray_to_Binary(A);

%% Replace from DIPHA to Perseus
cd('Perseus');
    runPerseus('tmp', 1 + int32(A));
    PD0 = load('tmp_0.txt');
    PD1 = load('tmp_1.txt');
cd ..;
[m_buff, ~] = size(PD0);
PD0 = [zeros(m_buff,1),PD0];
[m_buff, ~] = size(PD1);
PD1 = [1 + zeros(m_buff,1),PD1];
Output = int32([PD0; PD1]);
%%
GT_beta_0 = size(find(Output(:,1) == 0  | Output(:,1) == -1));
GT_beta_0 = GT_beta_0(1);
GT_beta_1 = size(find(Output(:,1) == 1));
GT_beta_1 = GT_beta_1(1);

imshow(A, []);

for d = 1 : 10
    
    fprintf('d = %f\n', d * 0.1);
    
    density = d * 0.1;
    
    Original_IOUs = [];
    IOUs = [];
    Method_IOUs = [];
        
    Original_beta_0s = [];
    beta_0s = [];
    Method_beta_0s = [];
    
    Original_beta_1s = [];
    beta_1s = [];
    Method_beta_1s = [];
    

      %% Add Noise
   for i = 1 : 1000
        
              %% Add pepper and salts
        Buff = Add_Salt_Pepper(A, density);
        %imshow(A, []);
        score = IOU(A, Buff);
        Original_IOUs = [Original_IOUs, score];
        
              %% Replace from DIPHA to Perseus
        cd('Perseus');
            runPerseus('tmp', 1 + int32(Buff));
            PD0 = load('tmp_0.txt');
            PD1 = load('tmp_1.txt');
        cd ..;
        [m_buff, ~] = size(PD0);
        PD0 = [zeros(m_buff,1),PD0];
        [m_buff, ~] = size(PD1);
        PD1 = [1 + zeros(m_buff,1),PD1];
        Output = int32([PD0; PD1]);
              %%
        beta_0 = size(find(Output(:,1) == 0 | Output(:,1) == -1));
        beta_0 = beta_0(1);
        beta_1 = size(find(Output(:,1) == 1));
        beta_1 = beta_1(1);
        
        Original_beta_0s = [Original_beta_0s, beta_0];
        Original_beta_1s = [Original_beta_1s, beta_1];        
        
              %% Method
        Buff_3 = TVL1denoise(uint8(255 * int32(Buff)),0.1,100);
        idx = find(Buff_3 >= 128);
        idx_0 = find(Buff_3 < 128);
        Buff_3(idx) = 1;
        Buff_3(idx_0) = 0;
        score = IOU(A, Buff_3);
        Method_IOUs = [Method_IOUs; score];
        
              %% Replace from DIPHA to Perseus
        cd('Perseus');
            runPerseus('tmp', 1 + int32(Buff_3));
            PD0 = load('tmp_0.txt');
            PD1 = load('tmp_1.txt');
        cd ..;
        [m_buff, ~] = size(PD0);
        PD0 = [zeros(m_buff,1),PD0];
        [m_buff, ~] = size(PD1);
        PD1 = [1 + zeros(m_buff,1),PD1];
        Output = int32([PD0; PD1]);
              %%
        beta_0 = size(find(Output(:,1) == 0 | Output(:,1) == -1));
        beta_0 = beta_0(1);
        beta_1 = size(find(Output(:,1) == 1));
        beta_1 = beta_1(1);
        
        Method_beta_0s = [Method_beta_0s, beta_0];
        Method_beta_1s = [Method_beta_1s, beta_1];   
        
    end

    old_mu = mean(Original_IOUs)
    old_sigma = std(Original_IOUs)
    
    Method_mu = mean(Method_IOUs)
    Method_sigma = std(Method_IOUs)

    mu = mean(IOUs)
    sigma = std(IOUs)
    
    original_beta_0_mu = mean(Original_beta_0s)
    original_beta_0_sigma = std(Original_beta_0s)
    
    original_beta_1_mu = mean(Original_beta_1s)
    original_beta_1_sigma = std(Original_beta_1s)
    
    beta_0_mu = mean(beta_0s)
    beta_0_sigma = std(beta_0s)
    
    beta_1_mu = mean(beta_1s)
    beta_1_sigma = std(beta_1s)
    
    Method_beta_0_mu = mean(Method_beta_0s)
    Method_beta_0_sigma = std(Method_beta_0s)
    
    Method_beta_1_mu = mean(Method_beta_1s)
    Method_beta_1_sigma = std(Method_beta_1s)
    
end























