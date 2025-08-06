clc;
clear
close all

my_message='signal';
speed=5;

% Coding the message
[y,x_axis]=coding_freq(my_message,speed);
plot(x_axis,y)

% Decoding message
DcodedMessage=decoding_freq(y,speed);
disp(DcodedMessage)

