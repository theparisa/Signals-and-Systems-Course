clc;
clear;

% Define the number of points
N = 100;

% Generate three sets of data with known alpha and beta
sets = struct();
sets(1).alpha = 2; sets(1).beta = 3;  % Set 1
sets(2).alpha = -1.5; sets(2).beta = 0.5;  % Set 2
sets(3).alpha = 0.8; sets(3).beta = -2;  % Set 3

% Define the noise level
noise_level = 0.1;

% Loop through each set and create noisy and noiseless data
for i = 1:3
    % Generate x_t values
    x_t = linspace(-5, 5, N);

    % Generate noiseless y_t values
    y_t_no_noise = sets(i).alpha * x_t + sets(i).beta;

    % Generate noisy y_t values
    y_t_noise = y_t_no_noise + noise_level * randn(1, N);

    % Store x_t and y_t data (both noisy and noiseless)
    sets(i).x_t = x_t;
    sets(i).y_t_no_noise = y_t_no_noise;
    sets(i).y_t_noise = y_t_noise;
end


% Now loop through each set and check both noisy and noiseless data
for i = 1:3
    % Check noiseless data
    check_optimization(sets(i).x_t, sets(i).y_t_no_noise, sets(i).alpha, sets(i).beta, 'Noiseless');
    
    % Check noisy data
    check_optimization(sets(i).x_t, sets(i).y_t_noise, sets(i).alpha, sets(i).beta, 'Noisy');
end

