clc; close all; clear all;

% Load the video
videoName = 'OriginalVideos\Pink_uma_corda.mp4';
videoData = VideoReader(videoName);


[~, baseFileName, ~] = fileparts(videoName);
outputName = ['OutputVideos\SEG_', baseFileName, '.mp4'];
outputVideo = VideoWriter(outputName, 'MPEG-4');
open(outputVideo);

frameCount = 0;  
totalFrames = floor(videoData.Duration * videoData.FrameRate); 

vetorSomas = zeros(totalFrames,1);
i = 1;
while hasFrame(videoData)
    % Ler frame
    frame = readFrame(videoData);
    
    frameGray = rgb2gray(frame);
    %frameGray = double(frameGray);
    
   vetorSomas(i) = sum(frameGray(:));
    i = i+1;
    %imshow(frameGray);
    
    
    % Threshold segmentação
    pinkThreshold = 110; % You might need to adjust this value
    
    % Extract RGB 
    redChannel = frame(:,:,1);
    greenChannel = frame(:,:,2);
    blueChannel = frame(:,:,3);
    
    % Create a binary mask for pink pixels
    pinkMask = (abs(redChannel - 255) < pinkThreshold) & (greenChannel < pinkThreshold) & (blueChannel > pinkThreshold);
    
    % Segment the pink regions by applying the mask
    segmentedFrame = frame;
    segmentedFrame(repmat(~pinkMask, [1, 1, 3])) = 0; % Set non-pink pixels to black
    
    % Write the segmented frame to the output video
    writeVideo(outputVideo, segmentedFrame);
    
    % Display the segmented frame
%     imshow(segmentedFrame);
%     drawnow;
    
    
    % Update progress
    frameCount = frameCount + 1;
    progressPercent = (frameCount / totalFrames) * 100;
    if rem(round(progressPercent),10) == 0
        fprintf('Processing: %.2f%%\n', progressPercent);
    end
end

% Close the output video writer
close(outputVideo);

plot(vetorSomas)
plot(log10(abs(fft(vetorSomas))))
