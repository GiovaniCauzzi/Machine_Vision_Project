function [mediax, mediay] = PointCenterOfMass( frame2process )
showFrame = 0;

[lines, columns] = size(frame2process);

sumx = 0;
sumy = 0;
counter = 0;
for line = 1 : lines
    for column = 1 : columns
        if(frame2process(line,column) > 10)
            sumx = sumx + column;
            sumy = sumy + line;
            counter = counter +1;
        end
    end
end

mediax = round(sumx / counter);
mediay = round(sumy / counter);

if(showFrame == 1)
    imshow(frame2process)
    hold on;
    plot(mediax, mediay, 'ro', 'MarkerSize', 10); % Overlay a red point
    hold off;
end

