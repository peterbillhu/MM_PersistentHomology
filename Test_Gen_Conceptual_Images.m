clear; clc;

%% loadImage

net = denoisingNetwork('DnCNN');

A = imread('Fu.png');
A = imresize(A,0.5);
A = rgb2gray(A);

%% Gray to Binary
A = Gray_to_Binary(A);

for d = 1 : 10
    
    fprintf('d = %f\n', d * 0.1);
    density = d * 0.1;
    
    %% Add Noise
    for i = 1 : 1
        
        %% Add pepper and salts
        Buff = Add_Salt_Pepper(A, density);
        imwrite(255 * Buff,['Conceptual\Noized_Img_density_',num2str(d),'.png']);
        
        %% DNN
        Buff_3 = denoiseImage(uint8(255 * int32(Buff)),net);
        idx = find(Buff_3 >= 128);
        idx_0 = find(Buff_3 < 128);
        Buff_3(idx) = 1;
        Buff_3(idx_0) = 0;
        imwrite(255 * Buff_3,['Conceptual\DNN_Img_density_',num2str(d),'.png']); 
     
        %% Do morphology
        Buff_2 = Do_Morphology(Buff, 10, 0.0007);
        imwrite(255 * Buff_2,['Conceptual\Ours_Img_density_',num2str(d),'.png']); 
        
        %% AMF
        Buff_4 = AMF(255 * Buff);
        Buff_4_2 = Buff_4;
        idx = find(Buff_4_2 >= 128);
        idx_0 = find(Buff_4_2 < 128);
        Buff_4_2(idx) = 1;
        Buff_4_2(idx_0) = 0;
        imwrite(255 * Buff_4_2,['Conceptual\AMF_Img_density_',num2str(d),'.png']);
        
         %% NAMF
        Buff_4 = NAMF(255 * Buff, 2, 20, 0.8);
        Buff_4_2 = Buff_4;
        idx = find(Buff_4_2 >= 128);
        idx_0 = find(Buff_4_2 < 128);
        Buff_4_2(idx) = 1;
        Buff_4_2(idx_0) = 0;
        imwrite(255 * Buff_4_2,['Conceptual\NAMF_Img_density_',num2str(d),'.png']);        
    end
end























