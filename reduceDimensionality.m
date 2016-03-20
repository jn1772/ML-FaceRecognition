function [XReduced, k] = reduceDimensionality(X, k)
    sigma = computeSigma(X);
    [U, S, V] = svd(sigma);
    d = sum(diag(S));
    if(k==0)
        k=1;
        while true
            Y = diag(S); 
            n = sum(Y(1:k, 1)); 
            if n/d>=0.99 
                break; 
            else
                k=k+1;
            end
        end 
    end
    Ureduce = U(:, 1:k);
    XReduced = Ureduce' * X';  
    XReduced = XReduced';
end