function [o,c] = determine_o_c_weights(mat, ... %% Input binary image
                                       maximal_SE_Card) %% Maximal number of structuring elements
    %% o means most suitable location of opening only filtration
    Target_arrays = [];
    for i = 1 : maximal_SE_Card
        matr = zeros(size(mat));
        for j = i : maximal_SE_Card        
            se1 = strel('square', j);
            M = imopen(mat, se1);
            matr = matr + double(M);
        end
        runDIPHA(['fil_' num2str(i)], matr);
        [dims,b,d] = load_persistence_diagram(['fil_' num2str(i) 'PD']);
        Output = [dims,b,d];
        Output_lifspans = [dims, d - b];
        idx_buff = find(Output_lifspans(:,1) == 1);
        Dimension_1_lifespans = Output_lifspans(idx_buff,:);
        
        %% Record target array, each row record the lifespans
        Target_array_Buff = 1 : maximal_SE_Card;
        for k = 1 : maximal_SE_Card
            Target_array_Buff(k) = length(find(Dimension_1_lifespans(:,2) == k));
        end
        Target_arrays = [Target_arrays; Target_array_Buff];
%         
%         subplot(1,3,1)
%         %%hist( d(dims==1), 1:maximal_SE_Card);
%         x_array = 1 : maximal_SE_Card;
%         plot(x_array,Target_array_Buff);
%         subplot(1,3,2)
%         [m,n] = size(Output);
%         if (m > 1)
%             plot_persistence_diagram(['fil_' num2str(i) 'PD'])
%         end
%         subplot(1,3,3)
%         imshow(matr)
    end
    
    [m,n] = size(Target_arrays);
    weights = 1 : n;
    weights = n - weights + 1;
    changes = 1 : m;
    changes(1) = 0;
    for idx = 2 : m
        changes(idx) = max(abs(Target_arrays(idx,:) .* weights...
                               - Target_arrays(idx-1,:) .* weights));
    end
    
    max_changements = max(changes);
    possible_locations = find(changes == max_changements);
    
    o = possible_locations(1);
    
    %% c means most suitable location of closing only filtration
    Target_arrays = [];
    for i = 1 : maximal_SE_Card
        matr = zeros(size(mat));
        for j = i : maximal_SE_Card        
            se1 = strel('square', maximal_SE_Card - j + 1);
            M = imclose(mat, se1);
            matr = matr + double(M);
        end
        runDIPHA(['fil_' num2str(i)], matr);
        [dims,b,d] = load_persistence_diagram(['fil_' num2str(i) 'PD']);
        Output = [dims,b,d];
        Output_lifspans = [dims, d - b];
        idx_buff = find(Output_lifspans(:,1) == 0);
        Dimension_0_lifespans = Output_lifspans(idx_buff,:);
        
        %% Record target array, each row record the lifespans
        Target_array_Buff = 1 : maximal_SE_Card;
        for k = 1 : maximal_SE_Card
            Target_array_Buff(k) = length(find(Dimension_0_lifespans(:,2) == k));
        end
        Target_arrays = [Target_arrays; Target_array_Buff];
    end
    
    [m,n] = size(Target_arrays);
    weights = 1 : n;
    weights = n - weights + 1;
    changes = 1 : m;
    changes(1) = 0;
    for idx = 2 : m
        changes(idx) = max(abs(Target_arrays(idx,:) .* weights...
                           - Target_arrays(idx-1,:) .* weights));
    end
    
    max_changements = max(changes);
    possible_locations = find(changes == max_changements);
    len = length(possible_locations);
    
    c = m - possible_locations(len) + 1;

end