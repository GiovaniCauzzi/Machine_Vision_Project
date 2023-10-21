function [imagePath, filePath, fileName] = LoadFile_UI()
% Prompt user to select an image file
filter = {'*.mp4;*.bmp;*.jpg;*.tiff;*.gif;*.jpeg', 'Supported Image Files (*.png, *.bmp, *.jpg, *.tiff, *.gif, *.jpeg)'};
[fileName, filePath] = uigetfile(filter, 'Select an Video File');
if isequal(fileName, 0)
    disp('No file selected. Exiting...');
    return;
end
imagePath = fullfile(filePath, fileName);
end

