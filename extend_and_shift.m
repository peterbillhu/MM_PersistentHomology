function outputMatrix = extend_and_shift(inputMatrix)

[m,n] = size(inputMatrix);
buff = zeros(m,n);
outputMatrix = [inputMatrix, buff];

for i = 1 : m
       
    if (i == 1)
        continue;
    end
    
    buff_2 = outputMatrix(i,1:n);
    outputMatrix(i,:) = 0;
    outputMatrix(i,i : n + i- 1) = buff_2;    
end

outputMatrix = outputMatrix(:,1 : n + 1);

end