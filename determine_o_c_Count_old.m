function [o,c] = determine_o_c_Count(mat, ... %% Input binary image
                                     maximal_SE_Card) %% Maximal number of structuring elements
    %% o means most suitable location of opening only filtration
    Target_arrays = [];
    matr = zeros(size(mat));
    for i = 1 : maximal_SE_Card
        se1 = strel('square', i);
        M = imopen(mat, se1);
        matr = matr + double(M);
    end
    
    %     runDIPHA('fil_open', matr);
%     [dims,b,d] = load_persistence_diagram(['fil_open', 'PD']);
%     Output = [dims,b,d];
    %% Replace from DIPHA to Perseus
        cd('Perseus');
            runPerseus('tmp', 1 + int32(matr));
            PD0 = load('tmp_0.txt') - 1;
            PD1 = load('tmp_1.txt') - 1;
        cd ..;
        [m_buff, ~] = size(PD0);
        PD0 = [zeros(m_buff,1),PD0];
        idx_non_infinity = find(PD0(:,3) >= 0);
        PD0 = PD0(idx_non_infinity,:);
        [m_buff, ~] = size(PD1);
        PD1 = [1 + zeros(m_buff,1),PD1];
        Output = int32([PD0; PD1]);
    %%
    
    for i = 1 : maximal_SE_Card
        
        idx_buff = find(Output(:,1) == 1 & Output(:,2) == (i - 1));
        Output_ = Output(idx_buff,:);
        Dimension_1_lifespans = [Output_(:,1), Output_(:,3) - Output_(:,2)];
        
        %% Record target array, each row record the lifespans
        Target_array_Buff = 1 : maximal_SE_Card;
        for k = 1 : maximal_SE_Card
            Target_array_Buff(k) = length(find(Dimension_1_lifespans(:,2) == k));
        end
        Target_arrays = [Target_arrays; Target_array_Buff];
        
    end
    
    Target_arrays = extend_and_shift(Target_arrays);
    [m,n] = size(Target_arrays);
    if (max(Target_arrays(1,:)) == 0)
        o = 1;
    else
        Counting_vec = Target_arrays(1,:);    
        possible_locations = find(Counting_vec ~= 0);
        o = possible_locations(1) + 1;        
    end
        
    %% c means most suitable location of closing only filtration
    Target_arrays = [];
    matr = zeros(size(mat));
    for i = 1 : maximal_SE_Card
        se1 = strel('square', maximal_SE_Card - i + 1);
        M = imclose(mat, se1);
        matr = matr + double(M);
    end
    
    %     runDIPHA('fil_open', matr);
%     [dims,b,d] = load_persistence_diagram(['fil_open', 'PD']);
%     Output = [dims,b,d];
    %% Replace from DIPHA to Perseus
        cd('Perseus');
            runPerseus('tmp', 1 + int32(matr));
            PD0 = load('tmp_0.txt') - 1;
            PD1 = load('tmp_1.txt') - 1;
        cd ..;
        [m_buff, ~] = size(PD0);
        PD0 = [zeros(m_buff,1),PD0];
        idx_non_infinity = find(PD0(:,3) >= 0);
        PD0 = PD0(idx_non_infinity,:);
        [m_buff, ~] = size(PD1);
        PD1 = [1 + zeros(m_buff,1),PD1];
        Output = int32([PD0; PD1]);
    %%
    
    for i = 1 : maximal_SE_Card
        
        idx_buff = find(Output(:,1) == 0 & Output(:,2) == (i-1));
        Output_ = Output(idx_buff,:);
        Dimension_0_lifespans = [Output_(:,1), Output_(:,3) - Output_(:,2)];
        
        %% Record target array, each row record the lifespans
        Target_array_Buff = 1 : maximal_SE_Card;
        for k = 1 : maximal_SE_Card
            Target_array_Buff(k) = length(find(Dimension_0_lifespans(:,2) == k));
        end
        Target_arrays = [Target_arrays; Target_array_Buff];
        
    end
    
    Target_arrays = reverse_extend_and_shift(Target_arrays);
    [m,n] = size(Target_arrays);
    if (m == 0)
        c = 1;
    else
        if(max(Target_arrays(m,:)) == 0)
            c = 1;
        else
            Counting_vec = Target_arrays(m,:);    
            possible_locations = find(Counting_vec ~= 0);
            c = possible_locations(1) + 1;
        end
    end
    
end