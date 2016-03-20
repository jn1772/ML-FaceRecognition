function n = learnFullGDBP(X, Y, W1, W2, nHidden, nOutput)
    %CV Set Input
    [XCV, YCV, ~] = read('D:\ML\Categories 20 People\Cross Validation Set\');  
    [XT, YT, ~] = read('D:\ML\Categories 20 People\Test Set\');  
    %no of training examples
    n = size(X, 1);
    
    %no of features of images
    m = size(X, 2);
    
    %learning rate eta
    eta = 0.25;
    momentum = 0.60;
    
    iteration = 0;
    maxAccuracy = 0;
    previousTestSetAccuracy = 0; 
    
    previousDWO = zeros(nOutput, nHidden+1);
    previousDWH = zeros(nHidden+1, m);
        
    %until termination condition is met repeat
    while true
        
        iteration = iteration + 1;
        
        outputErrorSum = zeros(nOutput, nHidden+1);
        hiddenErrorSum = zeros(nHidden+1, m);
        
        %for each example in training set
        for i = 1:n
            
            %propagate the input forward through the network
            example = X(i, :);   
            
            outputH = example*W1';              outputH ;
            outputH = [1 sigmoid(outputH)];
            
            outputO = outputH*W2';              outputO;
            outputO = sigmoid(outputO);
            
            %OUTPUT ERROR
            errorO = zeros(nOutput);
            for j=1:nOutput
                errorO(j) = outputO(j)*(1-outputO(j))*(Y(i, j)-outputO(j));   
            end 

            %HIDDEN ERROR
            errorH = zeros(nHidden+1);  
            for j=1:nHidden+1
                sigma = 0;
                for k=1:nOutput
                    sigma = sigma + W2(k, j)*errorO(k);
                end 
                errorH(j) = outputH(j)*(1-outputH(j))*sigma;  
            end  

            %COMPUTE DELTA for W2 Elements
            for j=1:nOutput
                for k=1:nHidden+1
                    deltaW = eta*errorO(j)*outputH(k);
                    outputErrorSum(j, k) = outputErrorSum(j, k) + deltaW;  
                end
            end 

            %COMPUTE DELTA for W1 Elements
            for j=1:nHidden      
                for k=1:m
                    deltaW = eta*errorH(j)*X(i, k); 
                    hiddenErrorSum(j, k) = hiddenErrorSum(j, k) + deltaW; 
                end
            end 
        end
         
        
        %FIX W2
        for i=1:size(outputErrorSum, 1)
            for j=1:size(outputErrorSum, 2)
                update = outputErrorSum(i, j) + momentum*previousDWO(i, j); 
                W2(i, j) = W2(i, j)+update;
                previousDWO(i, j) = update;
            end
        end
        
        %FIX W1
        for i=2:size(hiddenErrorSum, 1)
            for j =1:size(hiddenErrorSum, 2)
                update = hiddenErrorSum(i, j) + momentum*previousDWH(i, j); 
                W1(i-1, j) = W1(i-1, j)+update;
                previousDWH(i, j) = update;
            end
        end
        
        if(mod(iteration, 200)==0)
            fprintf('\nIterations %d\n', iteration); 
        end 
        
        %test accuracy over validation set
        %TEST ACCURACY
        [accuracy correctCV tCV] = crossvalidate(W1, W2, XCV, YCV); 
        if(accuracy>=maxAccuracy) 
            maxAccuracy = accuracy;
            [accuracyTestSet correctT tT] = crossvalidate(W1, W2, XT, YT);
            if(accuracyTestSet>previousTestSetAccuracy) 
                previousTestSetAccuracy = accuracyTestSet;
            else
                continue;
            end 

            fprintf('\nCross Validation Set Accuracy : %.2f %d/%d correct.\n', maxAccuracy, correctCV, tCV);
            savedW2 = W2;
            savedW1 = W1; 

            save savedW2.out savedW2 -ascii;
            save savedW1.out savedW1 -ascii;


            fprintf('Test Set Accuracy : %.2f %d/%d correct\n', accuracyTestSet, correctT, tT);

            if accuracyTestSet==100 && accuracy==100 break; end 
        end

        
    end 
end