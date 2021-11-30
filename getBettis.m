% Input matrix : A is a 0,1 matrix
function [beta0, beta1] = getBettis(A)
    % runDIPHA('fil_Fu', A);
    % [dims,b,d] = load_persistence_diagram(['fil_Fu', 'PD']);
    % Output = [dims,b,d];
       %% Replace from DIPHA to Perseus
    cd('Perseus');
        runPerseus('tmp', 1 + int32(A));
        PD0 = load('tmp_0.txt');
        PD1 = load('tmp_1.txt');
    cd ..;
    [m_buff, ~] = size(PD0);
    PD0 = [zeros(m_buff,1),PD0];
    [m_buff, ~] = size(PD1);
    PD1 = [1 + zeros(m_buff,1),PD1];
    Output = int32([PD0; PD1]);
       %%
    beta0 = size(find(Output(:,1) == 0  | Output(:,1) == -1));
    beta0 = beta0(1);
    beta1 = size(find(Output(:,1) == 1));
    beta1 = beta1(1);
end