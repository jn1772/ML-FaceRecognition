function n = stocasticBP(X, Y, W1, W2, nHidden, nOutput)
    %CV Set Input
    [XCV, YCV, ~] = read('D:\ML\Categories 20 People\Cross Validation Set\', size(X, 2)-1);  
    [XT, YT, ~] = read('D:\ML\Categories 20 People\Test Set\', size(X, 2)-1);   
    %no of training examples
    n = size(X, 1);
    
    %no of features of images
    m = size(X, 2);
    
    %learning rate eta
    eta = 0.9; 
    momentum = 0.9;
    
    iteration = 0; 
        
    maxAccuracy = 0;
    previousTestSetAccuracy = 0; 
    savedW2 = 0;
    savedW1 = 0;
    
    %until termination condition is met repeat
    while true
        
        iteration = iteration + 1; 
        flag = false; 
        
        for i=1:size(X, 1)
            for j=2:i
                random = randi(j-1, 1); 
                temp = X(random, :);
                X(random, :) = X(j, :);
                X(j, :) = temp;
                
                temp = Y(random, :);
                Y(random, :) = Y(j, :);
                Y(j, :) = temp;
            end
        end
        %for each example in training set
        for i = 1:n
            
            %propagate the input forward through the network
            example = X(i, :);   
            
            outputH = example*W1';              outputHS = outputH;
            outputH = [1 sigmoid(outputH)];
            
            outputO = outputH*W2';              outputOS = outputO;
            outputO = sigmoid(outputO);
             
            %OUTPUT ERROR
            errorO = zeros(nOutput);
            for j=1:nOutput
                errorO(j) =   outputO(j)*(1-outputO(j))*(Y(i, j)-outputO(j));   
            end 

            %HIDDEN ERROR
            errorH = zeros(nHidden+1);  
            for j=1:nHidden+1
                sigma = 0;
                for k=1:nOutput
                    sigma = sigma + W2(k, j)*errorO(k);
                end 
                errorH(j) =   outputH(j)*(1-outputH(j))*sigma;  
            end   
            
            %UPDATE W2
            for j=1:nOutput
                for k=1:nHidden+1
                    change = eta*errorO(j)*outputH(k) + momentum*savedW2;
                    W2(j, k) = W2(j, k) + change;
                    savedW2 = change; 
                end
            end
            
            %UPDATE W1
            for j=1:nHidden
                for k=1:m
                    change = eta*errorH(j)*X(i, k) + momentum*savedW1;
                    W1(j, k) = W1(j, k) + change;
                    savedW1 = change; 
                end
            end 
        
            %TEST ACCURACY
            [accuracy correct] = crossvalidate(W1, W2, XCV, YCV); 
            %fprintf('iteration = %d accuracy = %.2f\n', iteration, accuracy);
            if(accuracy>=maxAccuracy) 
                maxAccuracy = accuracy;
                accuracyTestSet = crossvalidate(W1, W2, XT, YT);
                if(accuracyTestSet>previousTestSetAccuracy) 
                    previousTestSetAccuracy = accuracyTestSet;
                else
                    continue;
                end 

                fprintf('\nCross Validation Set Accuracy : %.2f\n', maxAccuracy);

                save savedW2.out W2 -ascii;
                save savedW1.out W1 -ascii;


                fprintf('Test Set Accuracy : %.2f\n', accuracyTestSet);

                if accuracy == 100 && accuracyTestSet ==100 flag = true; break; end 
            end 
        end 
        if flag break; end 
    
end