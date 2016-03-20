function output = sigmoid(input) 
    output = zeros(size(input));
    for i=1:size(input, 1)
        for j=1:size(input, 2)
            expt = exp(-input(i, j));
            output(i, j) = 1/(1+expt);
        end
    end 
end