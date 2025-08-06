function [x_t, y_t_no_noise, y_t_noise] = generate_data(alpha, beta, N, noise_level)
    % Generate a new set of x_t and corresponding y_t (with and without noise)
    % Input:
    %   alpha, beta: Parameters of the line y_t = alpha * x_t + beta
    %   N: Number of data points
    %   noise_level: The standard deviation of the noise

    % Generate x_t values (linearly spaced)
    x_t = linspace(-5, 5, N);

    % Generate y_t values without noise
    y_t_no_noise = alpha * x_t + beta;

    % Generate y_t values with noise
    y_t_noise = y_t_no_noise + noise_level * randn(1, N);
end
