function sigma = computeSigma(X)
    m = size(X, 1);  
    sigma = (1/m)*(X'*X); 
end