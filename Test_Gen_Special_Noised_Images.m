clear; clc;
SESIZE = 8;
%% loadImage

net = denoisingNetwork('DnCNN');

A = imread('Fu.png');
% A = imresize(A,0.5);
A = rgb2gray(A);

%% Gray to Binary
A = Gray_to_Binary(A);

counter = 1;

for d = 1 : 1
    
    fprintf('d = %f\n', d * 0.001);
    density = d * 0.001;
        %% Add Noise
    for i = 1 : 100
        
%         %% Add big pepper and salts
%         Buff = Add_Big_Salt_Pepper(A, density, SESIZE);
%         Buff = Add_Big_Salt_Pepper(Buff, 0.001, 2);
%         imwrite(255 * Buff,['Special_Noise_Imgs\IMG_',num2str(counter),'.png']);
%         counter = counter + 1;
%         
%         %% Add big salts
%         Buff = Add_Big_Salt(A, density, SESIZE);
%         Buff = Add_Big_Salt_Pepper(Buff, 0.001, 2);
%         imwrite(255 * Buff,['Special_Noise_Imgs\IMG_',num2str(counter),'.png']);
%         counter = counter + 1;
%         
%         %% Add big salts   
%         Buff = Add_Big_Pepper(A, density, SESIZE);
%         Buff = Add_Big_Salt_Pepper(Buff, 0.001, 2);
%         imwrite(255 * Buff,['Special_Noise_Imgs\IMG_',num2str(counter),'.png']);
%         counter = counter + 1;

        %% Add big pepper and salts
        
%         %% For Big Salts and Peppers
%         Buff = Add_Big_Salt(A, density, SESIZE);
%         Buff = Add_Big_Salt(Buff, density, floor(SESIZE / 2));
%         Buff = Add_Big_Salt(Buff, density, floor(SESIZE / 4));
%         Buff = Add_Big_Salt(Buff, density, floor(SESIZE / 8));
%         Buff = Add_Big_Pepper(Buff, density, SESIZE);
%         Buff = Add_Big_Pepper(Buff, density, floor(SESIZE / 2));
%         Buff = Add_Big_Pepper(Buff, density, floor(SESIZE / 4));
%         Buff = Add_Big_Pepper(Buff, density, floor(SESIZE / 8));

%         %% For Big Peppers
%         Buff = Add_Big_Pepper(A, density, SESIZE);
%         Buff = Add_Big_Pepper(Buff, density, floor(SESIZE / 2));
%         Buff = Add_Big_Pepper(Buff, density, floor(SESIZE / 4));
%         Buff = Add_Big_Pepper(Buff, density, floor(SESIZE / 8));

%         %% For Big Salts
%         Buff = Add_Big_Salt(A, density, SESIZE);
%         Buff = Add_Big_Salt(Buff, density, floor(SESIZE / 2));
%         Buff = Add_Big_Salt(Buff, density, floor(SESIZE / 4));
%         Buff = Add_Big_Salt(Buff, density, floor(SESIZE / 8));
        
        Buff = Add_Salt_Pepper(A, 1.0);

        imwrite(255 * Buff,['Special_Noise_Imgs\IMG_',num2str(counter),'.png']);
        counter = counter + 1;

%         %% Add speckle  
%         Buff = Add_Speckle(A, density);
%         imwrite(255 * Buff,['Special_Noise_Imgs\IMG_',num2str(counter),'.png']);
%         counter = counter + 1;
        
               
    end
end

% Special_Fu_Test;





















