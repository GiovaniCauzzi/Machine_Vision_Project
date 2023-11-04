function displayImagesSideBySide(image1, image2)
    % Create a 1x2 subplot grid
    subplot(1, 2, 1); % The first subplot
    imshow(image1,[]);   % Display the first image

    subplot(1, 2, 2); % The second subplot
    imshow(image2,[]);   % Display the second image
end