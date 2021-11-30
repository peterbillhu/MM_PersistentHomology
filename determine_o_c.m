function [o,c] = determine_o_c(mat, ... %% Input binary image
                               maximal_SE_Card, iterNum) %% Maximal number of structuring elements
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
            PD0 = load('tmp_0.txt');
            PD1 = load('tmp_1.txt');
        cd ..;
        [m_buff, ~] = size(PD0);
        PD0 = [zeros(m_buff,1),PD0];
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
    changes = 1 : m;
    changes(1) = 0;
    for idx = 2 : m
        changes(idx) = max(abs(Target_arrays(idx,:)...
                             - Target_arrays(idx-1,:)));
    end
    
    max_changements = max(changes);
    possible_locations = find(changes == max_changements);
    
    o = possible_locations(1);
    
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
            PD0 = load('tmp_0.txt');
            PD1 = load('tmp_1.txt');
        cd ..;
        [m_buff, ~] = size(PD0);
        PD0 = [zeros(m_buff,1),PD0];
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
    changes = 1 : m;
    changes(1) = 0;
    for idx = 2 : m
        changes(idx) = max(abs(Target_arrays(idx,:)...
                           - Target_arrays(idx-1,:)));
    end
    
    max_changements = max(changes);
    possible_locations = find(changes == max_changements);
    len = length(possible_locations);
                                                                                                                                                                                
    c = m - possible_locations(len) + 1 + 1;
end