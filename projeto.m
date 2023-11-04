clc; close all; clear all;

% Load the video
videoName = 'OriginalVideos\Pink_uma_corda.mp4';
videoData = VideoReader(videoName);

[~, baseFileName, ~] = fileparts(videoName);
outputName = ['OutputVideos\SEG_', baseFileName, '.mp4'];
outputVideo = VideoWriter(outputName, 'MPEG-4');
open(outputVideo);

frameCounter = 1;  
totalFrames = floor(videoData.Duration * videoData.FrameRate); 

xCenter = 595;
yCenter = 280;
xSquare = 60;
ySquare = 110;

audioArray = zeros(totalFrames,1);
while (hasFrame(videoData) ) % & frameCounter < frame2Stop)
    % Ler frame
    frame = readFrame(videoData);    
    % frame = frame(yCenter-ySquare/2 : yCenter+ySquare/2, xCenter-xSquare/2 : xCenter+xSquare/2, :);
    frameGray = rgb2gray(frame);
   
    % Threshold segmenta��o
    pinkThreshold = 110;
    
    % Extract RGB 
    redChannel = frame(:,:,1);
    greenChannel = frame(:,:,2);
    blueChannel = frame(:,:,3);
    
    % Create a binary mask for pink pixels
    pinkMask = (abs(redChannel - 255) < pinkThreshold) & (greenChannel < pinkThreshold) & (blueChannel > pinkThreshold);

    % Segment the pink regions by applying the mask
    segmentedFrame = frame;
    segmentedFrame(repmat(~pinkMask, [1, 1, 3])) = 0; % Set non-pink pixels to black
    
    regiaoInteresseFrame = segmentedFrame(yCenter-ySquare/2 : yCenter+ySquare/2, xCenter-xSquare/2 : xCenter+xSquare/2);
    [centerX, centerY] = PointCenterOfMass(regiaoInteresseFrame);
    audioArray(frameCounter) = ySquare/2 - centerY;
    
    % Write the segmented frame to the output video
    writeVideo(outputVideo, segmentedFrame);
    
    % Plot do frame com area destacada e do frame semgmentado com o centro
    % de massa
    % ---    
    % Por algum motivo, a janela de plot s� abre se colocar um breakpoint
    % na linha seguinte
    % displayImagesSideBySideWithRectangle(frame, regiaoInteresseFrame, xCenter, yCenter, xSquare, ySquare, centerX,centerY)

    % Update progress
    progressPercent = (frameCounter / totalFrames) * 100;
    if rem(round(progressPercent),10) == 0
        fprintf('Processing: %.2f%%\n', progressPercent);
    end
    frameCounter = frameCounter + 1;
end

% Close the output video writer
close(outputVideo);

% Parametros para corte do video
frame2Start = 35;
frame2Stop = 515;

% Cortar inicio e fim do video por conta de nao ser em camera lenta
audioArray = audioArray(frame2Start:frame2Stop);
% Normalizacao da amplitude
audioArray = audioArray*(1/max(audioArray));

% Arquivos de saida
audiowrite('OutputVideos\output.wav', audioArray, 960);
sound(audioArray,960)

% Arquivos de saida 
audiowrite('OutputVideos\output.wav', audioArray, 960);
sound(audioArray,960)

subplot(1, 2, 1); 
plot(audioArray)
subplot(1, 2, 2); 
plot(log10(abs(fft(audioArray))))

