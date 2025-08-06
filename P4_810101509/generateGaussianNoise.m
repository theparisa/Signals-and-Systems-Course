function generateGaussianNoise(signal_lenght, noise_amp)
    noise_signal = randn(1, signal_lenght);
    
    calculated_mean = mean(noise_signal);
    calculated_variance = var(noise_signal);
    
    fprintf('Calculated Mean: %.4f\n', calculated_mean);
    fprintf('Calculated Variance: %.4f\n', calculated_variance);
    
    num_bins = 50;
    figure;
    histogram(noise_signal, 'NumBins', num_bins, 'Normalization', 'pdf'); % Normalized to PDF
    hold on;
    
    x = linspace(min(noise_signal), max(noise_signal), 1000);
    gaussian_pdf = (1 / (sqrt(2 * pi) * noise_amp)) * exp(-(x - 0).^2 / (2 * noise_amp^2));
    plot(x, gaussian_pdf, 'r-', 'LineWidth', 2);

    xlabel('Value');
    ylabel('Probability Density');
    title(['Distribution of Noise Signal with ', num2str(num_bins), ' Bins']);
    legend('Histogram of Noise Signal', 'Theoretical Gaussian PDF');
    grid on;
    hold off;
end

