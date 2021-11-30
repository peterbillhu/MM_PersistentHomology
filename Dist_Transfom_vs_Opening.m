A = imread('Fu.png');
A = imresize(A,0.5);
A = rgb2gray(A);

%% Gray to Binary
A = Gray_to_Binary(A);
[GT_beta_0, GT_beta_1] = getBettis(A);
imwrite(255 * A,'Dist_Filtration\Fu_190_190.png');
% imshow(A, []);

Buff = Add_Salt_Pepper(A, 0.1);
% imshow(Buff, []);
imwrite(255 * Buff,'Dist_Filtration\Original_Img.png');

Dist_Map = bwdist(Buff);
imshow(Dist_Map, []);

% imread('Dist_Filtration\Dist_Map_.png');
% J = ans(:,:,1);
% J = J(30:30 + 189,87:87 + 189,:);
% imshow(J)
% imwrite(J,'Dist_Filtration\Dist_Map.png');

max_value = max(max(Dist_Map));
min_value = min(min(Dist_Map));

num_steps = 10;
step = (max_value - min_value) / num_steps;
for i = 1 : num_steps
    T = i * step;
    I = Gray_to_Binary_T(Dist_Map, T);
    imwrite(255 * I,['Dist_Filtration\Img_Dist_Filtration_', num2str(i),'.png']);
end

%% For the opeing part
for i  = 1 : num_steps
    SE = strel('square',i);
    I = imopen(Buff,SE);
    imwrite(255 * I,['Opening\Img_Opening_Filtration_', num2str(i),'.png']);
end