function output = Gray_to_Binary_94(input)
    meanValue = mean(mean(input));
    index_1 = find(input > 94);
    index_0 = find(input <= 94);
    output = input;
    output(index_1) = 1;
    output(index_0) = 0;
end

