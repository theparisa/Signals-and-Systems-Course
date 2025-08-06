function charDataset = generateCharacterMapping()
    % Define a string with all the characters
    characterList = ['a':'z', ' ', '.', ',', '!', '"', ';'];

    % Initialize an empty cell array 
    charDataset = cell(2, length(characterList));

    % Complete the first row with characters from the list
    for idx = 1:length(characterList)
        charDataset{1, idx} = characterList(idx);
    end

    % Complete the second row with 5-bit binary codes for each character
    for idx = 1:32
        if idx <= length(characterList)
            charDataset{2, idx} = dec2bin(idx-1, 5); % Convert decimal index to 5-bit binary string
        else
            break; % Exit loop if we exceed the character list length
        end
    end
end
