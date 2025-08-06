clc;
close all;

parameters;

%Generate the received signal (rectangular pulse with true delay t_d_true)
received_signal=zeros(1,tlen);
index_t_d =t_d_true/t_s + 1;
received_signal(index_t_d:index_t_d+N-1)=alpha*ones(1,N);

% Find the starting and ending indices of non-zero elements
start_idx = find(received_signal, 1, 'first');  % Index of the first non-zero element
end_idx = find(received_signal, 1, 'last');     % Index of the last non-zero element

% Generate a sample signal like the recieved signal 
sample_signal = received_signal(start_idx:end_idx);

% Calculate the correlation between the recieved signal and sample signal
ro=zeros(1,tlen-N);
for i=1:tlen-N
        ro(i)=innerProduct(received_signal(i:i+N-1),sample_signal);
end

% Find the time index corresponding to the maximum inner product
[~, max_idx] = max(ro);

% Calculate the time delay from the index of the maximum inner product
time_lag = (max_idx - 1) * t_s; 

% Calculate the estimated R
R_estimated = (time_lag * c) / 2;

% Display the estimated R
fprintf('True R: %.2f meters\n', R_true);
fprintf('Estimated R: %.2f meters\n', R_estimated);
