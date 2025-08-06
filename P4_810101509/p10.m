clc;
close all
clear

message = 'signal';

len_binary_coded_message = length(message) * 5;
acceptable_bitRates = findDivisors(len_binary_coded_message);

maxBitRate = 0;

for k = 1:length(acceptable_bitRates)
    bitRate = acceptable_bitRates(k);
    output_signal = coding_amp_1(message,bitRate);
    decoded_message = decoding_amp(output_signal,bitRate);
    if strcmp(decoded_message, message)

        maxBitRate = bitRate;
    else
        break;
    end
end

fprintf('The max limit of bitRate for deociding correctly is %f\n', maxBitRate);

