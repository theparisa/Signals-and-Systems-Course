clc
close all;
clear;
% Loading the video
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
videoFile = 'car2.mp4';
videoObj = VideoReader(videoFile);

% Initialize frame counter
frameCounter = 1;

% Specify the frames you want
frame1 = 30;
frame2 = 50;

% Initialize variables for storing the frames
chosenFrame1 = [];
chosenFrame2 = [];

while hasFrame(videoObj)
    frame = readFrame(videoObj);
    if frameCounter == frame1
        chosenFrame1 = frame;
    elseif frameCounter == frame2
        chosenFrame2 = frame;
        break;
    end
    frameCounter = frameCounter + 1;
end

% Display the chosen frames
figure;
subplot(1, 2, 1);
imshow(chosenFrame1);
title(['Frame ', num2str(frame1)]);

subplot(1, 2, 2);
imshow(chosenFrame2);
title(['Frame ', num2str(frame2)]);

destinationFolder = '.';  % Update the folder path as needed

% Define the path and filename where you want to save the image
outputFileName1 = fullfile(destinationFolder, 'frame1picture.png');  % Change the name and format if needed

% Save the cropped image
imwrite(chosenFrame1, outputFileName1);

% Display a message to indicate that the image has been saved
disp(['Cropped image1 saved as: ', outputFileName1]);
destinationFolder = '.';  % Update the folder path as needed

% Define the path and filename where you want to save the image
outputFileName2 = fullfile(destinationFolder, 'frame2picture.png');  % Change the name and format if needed

% Save the cropped image
imwrite(chosenFrame2, outputFileName2);

% Display a message to indicate that the image has been saved
disp(['Cropped image2 saved as: ', outputFileName2]);

% Calculating speed 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x_frame_1 = 318;
y_frame_1 = 384;
x_frame_2 = 282;
y_frame_2 = 353;

frameRate = videoObj.FrameRate;
deltaTime = (frame2 - frame1) / frameRate;
deltaDistance = sqrt((x_frame_1 - x_frame_2)^2 + (y_frame_1 -y_frame_2)^2);
pixelSpeed = deltaDistance / deltaTime;
fprintf('The speed of car is %f pixel/second', pixelSpeed);