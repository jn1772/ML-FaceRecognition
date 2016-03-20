function [x, y, nOutput] = read(path, k) 
    %read images
    rootDir = path;   

    % Get a list of all files and folders in this folder.
    files = dir(rootDir);  

    %remove hidden files
    files = files(arrayfun(@(x) ~strcmp(x.name(1),'.'),files));

    % Get a logical vector that tells which is a directory.
    dirFlags = [files.isdir];

    % Extract only those that are directories.
    subFolders = files(dirFlags); 
     
    n = 0;
    for i=1:length(subFolders)
        %subFolders(i).name
        folderPath = strcat(rootDir, subFolders(i).name, '\');
        images = dir(strcat(folderPath, '*.pgm'));
        n = n + length(images);
    end
      
    nOutput = length(subFolders); 
    x = zeros(n, 960);
    y = zeros(n, nOutput);
    
    %fprintf('no of training examples found = %d\n', n);
    count=1; 
    for i = 1 : nOutput 
        folderPath = strcat(rootDir, subFolders(i).name, '\');
        images = dir(strcat(folderPath, '*.pgm')); 
        for j = 1:length(images)
            image = imread(strcat(folderPath, images(j).name));  
            x(count, :) = reshape(image', [1, 30*32]);
            %figure, imshow(image);  
            y(count, :) = ones(1, nOutput)*0.1;
            y(count, i) = 0.9;
            count = count+1;
        end  
        close all;
    end  
    
    
    x = scaleFeatures(x);
    %x = reduceDimensionality(x, k);
    x = [ones(size(x, 1), 1) x];   
end

