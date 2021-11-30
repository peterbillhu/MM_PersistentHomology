%% inputImg : binary image
function Output = Do_Morphology(inputImg, ...
                                maximalSE_Card, ...
                                defining_capacity)
    %%
    [m, n] = size(inputImg);
    N = m * n * defining_capacity;
    
    %%
    Buff = inputImg;
    for i = 1 : maximalSE_Card
        %%
        [o,c] = determine_o_c_Count_ed(Buff,maximalSE_Card);

        %%
        seo = strel('square', o);
        sec = strel('square', c);
    
        %%
        factor = 0;       
        
        %%
        if (c * c <= N)
            Buff_2 = imdilate(Buff, sec);
%             fprintf([num2str(-1 * (c - 1)), '\n']);
            if (Buff_2 == Buff)
                factor = factor + 1;
            end
            Buff = Buff_2;
        end
        
        %% 
        if (o * o <= N)
            Buff_2 = imerode(Buff, seo);
%             fprintf([num2str(o - 1), '\n']);
            if (Buff_2 == Buff)
                factor = factor + 1;
            end            
            Buff = Buff_2;
        end
        
        %%
        if (factor == 2)
            break;
        end

        %%
        if (c * c > N & o * o > N)
            break;
        end
    end
    
    Output = Buff;
end