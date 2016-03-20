function n = learn(X, Y, W1, W2, nHidden, nOutput)
    %no of training examples
    n = size(X, 1);
    
    %no of features of images
    m = size(X, 2);
    
    %learning rate eta
    eta = 0.3;
    
    iteration = 0;
    %until termination condition is met repeat
    while true
        iteration = iteration + 1;
        %for each example in training set
        for i = 1:n
            %propagate the input forward through the network
            example = X(i, :);
            
            outputH = example*W1';
            outputH = sigmoid(outputH); 
            outputH = [1 outputH];  
            
            outputO = outputH*W2'; 
            outputO = sigmoid(outputO); 
            
            %propagate the errors backward through the network
                %for each network unit k, calculate its error term 
                outputE = zeros(1, nOutput); 
                for j=1:nOutput
                    outputE(1, j) = outputO(1, j)*(1-outputO(1, j))*(Y(i, j)-outputO(1, j));
                end

                %fprintf('output Error = \n');
                %outputE
                
                %for each hidden unit h, calucalte its error term 
                hiddenE = zeros(1, nHidden+1);
                sigma = zeros(1, nHidden+1);
                for j=1:nHidden+1
                    for k=1:nOutput
                        sigma(1, j)=sigma(1, j)+W2(k, j)*outputE(1, k);
                    end
                    hiddenE(1, j) = outputH(1, j)*(1-outputH(1, j))*sigma(1, j);
                end  
                
                %update each network weight Wji
                for j=1:nOutput
                    for k=1:nHidden+1
                        deltaW = eta*outputE(1, j)*outputH(1, k); 
                        W2(j, k) = W2(j, k) + deltaW;
                        %fprintf('deltaW = %d W2(j, k) = %d\n', deltaW, W2(j, k));
                    end
                end 

                for j=1:nHidden       %we don't have weights attached to edges incoming to bias unit
                    for k=1:m
                        deltaW = eta*hiddenE(1, j+1)*X(i, k);
                        W1(j, k) = W1(j, k) + deltaW;
                    end
                end 
        end
        
        %test accuracy over validation set
        accuracy = crossvalidate(W1, W2);
        fprintf('Iteration %d Accuracy CV set = %d\n', iteration, accuracy);
        if(accuracy>=90)break;end
        %break
    end
end