function [XReduced, k] = reduceDimensionality(sigma, X)
    [U, S, V] = svd(sigma);
    d = sum(diag(S));
    k=1;
    while true
        Y = diag(S); 
        n = sum(Y(1:k, 1));
        n/d
        if n/d>=0.99 
            break; 
        else
            k=k+1;
        end
    end
    k
    Ureduce = U(:, 1:k);
    XReduced = Ureduce' * X';  
    XReduced = XReduced';
end