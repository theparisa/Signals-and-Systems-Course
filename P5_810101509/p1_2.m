clc;
close all

% parameters
t_start = 0;
t_end = 1;
fs = 100; 
t = t_start:1/fs:t_end - 1/fs;
x = cos(30*pi*t + pi/4); 
% the signal in the time domain
figure;
subplot(3,1,1);
plot(t, x, 'b');
xlabel('Time (s)');
ylabel('Amplitude');
title('Signal x_2(t) in Time Domain');
grid on;
% number of samples
N = length(t); 
f = -fs/2 : fs/N : fs/2 - fs/N;
y = fft(x); 
y_shifted = fftshift(y); 
amplitude = abs(y_shifted) / max(abs(y_shifted)); 
% the normalized amplitude spectrum
subplot(3,1,2);
plot(f, amplitude, 'r');
xlabel('Frequency (Hz)');
ylabel('Normalized Amplitude');
title('Normalized Amplitude Spectrum');
grid on;
% phase spectrum
tol = 1e-6; 
y_shifted(abs(y_shifted) < tol) = 0; % Zero out low amplitudes
theta = angle(y_shifted); 
subplot(3,1,3);
plot(f, theta/pi, 'g');
xlabel('Frequency (Hz)');
ylabel('Phase / \pi');
title('Phase Spectrum');
grid on;
