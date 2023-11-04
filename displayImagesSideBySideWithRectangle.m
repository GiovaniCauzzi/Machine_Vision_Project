function displayImagesSideBySideWithRectangle(image1, image2, x, y, xspan, yspan, xmass, ymass)
    % Create a 1x2 subplot grid
    subplot(1, 2, 1);
    imshow(image1,[]);   
    hold on;
    rectangle('Position', [x - xspan/2, y - yspan/2, xspan, yspan], 'EdgeColor', 'r', 'LineWidth', 2);
    hold off;

    subplot(1, 2, 2); 
    imshow(image2,[]); 
    hold on;
    plot(xmass, ymass, 'ro', 'MarkerSize', 10);
    hold off;
   
end