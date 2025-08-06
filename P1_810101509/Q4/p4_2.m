% Load the audio file (replace 'filename.wav' with your actual file name)
[x, Fs] = audioread('my_voice_poet.wav');

% Create time vector in seconds
t = (0:length(x)-1)/Fs;

% Plot the audio signal
figure;
plot(t, x);
xlabel('Time (s)'); % Label the horizontal axis in seconds
ylabel('Amplitude');
title('Audio Signal');


% Play the audio file in MATLAB
sound(x, Fs);

% Save the x signal as a wav file
audiowrite('saved_audio.wav', x, Fs);
