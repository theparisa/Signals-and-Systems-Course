% Function to perform optimization and print results
function check_optimization(x_t, y_t, true_alpha, true_beta, noise_type)
    % Define the objective function as a handle for fminsearch
    objective = @(params) sum((y_t - (params(1) * x_t + params(2))).^2);

    % Initial guesses for alpha and beta
    initial_guess = [1, 1];  % [alpha, beta]

    % Use fminsearch to minimize the objective function
    params_opt = fminsearch(objective, initial_guess);

    % Extract the optimized alpha and beta
    alpha_opt = params_opt(1);
    beta_opt = params_opt(2);

    % Display the results
    fprintf('\nResults for %s data:\n', noise_type);
    fprintf('True alpha: %.4f, Optimized alpha: %.4f\n', true_alpha, alpha_opt);
    fprintf('True beta: %.4f, Optimized beta: %.4f\n', true_beta, beta_opt);

    % Check if the optimized values match the true values within a tolerance
    tolerance = 1e-2;
    if abs(alpha_opt - true_alpha) < tolerance && abs(beta_opt - true_beta) < tolerance
        fprintf('The optimized parameters match the true values!\n');
    else
        fprintf('The optimized parameters do NOT match the true values.\n');
    end

    % Plot the results
    figure;
    plot(x_t, y_t, '.', 'DisplayName', 'Data');
    hold on;
    plot(x_t, alpha_opt * x_t + beta_opt, 'r-', 'DisplayName', 'Fitted Line');
    xlabel('x_t');
    ylabel('y_t');
    title(sprintf('Fitting y_t = %.2f * x_t + %.2f (%s)', alpha_opt, beta_opt, noise_type));
    legend;
    hold off;
end