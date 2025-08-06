function p4_4(x, Fs, speed)
    % Check if speed is within the valid range
    if speed < 0.5 || speed > 2
        error('Invalid speed. Speed must be between 0.5 and 2.');
    end
    
    % Get the original number of samples
    num_samples = length(x);  % Use length instead of size for 1D signal
    
    % Case 1: Double the speed (speed == 2)
    if speed == 2
        % Discard every other sample
        x_fast = x(1:2:end);
        sound(x_fast, Fs * 2);  % Play at double the sampling rate
    
    % Case 2: Halve the speed (speed == 0.5)
    elseif speed == 0.5
        % Insert samples by averaging between each adjacent pair
        x_slow = zeros(2 * num_samples - 1, 1);
        x_slow(1:2:end) = x;  % Original samples
        x_slow(2:2:end) = (x(1:end-1) + x(2:end)) / 2;  % Averages
        sound(x_slow, Fs / 2);  % Play at half the sampling rate
    
    % Case 3: For any speed between 0.5 and 2 (interpolation)
    else
        % Create a new time vector for interpolation
        t_original = (0:num_samples-1)';  % Original time vector
        t_new = linspace(0, num_samples-1, round(num_samples / speed))';  % New time vector
        
        % Interpolate the signal
        x_resampled = interp1(t_original, x, t_new, 'linear');
        
        % Play the resampled signal
        sound(x_resampled, Fs);
    end
end


