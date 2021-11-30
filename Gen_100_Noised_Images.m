clear; clc;
SESIZE = 8;
%% loadImage

A = imread('Fu.png');
% A = imresize(A,0.5);
A = rgb2gray(A);

%% Gray to Binary
A = Gray_to_Binary(A);

for d = 1 : 9
    
    % fprintf('d = %f\n', d * 0.001);
    density = d * 0.1;
        %% Add Noise
    for i = 1 : 100
        Buff = Add_Salt_Pepper(A, density);
        imwrite(255 * Buff,['Special_Noise_Imgs\SP_D_',num2str(density),'\IMG_',num2str(i),'.png']);
    end
end

% Special_Fu_Test;





















