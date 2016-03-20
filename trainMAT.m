[X, Y, nOutput] = readNN('D:\ML\Categories 20 People\Training Set\'); 

%for i=1:size(X, 1)
%    image = reshape(X(i, :), [32, 30])'
%    figure, imshow(image)
%end

close all; 

nHidden = 3;

