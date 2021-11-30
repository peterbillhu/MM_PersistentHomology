function output = Gray_to_Binary(input)
    meanValue = mean(mean(input));
    index_1 = find(input > meanValue);
    index_0 = find(input <= meanValue);
    output = input;
    output(index_1) = 1;
    output(index_0) = 0;
end

