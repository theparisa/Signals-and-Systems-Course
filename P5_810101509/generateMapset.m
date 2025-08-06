function Mapset = generateMapset()
    characterList = ['a':'z', ' ', ',', '.', '!', '"', ';'];

    Mapset = cell(2, length(characterList));

    for k = 1:length(characterList)
        Mapset{1, k} = characterList(k);
        Mapset{2, k} = dec2bin(k-1, 5); 
    end
end
