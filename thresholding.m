%% T : thresholding : 0 ~ 255 
%% inputImg : input image
function output = thresholding(inputImg, T)
    
    output = inputImg;
    idx_less_than_T = find(inputImg <= T);
    idx_larger_than_T = find(inputImg > T);
    output(idx_less_than_T) = 0;
    output(idx_larger_than_T) = 1;
    
end