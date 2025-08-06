clc;
clear;
close all;

% Step 1: Select the larger image
[file1, path1] = uigetfile({'*.jpg;*.bmp;*.png;*.tif'}, 'Choose the larger image');
s1 = [path1, file1];
largerImage = imread(s1);
largerImage = imresize(largerImage, [700 600]); 

% Ensure that the larger image is indeed RGB by checking its dimensions
if size(largerImage, 3) == 3  % Check if the image has 3 channels (RGB)
    % Extract red, green, and blue channels
    redChannel = largerImage(:, :, 1);
    greenChannel = largerImage(:, :, 2);
    blueChannel = largerImage(:, :, 3);

    % Define color masks based on your criteria for each channel
    red_mask = redChannel < 50;
    green_mask = greenChannel < 140 & greenChannel > 30;
    blue_mask = blueChannel > 110;

    % Combine the masks to create a final color-based mask
    color_mask = red_mask & green_mask & blue_mask;
else
    error('The selected larger image is not an RGB image.');
end
% Select the smaller image
[file2, path2] = uigetfile({'*.jpg;*.bmp;*.png;*.tif'}, 'Choose the smaller image');
s2 = [path2, file2];
smallerImage = imread(s2);
smallerImage = imresize(smallerImage, [30 8]);  % Resize for consistency

% Convert the smaller image to binary if it is RGB
if size(smallerImage, 3) == 3  % If the smaller image is RGB, convert to grayscale and then to binary
    smallerImage = rgb2gray(smallerImage);
    threshold = graythresh(smallerImage);
    smallerImage = imbinarize(smallerImage, threshold);
end

% Step 3: Define spatial filtering to search both middle and bottom regions
spatial_mask = false(size(largerImage, 1), size(largerImage, 2));  % Initialize mask with all false
quarter_row = floor(size(largerImage, 1) / 4);

% Middle region
spatial_mask(quarter_row:3*quarter_row, :) = true;
% Bottom half
spatial_mask(floor(size(largerImage, 1) / 2):end, :) = true;

% Combine the spatial mask with the color mask
final_mask = color_mask & spatial_mask;

% Apply the final mask to highlight the regions in the larger image
highlightedPicture = largerImage;
highlightedPicture(repmat(~final_mask, [1 1 3])) = 0;  % Black out non-matching areas

% Display the images and process the correlation
figure;

% Display the larger binary image
subplot(2, 2, 1);
imshow(largerImage);
title('Original Larger Image');

% Display the smaller binary image
subplot(2, 2, 2);
imshow(smallerImage);
title('Processed Smaller Image');

% Display the larger image with the highlighted areas
subplot(2, 2, 3);
imshow(highlightedPicture);
title('Highlighted Areas Matching Color and Region Criteria');

% Step 3: Perform cross-correlation using only the valid region
% Convert restricted larger image to grayscale for correlation
restricted_larger_image = rgb2gray(largerImage) .* uint8(final_mask);
correlationOutput = normxcorr2(smallerImage, restricted_larger_image);

% Find the peak correlation value
[maxCorrValue, maxIndex] = max(correlationOutput(:));

% Convert the linear index to row, column coordinates
[peakRow, peakCol] = ind2sub(size(correlationOutput), maxIndex);

% Step 4:
% Adjust the top-left corner of the matched region in the larger image
corr_offset = [peakRow - size(smallerImage, 1), peakCol - size(smallerImage, 2)];

% Ensure the offset stays within the valid bounds of the larger image
corr_offset = max(corr_offset, 0);

% Display the larger image with the most correlated region highlighted
subplot(2, 2, 4);
imshow(largerImage);
title('Larger Image with Best-Matched Region');
hold on;
rectangle('Position', [corr_offset(2), corr_offset(1), size(smallerImage, 2), size(smallerImage, 1)], ...
          'EdgeColor', 'r', 'LineWidth', 2);

% Calculate left-top y-coordinate of the red rectangle (y_min)
y_min = corr_offset(1);
disp(['Left-bottom y-coordinate (y_min): ', num2str(y_min)]);

% Calculate middle x-coordinate of the red rectangle
x_middle = corr_offset(2) + size(smallerImage, 2) / 2;
disp(['Middle x-coordinate of red rectangle: ', num2str(x_middle)]);


% Call the function to draw the blue rectangle and get its coordinates
[blueRectCoords] = drawBlueRectangle(largerImage, x_middle, y_min);

hold off;

% Crop the region defined by blue rectangle from the original resized image
% blueRectCoords is assumed to have the format: [x_start, y_start, width, height]
x_start = blueRectCoords(1);
y_start = blueRectCoords(2);
blue_width = blueRectCoords(3);
blue_height = blueRectCoords(4);

fprintf('The x-start of the palte: %d \n', x_start);
fprintf('The y-start of the palte: %d \n', y_start);

% Crop the specified area from the original image
croppedImage = imcrop(largerImage, [x_start, y_start, blue_width, blue_height]);

% Define the destination folder (replace with your desired path)
destinationFolder = '.';  % Update the folder path as needed

% Define the path and filename where you want to save the image
outputFileName = fullfile(destinationFolder, 'cropped_blue_rectangle.png');  % Change the name and format if needed

% Save the cropped image
imwrite(croppedImage, outputFileName);

% Display a message to indicate that the image has been saved
disp(['Cropped image saved as: ', outputFileName]);


% Function to draw the blue rectangle and output its coordinates
function [blueCoords] = drawBlueRectangle(resizedImage, x_middle, y_min)
    % Define dimensions for the blue rectangle
    blue_width = 85;
    blue_height = 35;
    
    % Calculate the top-left coordinates for the blue rectangle
    x_start = x_middle;
    y_start = y_min;  

    % Draw the blue rectangle on the original resized image
    figure;
    imshow(resizedImage);
    hold on;
    rectangle('Position', [x_start, y_start, blue_width, blue_height], 'EdgeColor', 'b', 'LineWidth', 2);
    title('Larger Image with Blue Rectangle');
    hold off;
    
    % Output the coordinates of the blue rectangle
    blueCoords = [x_start, y_start, blue_width, blue_height];
    disp(['Blue Rectangle Coordinates: ', num2str(blueCoords)]);
end
