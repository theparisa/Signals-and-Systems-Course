clc;
clear;
close all;

parameters;

%Generate the sent signal (rectangular pulse)
sent_signal=zeros(1,tlen+1);
sent_signal(1:N)= ones(1,N);

%Generate the received signal (rectangular pulse with true delay t_d_true)
received_signal=zeros(1,tlen + 1);
index_t_d =t_d_true/t_s + 1;
received_signal(index_t_d:index_t_d+N-1)=alpha*ones(1,N);

% Plot the sent signal
figure;
subplot(2, 1, 1);
plot(t, sent_signal, 'b-', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Amplitude');
title('Sent Signal');
xlim([0, T]);
ylim([-0.1, 1.1]);



% Plot the received signal
subplot(2, 1, 2);
plot(t, received_signal, 'r-', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Amplitude');
title('Received Signal');
xlim([0, T]);
ylim([-0.1, alpha + 0.1]);

