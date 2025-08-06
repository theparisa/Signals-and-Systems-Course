clear;
clc;

my_message = 'signal';
speeds = [1, 5]; 
variance_values = 0:0.0001:2;
[y, x_axis] = coding_freq(my_message, speeds(1)); 

max_variance_matched = zeros(1, length(speeds)); 
for s_idx = 1:length(speeds)
    speed = speeds(s_idx);
    disp(['Testing for speed = ', num2str(speed)]);
    [encoded_signal, x_axis] = coding_freq(my_message, speed);
    for variance = variance_values
        noisy_signal = encoded_signal + sqrt(variance) * randn(size(encoded_signal));
        decoded_message = decoding_freq(noisy_signal, speed);
        if strcmp(decoded_message, my_message)
            max_variance_matched(s_idx) = variance; 
        else
            break; % Stop when decoding fails
        end
    end
    disp(['Max variance for speed ', num2str(speed), ': ', num2str(max_variance_matched(s_idx))]);
end
% summary
disp('Summary of results:');
for s_idx = 1:length(speeds)
    disp(['Speed = ', num2str(speeds(s_idx)), ', Max Variance = ', num2str(max_variance_matched(s_idx))]);
end
