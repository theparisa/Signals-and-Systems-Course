function cleanedImage = myremovecom(binaryImage, threshold)

    % Label connected components in the binary image
    [labeledImage, numComponents] = bwlabel(binaryImage);

    % Initialize a matrix to store the cleaned image
    cleanedImage = false(size(binaryImage));

    % Loop over each connected component
    for k = 1:numComponents
        % Get the pixels of the current component
        currentComponent = (labeledImage == k);
        
        % Calculate the area of the component (number of pixels)
        componentArea = sum(currentComponent(:));
        
        % Keep the component if its area is larger than the threshold
        if componentArea >= threshold
            cleanedImage = cleanedImage | currentComponent;
        end
    end
end
