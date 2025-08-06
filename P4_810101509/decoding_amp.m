function message = decoding_amp(received_signal, bitRate)
    f_s = 100;
    start_idx = 1;
    end_idx = f_s;

    binary_coded_message = '';
    num_signal= length(received_signal) / f_s;
    num_func = 2^bitRate;
    
    for n = 1:num_signal

        segment_values = received_signal(start_idx:end_idx);
        corr_value = correlation_with_sin(segment_values);
        
        decimal_code = round(corr_value * (num_func -1));

        binary_code = dec2bin(decimal_code, bitRate);
        binary_coded_message = [binary_coded_message ,binary_code];

        start_idx = start_idx + f_s;
        end_idx = end_idx + f_s;

    end
    message = '';
    Mapset = generateMapset(); 
    bin_message_len = strlength(binary_coded_message);
    for p = 1:5:(bin_message_len)
        curr_letter = extractBetween(binary_coded_message,p,p+5-1);
        for q = 1:length(Mapset(1,:))
            if strcmp(curr_letter, Mapset{2, q})
                message = [message ,Mapset{1, q}];
                break;
            end
        end
    end
end

