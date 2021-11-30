%% Given two binary images of the same height and width, compute the Jaccard value
function result = IOU(imageA, imageB)
    intersection = length(find(imageA == 1 & imageB == 1));
    union = length(find(imageA == 1 | imageB == 1));
    result = intersection / union;
end