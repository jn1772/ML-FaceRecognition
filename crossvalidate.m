function [accuracy correct total] = crossvalidate(W1, W2, X, Y)  
    n = size(X, 1);
    correct = 0;
    total = n;  
    
    %for each example in training set
        for i = 1:n
            %propagate the input forward through the network
            example = X(i, :);    
            outputH = example*W1'; 
            outputH = [1 sigmoid(outputH)];   
            
            outputO = outputH*W2'; 
            outputO = sigmoid(outputO);  
            
            max = -10e9;maxI = 0;
            for j=1:size(outputO, 2)
                if outputO(j)>max 
                    max = outputO(j); 
                    maxI = j; 
                end
            end
            
            if(Y(i, maxI)==0.9)correct = correct+1;end
        end 
        
        %fprintf('correct = %d total = %d\n', correct, total);
        accuracy = ((correct*100)/total);
        if(accuracy==100)
            for i = 1:n
            %propagate the input forward through the network
            example = X(i, :);   
            outputH = example*W1'; 
            outputH = [1 sigmoid(outputH)];   
            
            outputO = outputH*W2'; 
            outputO = sigmoid(outputO);  
        end
end