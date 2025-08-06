function grayImage = mygrayfun(rgbImage)
    % Extract the red, green, and blue channels from the RGB image
    redChannel = rgbImage(:,:,1);
    greenChannel = rgbImage(:,:,2);
    blueChannel = rgbImage(:,:,3);
    
    % Calculate the grayscale image using the given formula
    grayImage = 0.299 * redChannel + 0.578 * greenChannel + 0.114 * blueChannel;
    
    % Ensure the output is of the same class as the input
    grayImage = cast(grayImage, 'like', rgbImage);
end
