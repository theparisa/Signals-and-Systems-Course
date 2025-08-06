function p4_3(x, Fs, speed)
    % Check if speed is valid (must be either 0.5 or 2)
    if speed ~= 0.5 && speed ~= 2
        error('Invalid speed. Speed must be either 0.5 or 2.');
    end
    
    % Case 1: Double the speed (speed == 2)
    if speed == 2
        % Discard every other sample to double the speed
        x_fast = x(1:2:end);
        % Play the audio at double the original sampling frequency
        sound(x_fast, Fs * 2);
    
    % Case 2: Halve the speed (speed == 0.5)
    elseif speed == 0.5
        % Create a new signal where each two adjacent samples are averaged
        x_slow = zeros(2 * length(x) - 1, 1);  % Allocate space for the new signal
        
        % Add original samples and averages of adjacent samples
        x_slow(1:2:end) = x;  % Place original samples
        x_slow(2:2:end) = (x(1:end-1) + x(2:end)) / 2;  % Add averaged samples between them
        
        % Play the audio at half the original sampling frequency
        sound(x_slow, Fs / 2);
    end
end


