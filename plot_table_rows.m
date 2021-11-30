function plot_table_rows(MeanMatrix, StdMatrix, n)
    MeanMatrix = roundn(MeanMatrix,n);
    StdMatrix = roundn(StdMatrix,n);
    [m,n] = size(MeanMatrix);
    
    for i = 1 : m
        row_str = [num2str(0.1 * i), ' & '];
        for j = 1 : n
            row_str = [row_str, num2str(MeanMatrix(i,j)), ' $pm$ ',  num2str(StdMatrix(i,j))];
            if (j < n)
               row_str = [row_str, ' & '];
            end
        end
        fprintf([row_str,'\n']);
    end
end