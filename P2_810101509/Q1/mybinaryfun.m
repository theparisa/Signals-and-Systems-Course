function binaryImage = mybinaryfun(grayImage, threshold)
    % Convert grayscale image to binary image using the specified threshold
    binaryImage = grayImage <= threshold;
    
    % Ensure the output is of the same class as the input
    binaryImage = cast(binaryImage, 'like', grayImage);
end