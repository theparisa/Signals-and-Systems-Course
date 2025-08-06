t = 0:0.01:1;
z1 = cos(2*pi*t);
z2 = sin(2*pi*t);

figure;

% First subplot: Sine plot
subplot(1, 2, 1);  % Creates a 1x2 grid and selects the first plot
plot(t, z2, '--b');  
title('Sin');  
legend('sin');  
xlabel('time');  
ylabel('amplitude'); 
text(0.5, 0, 'sin(2\pi t)');  % Add text annotation for the sine function
grid on;  

% Second subplot: Cosine plot
subplot(1, 2, 2);  % Selects the second plot in the 1x2 grid
plot(t, z1, 'r');  
title('Cos'); 
legend('cos'); 
xlabel('time'); 
ylabel('amplitude'); 
text(0.5, 0, 'cos(2\pi t)');  % Add text annotation for the cosine function
grid on;  


