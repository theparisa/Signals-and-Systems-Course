clc;
clear;
close all;


% Select an image file using a file dialog
[file, path] = uigetfile({'*.jpg;*.bmp;*.png;*.tif'}, 'Choose an image');
if isequal(file, 0)
    disp('User selected Cancel');
    return;
end

% Read the selected image
imagePath = fullfile(path, file);
rgbImage = imread(imagePath);

% Convert to grayscale if the image is in RGB
if size(rgbImage, 3) == 3
    grayImage = rgb2gray(rgbImage);
else
    grayImage = rgbImage;
end

% Define character dataset and message
mapping = generateCharacterMapping();
textMessage = 'signal;';

% Encode and decode the message
encodedImg = encoder(mapping, grayImage, textMessage);
decodedText = decoder(encodedImg, mapping);

% Display the decoded message
disp('Decoded Message:');
disp(decodedText);

% Display the original grayscale and encoded images side by side
figure;
subplot(1,2,1);
if size(rgbImage, 3) == 3
    imshow(grayImage);
    title('Grayscale Image Before Encoding');
else
    imshow(rgbImage);
    title('Image Before Encoding');
end
axOriginal = gca;

subplot(1,2,2);
imshow(encodedImg);
title('Image After Encoding');
axEncoded = gca;


% Save the encoded image in the same directory as the input image
outputPath = fullfile(path, 'encoded_image.png');
imwrite(encodedImg, outputPath);
disp(['Encoded image saved as: ', outputPath]);
