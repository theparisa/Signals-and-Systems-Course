function textMsg = binaryToText(binarySeq, mapping)
    textMsg = '';
    % Convert binary sequence in chunks of 5 bits to characters
    for k = 1:5:length(binarySeq) - 4
        charBits = binarySeq(k:k+4);
        % Find character matching the 5-bit binary chunk
        for i = 1:length(mapping(2, :))
            if strcmp(mapping{2, i}, charBits)
                decodedChar = mapping{1, i};
                break;
            end
        end
        if exist('decodedChar', 'var') && decodedChar == ';'
            break; 
        elseif exist('decodedChar', 'var')
            textMsg = [textMsg decodedChar]; 
        end
    end
end
