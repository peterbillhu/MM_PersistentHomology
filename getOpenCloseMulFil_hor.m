function getOpenCloseMulFil_hor(mat)

matr = zeros(size(mat));

for i = 1:20
    se1 = strel('square', i);
    matr = zeros(size(mat));
    for j = 1:20
        se2 = strel('square', j);
        M = imclose(imopen(mat, se2), se1);
        
        matr = matr + double(M);
    end
    runDIPHA(['fil_' num2str(i)], matr);
    [dims b d] = load_persistence_diagram(['fil_' num2str(i) 'PD']);
    subplot(1,3,1)
    hist( d(dims==0), 1:20);
    subplot(1,3,2)
    plot_persistence_diagram(['fil_' num2str(i) 'PD'])
    subplot(1,3,3)
    imshow(matr)
%     %figure
%     plot_persistence_diagram(['fil_' num2str(i) 'PD'])
    F(i) = getframe(gcf);

end

v = VideoWriter('Kanji_rowPD.avi');
v.FrameRate = 1;
open(v);
writeVideo(v,F);
close(v)

end