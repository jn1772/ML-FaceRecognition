root = dir('C:\Users\Jaguar\Desktop\senthil_database_version1\S*');  
h = waitbar(0, 'Reading Input Images...');
resized = cell(5, 16);
X = zeros(80, 80*80);
count = 1;

progress = 0.0;
for i = 1:length(root)
    subdir = dir(strcat('C:\Users\Jaguar\Desktop\senthil_database_version1\', root(i).name, '\*.tif'));  

    for j = 1:length(subdir)
        
        file = strcat('C:\Users\Jaguar\Desktop\senthil_database_version1\', root(i).name, '\', num2str(j), '.tif'); 
        I = imread(file);   
        I = imresize(I, [80, 80]);
          
        I = reshape(I', [1, 80*80]);
        X(count, :) = I; 
        figure, imshow(reshape(I, [80, 80])');
        
        count = count + 1; 
        progress = progress+0.005; 
        waitbar(progress, h, 'Reading Input Images...');
    end
    close all;
end  

waitbar(0.4, h, 'Computing Sigma...')
sigma = computeSigma(X);
waitbar(0.8, h, 'Reducing Dimensions...')
[X, k] = reduceDimensionality(sigma, X);
waitbar(1, h, 'Dimensionality Reduction Complete...')
close(h)

dim1 = ceil(sqrt(k))
dim2 = ceil(k/dim1); 
pad = (dim1*dim2)-k;

dim1
dim2

for i=1:size(X, 1)
    padded = X(i, :);
    size(padded)
    temp = zeros(1, pad);
    padded = [padded temp];
    size(padded)
    temp = reshape(padded, [dim1, dim2])';
    figure, imshow(temp); 
end  
