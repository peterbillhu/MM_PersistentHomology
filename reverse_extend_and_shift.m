function outputMatrix = reverse_extend_and_shift(inputMatrix)

[m,n] = size(inputMatrix);
buff = zeros(m,n);
outputMatrix = [inputMatrix, buff];

for i = 0 : m-1
       
    if (i == 0)
        continue;
    end
    
    buff_2 = outputMatrix(m - i,1:n);
    outputMatrix(m - i,:) = 0;
    outputMatrix(m - i, i: n + i- 1) = buff_2;    
end

outputMatrix = outputMatrix(:,1:n + 1);

[m,n] = size(outputMatrix);

if (m > 1)
    while(max(outputMatrix(m,:)) == 0)
       outputMatrix = outputMatrix(1:m-1,:);    
       [m,n] = size(outputMatrix); 
       if (m == 1)
           break;
       end
    end
end

end