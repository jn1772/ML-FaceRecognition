[X, Y, nOutput] = read('D:\ML\Categories 20 People\Training Set\', 0); 

%for i=1:size(X, 1)
%    image = reshape(X(i, :), [32, 30])'
%    figure, imshow(image)
%end

close all; 

nHidden = 15;

%Initialize Weights  
%xmin = -1; xmax = 1;
xmin = 0; xmax = 0; 
W1 = ones(nHidden, size(X, 2))*(xmin+rand(1, 1)*(xmax-xmin));   
xmin = -0.2; xmax = 0.2;
W2 = ones(nOutput,nHidden+1)*(xmin+rand(1, 1)*(xmax-xmin));   
E = stocasticBP(X, Y, W1, W2, nHidden, nOutput);