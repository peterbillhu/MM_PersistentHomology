function output = Add_Salt_Pepper(input, alpha)
    A = imnoise(input,'salt & pepper',alpha);
    index_255 = find(A == 255);
    A(index_255) = 1;
    output = A;
end
