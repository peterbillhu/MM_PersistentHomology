function output = Gray_to_Binary_T(input, T)
    meanValue = mean(mean(input));
    index_1 = find(input > T);
    index_0 = find(input <= T);
    output = input;
    output(index_1) = 1;
    output(index_0) = 0;
end

