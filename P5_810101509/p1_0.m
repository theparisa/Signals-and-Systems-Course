clc;
close all

% parameters
t_start = 0;
t_end = 1;
fs = 20; 
t = t_start:1/fs:t_end - 1/fs; 

% number of samples
N = length(t); 

f = -fs/2 : fs/N : fs/2 - fs/N;

signal1 = exp(1i*2*pi*5*t) + exp(1i*2*pi*8*t); % First signal
signal2 = exp(1i*2*pi*5*t) + exp(1i*2*pi*5.1*t); % Second signal

y1 = fft(signal1); 
y2 = fft(signal2);

y1_shifted = fftshift(y1);
y2_shifted = fftshift(y2);

amplitude1 = abs(y1_shifted) / max(abs(y1_shifted));
amplitude2 = abs(y2_shifted) / max(abs(y2_shifted));

figure;

subplot(2, 1, 1);
plot(f, amplitude1, 'b');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Amplitude Spectrum of Signal 1: exp(1j*2\pi*5t) + exp(1j*2\pi*8t)');
grid on;

subplot(2, 1, 2);
plot(f, amplitude2, 'r');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Amplitude Spectrum of Signal 2: exp(1j*2\pi*5t) + exp(1j*2\pi*5.1t)');
grid on;
