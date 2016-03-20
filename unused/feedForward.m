function [EH EO] = feedForward(X, Y, W1, W2) 
    n = 0.3;
    
    outputHLayer = zeros(4, size(X, 1))';         %all zeros initially
    outputHLayer(:, 1) = ones(1, size(X, 1));     %bias is set to 1
     
    ToutputHLayer = X*W1';
    ToutputHLayer = sigmoid(ToutputHLayer);
    
    outputHLayer = [outputHLayer(:, 1) ToutputHLayer];    
    outputOLayer = outputHLayer*W2';
     
    EO = zeros(size(X, 1), 20);
    EH = zeros(size(X, 1), 4);
     
    
    deltaWO = zeros(20, 4);
    deltaWH = zeros(4, size(X, 2));
    
    exampleIndex = 1;
    for i=1:size(outputOLayer, 1)
        input = outputHLayer(i, :);
        for j=1:size(outputOLayer, 2)
            EO(i, j) = outputOLayer(i, j)*(1-outputOLayer(i, j))*(Y(exampleIndex, j)-outputOLayer(i, j));
        end 
        
        for j=1:size(outputOLayer, 2)
            for k=1:size(input, 2)
                deltaWO(j, 1) = deltaWO(j, 1) + n*EO(i, j)*input(1, k);
            end
        end
        exampleIndex = exampleIndex + 1;
    end 
    
    summation = sum(EO*W2, 2);
    
    for i = 1:size(outputHLayer, 1)
        input = X(i, :);
        for j = 1:size(outputHLayer, 2) 
            EH(i, j) = outputHLayer(i, j)*(1-outputHLayer(i, j))*(summation(i)); 
        end
        
        for j=1:size(outputHLayer, 2)
            for k=1:size(input, 2)
                deltaWH (j, 1) = deltaWH(j, 1) + n*EH(i, j)*input(1, k);
            end
        end     
    end   
    
    for i=1:size(W2, 1)
        for j=1:size(W2, 2)
            W2(i, j) = W2(i, j) + deltaWO(
        end
    end
    
end