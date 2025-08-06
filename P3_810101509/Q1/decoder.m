function decodedMsg = decoder(encodedImg, mapping)
    % Set window dimensions and variance threshold within the function
    windwDim = [5, 5];
    varThreshold = 70;

    binMsg = '';
    [imgRows, imgCols] = size(encodedImg);

    % Loop over image blocks based on window dimensions
    for m = 1:windwDim(1):imgRows-4
        for n = 1:windwDim(2):imgCols-4
            imgBlock = encodedImg(m:m+4, n:n+4);
            if var(double(imgBlock(:))) > varThreshold
                for row = m:m+4
                    for col = n:n+4
                        binMsg = [binMsg, num2str(bitget(encodedImg(row, col), 1))];
                    end
                end
            end
        end
    end

    % Convert binary message back to text
    decodedMsg = binaryToText(binMsg, mapping);
end

