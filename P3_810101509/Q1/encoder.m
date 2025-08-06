function encodedImage = encoder(mapping, grayImg, textMsg)
    
    windwDim = [5, 5];
    varThreshold = 70;

    % Convert the text message to a binary sequence using the mapping data
    binaryMessage = convertToBinary(textMsg, mapping);

    % Locate the semicolon index in the mapping data and append its binary representation to binaryMessage
    semicolonIdx = find([mapping{1, :}] == ';', 1);
    binaryMessage = [binaryMessage mapping{2, semicolonIdx}];

    % Duplicate the image to preserve original data for encoding
    encodedImage = grayImg;
    [imgRows, imgCols] = size(grayImg); 
    bitIdx = 1;  

    % Traverse the image in blocks defined by windwDim
    for m = 1:windwDim(1):imgRows-4
        for n = 1:windwDim(2):imgCols-4
            imgBlock = grayImg(m:m+4, n:n+4);
            % Check if block's variance surpasses the set threshold
            if var(double(imgBlock(:))) > varThreshold
                for row = m:m+4
                    for col = n:n+4
                        if bitIdx > length(binaryMessage), break; end
                        % Modify LSB of pixel to match current message bit
                        encodedImage(row, col) = bitset(encodedImage(row, col), 1, binaryMessage(bitIdx) - '0');
                        bitIdx = bitIdx + 1;
                    end
                end
            end
        end
    end

    if bitIdx <= length(binaryMessage)
        error('Message exceeds available space in the image.');
    end
end

function binStr = convertToBinary(text, mapping)
    binStr = ''; 
    for char = text
        idx = find([mapping{1, :}] == char, 1);
        if ~isempty(idx)
            % Append binary equivalent of character to binStr
            binStr = [binStr mapping{2, idx}];
        else
            error(['Character ', char, ' not present in mapping dataset.']);
        end
    end
end
