function X = scaleFeatures (x)
    x = x/255;
    mn = mean2(x);
    sd = std2(x);
    X = (x-mn)/sd; 
end
