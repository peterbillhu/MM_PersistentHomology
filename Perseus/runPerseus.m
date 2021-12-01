function runPerseus(fname, mat)
    [n m] = size(mat);
    vec = reshape(mat', [], 1);
    dlmwrite(fname, [2; int32(m); int32(n); int32(vec)],'delimiter','\t');

%        %% IO
%     fileID = fopen(fname,'w');
%     formatSpec = '%u\t\n';
%     fprintf(fileID,formatSpec,2);
%     fprintf(fileID,formatSpec,n);
%     fprintf(fileID,formatSpec,m);
%     formatSpec = '%f\t\n';
%     fprintf(fileID,formatSpec,vec');
%     fclose(fileID);
    
    cmd = ['perseusWin cubtop ' fname ' ' fname '> Output'];
    system(cmd);
end



