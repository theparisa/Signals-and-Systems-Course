clc;
close all
clear

message = 'signal';
bitRates = [1, 2, 3];
f_s = 100;

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

    decoded_message = decoding_amp(output_signal, bitRate);
    fprintf('Original message: "%s", Decoded message at bit rate %d: "%s"\n', ...
            message, bitRate, decoded_message);

end

generateGaussianNoise(3000, 1);
