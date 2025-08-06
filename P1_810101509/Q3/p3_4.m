clc;
close all;

parameters;

%Generate the received signal (rectangular pulse with true delay t_d_true)
received_signal_clean=zeros(1,tlen);
index_t_d =t_d_true/t_s + 1;

%fprintf('idx_t_s = %d\n', idx_t_d);
received_signal_clean(index_t_d:index_t_d+N-1)=alpha*ones(1,N);

% Find the starting and ending indices of non-zero elements
start_idx = find(received_signal_clean, 1, 'first');  
end_idx = find(received_signal_clean, 1, 'last');    

% Generate a sample signal like the recieved signal 
sample_signal = received_signal_clean(start_idx:end_idx);

% Number of trials per noise level and noise levels to test
noise_powers = linspace(0, 10, 20);  % Noise power levels (you can adjust this range)

% Array to store average errors for each noise power
avg_errors = zeros(size(noise_powers));

% Loop over different noise powers
for np_idx = 1:length(noise_powers)
    noise_power = noise_powers(np_idx);  % Current noise power
    errors = zeros(1, num_trials);  % To store errors in each trial
    
    % Repeat the experiment multiple times (for averaging)
    for trial = 1:num_trials
        % Add Gaussian noise to the clean received signal
        noise = noise_power * randn(size(received_signal_clean));
        received_signal_noisy = received_signal_clean + noise;
        
        ro=zeros(1,tlen-N);
        for i=1:tlen-N
            ro(i)=innerProduct(received_signal_noisy(i:i+N-1),sample_signal);
        
        end
        % Find the time index corresponding to the maximum inner product
        [value, max_idx] = max(ro);
        
        % Calculate the time delay from the index of the maximum inner product
        time_lag = (max_idx - 1) * t_s;  % Index to time conversion
        % Estimate distance R using the time delay
        R_estimated = (time_lag * c) / 2;

        % Calculate the distance error
        distance_error = abs(R_estimated - R_true);
        
        % Store the error
        errors(trial) = distance_error;
    end
    
    % Calculate the average error for this noise power
    avg_errors(np_idx) = mean(errors);
    
    % Print the result: whether the distance is still correctly estimated
    if avg_errors(np_idx) < distance_limit
        fprintf('Noise Power = %.4f: Distance correctly estimated with average error = %.4f meters\n', ...
            noise_power, avg_errors(np_idx));
    else
        fprintf('Noise Power = %.4f: Distance estimation failed, average error = %.4f meters\n', ...
            noise_power, avg_errors(np_idx));
    end
end

% Plot the average error vs noise power
figure;
plot(noise_powers, avg_errors, 'b-o', 'LineWidth', 2);  % Plot the average errors
xlabel('Noise Power');
ylabel('Average Distance Error (meters)');
title('Average Distance Error vs Noise Power');
grid on;

% Highlight the noise power where the error becomes unacceptable (>10 meters)
hold on;
idx_unacceptable = avg_errors > 10;  % Find indices where error > 10 meters
plot(noise_powers(idx_unacceptable), avg_errors(idx_unacceptable), 'ro', 'MarkerFaceColor', 'r');

% Add legend correctly
if any(idx_unacceptable)
    legend('Average Error', 'Unacceptable Error (>10 meters)');
else
    legend('Average Error');
end
hold off;
