%% Given a gray-scale image, generate its PDs
function [PD0,PD1] = gen_PD_from_img(ImageName)
    I = imread(ImageName);
    Buff = size(I);
    if length(Buff) > 2
       fprintf('The function is only for gray-scale image with single channel');
       PD0 = [-1,-1];
       PD1 = [-1,-1];
       return;
    end
    cd('Perseus');
       runPerseus('tmp', 1 + int32(I));
       PD0 = load('tmp_0.txt') - 1;
       PD1 = load('tmp_1.txt') - 1;
       figure;
       PD0_Diagram = persdia('tmp_0.txt');
       figure;
       PD1_Diagram = persdia('tmp_1.txt');
    cd ..;
end