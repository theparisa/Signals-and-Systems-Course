clc;
close all

% parameters
t_start = -1;
t_end = 1;
fs = 50; 
t = t_start:1/fs:t_end - 1/fs;

x = cos(10*pi*t);

% the signal in time domain
figure;
subplot(2,1,1);
plot(t, x, 'b');
xlabel('Time (s)');
ylabel('Amplitude');
title('Signal in Time Domain');
grid on;

% number of samples
N = length(t); 

f = -fs/2 : fs/N : fs/2 - fs/N;

y = fft(x);
y_shifted = fftshift(y); 

amplitude = abs(y_shifted) / max(abs(y_shifted)); 

% the amplitude spectrum
subplot(2,1,2);
plot(f, amplitude, 'r');
xlabel('Frequency (Hz)');
ylabel('Normalized Amplitude');
title('Normalized Amplitude Spectrum');
grid on;
