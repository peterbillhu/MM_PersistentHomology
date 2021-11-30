clc;

Buff = mat17woB(:,:,185);
imshow(Buff, []);

%%
Buff = Gray_to_Binary_94(Buff);
runDIPHA('Firn', Buff);
[dims,b,d] = load_persistence_diagram(['Firn', 'PD']);
Output = [dims,b,d];
beta_0 = size(find(Output(:,1) == 0  | Output(:,1) == -1));
beta_0 = beta_0(1);
beta_1 = size(find(Output(:,1) == 1));
beta_1 = beta_1(1);

cd ('Firn_B');
imwrite(uint8(255 * Buff),['original_Firn_South.png']);
cd ..;

%%
Buff_2 = Do_Morphology_Single_Test(Buff, 10, 0.0007);
imshow(Buff_2,[]);
runDIPHA('Firn', Buff_2);
[dims,b,d] = load_persistence_diagram(['Firn', 'PD']);
Output = [dims,b,d];
newbeta_0 = size(find(Output(:,1) == 0  | Output(:,1) == -1));
newbeta_0 = newbeta_0(1);
newbeta_1 = size(find(Output(:,1) == 1));
newbeta_1 = newbeta_1(1);

cd ('Firn_B');
imwrite(uint8(255 * Buff_2),['denoised_Firn_South.png']);
cd ..;