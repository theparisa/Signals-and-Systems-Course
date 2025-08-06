clc;
clear;
close all;

% Load your audio file
[x, Fs] = audioread('my_voice_poet.wav');

% Play at double speed
p4_3(x, Fs, 2);

% Pause for 2 seconds
pause(5);

% Play at half speed
p4_3(x, Fs, 0.5);

% Pause for  seconds
pause(5);

% Play at half speed
p4_4(x, Fs, 1);