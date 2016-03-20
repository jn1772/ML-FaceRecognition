function output = tanhUnit(input)
    output = size(input);
    for i=1:size(input, 1)
        for j=1:size(input, 2)
            output(i, j) = tanh(input(i, j));
        end
    end
end