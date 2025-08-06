clc;
close all
clear

% Main message and it's parameters
message = 'signal';
bitRates = [1, 2, 3];
f_s = 100;
tolerance = 0; 

figure;

for k = 1:length(bitRates)
    bitRate = bitRates(k);
    output_signal = coding_amp_1(message,bitRate);

    t = (0:length(output_signal) - 1) / f_s;

    subplot(3, 1, k);
    plot(output_signal);

    xlabel('Sample Index');
    ylabel('Amplitude');
    title(['output signal for message  "',message,'" at bit rate = ', num2str(bitRate)]);
    grid on;
end

output_sig = coding_amp_1(message,3);
disp(decoding_amp(output_sig,3));
generateGaussianNoise(1000, 1);

% Loop for each bit rate and adding noise into the signal
for k = 1:length(bitRates)
    bitRate = bitRates(k);
    output_signal = coding_amp_1(message, bitRate);

    % Generate Gaussian noise
    noisePower = 0.09;  % Define noise power
    noise = sqrt(noisePower) * randn(1, length(output_signal));  % Gaussian noise
    noisy_signal = output_signal + noise;  % Add noise to the signal
    
    % Plot the signal
    t = (0:length(noisy_signal) - 1) / f_s;
    subplot(3, 1, k);
    plot(noisy_signal);

    xlabel('Sample Index');
    ylabel('Amplitude');
    title(['output signal for message  "',message,'" at bit rate = ', num2str(bitRate)]);
    grid on;

    % Decode each noisy signal
    decoded_message = decoding_amp(noisy_signal, bitRate);  
    disp(['Decoded message at bit rate ', num2str(bitRate), ': ', decoded_message]);
end

% Finding the maximum noise for each bit rate 

% Initialize maximum noise power storage
max_noise_power = zeros(1, length(bitRates));

% Loop over each bit rate to find maximum noise power
for k = 1:length(bitRates)
    bitRate = bitRates(k);
    output_signal = coding_amp_1(message, bitRate);  % Generate the clean output signal
    noisePower = 0.01;  % Start with zero noise

    while true
        % Generate Gaussian noise with the current noise power
        noise = sqrt(noisePower) * randn(1, length(output_signal));
        noisy_signal = output_signal + noise;  % Add noise to the signal

        try
            decoded_message = decoding_amp(noisy_signal, bitRate);
            % Check if decoding was successful or acceptable
            if strcmp(decoded_message, message) || acceptable_error(decoded_message, message, tolerance)
                noisePower = noisePower + 0.0001;  % Continue to increase noise
            else
                max_noise_power(k) = noisePower - 0.0001;
                break;
            end
        catch ME
            disp(['Decoding failed due to: ', ME.message]);
            max_noise_power(k) = noisePower - 0.0001;
            break;
        end
    end
    disp(['Max noise power for bit rate ', num2str(bitRate), ': ', num2str(max_noise_power(k))]);
    pause(10); 
end

% Define acceptable error function if tolerance is used
function success = acceptable_error(decoded, original, tolerance)
    % Count character differences
    errors = sum(decoded ~= original);
    success = errors <= tolerance;
end