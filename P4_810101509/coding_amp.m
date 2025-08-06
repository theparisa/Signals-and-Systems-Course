function output_signal = coding_amp(message, bitRate)
    
    Mapset = generateMapset;
    binary_coded_message = '';
    messege_len = strlength(message);

    for p = 1:messege_len
        curr_letter = extract(message,p);
        for q = 1:length(Mapset(1,:))
            if strcmp(curr_letter, Mapset{1, q})
                binary_coded_message = [binary_coded_message ,Mapset{2, q}];
                break;
            end
        end
    end

    binary_length = strlength(binary_coded_message);
    num_func = 2^bitRate;
    f_s = 100;
    t = 0:(1/f_s):1-(1/f_s);
    out_values = zeros(1, f_s * binary_length/bitRate);

    for n = 1:(bitRate):(binary_length - bitRate + 1)
        curr_code = extractBetween(binary_coded_message,n,n+bitRate-1);

        decimal_code = bin2dec(curr_code);

        start_idx = ((n-1)/bitRate) * f_s + 1;
        end_idx = start_idx + f_s - 1;

        out_values(start_idx:end_idx) = (decimal_code/(num_func -1 )) * sin(2*pi*t);

    end
    output_signal = out_values;
end
                

