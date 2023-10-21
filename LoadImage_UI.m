function [imageLoaded] = LoadImage_UI()
[imagePath, filePath, fileName] = LoadFile_UI();
imageLoaded = imread(imagePath);
end

