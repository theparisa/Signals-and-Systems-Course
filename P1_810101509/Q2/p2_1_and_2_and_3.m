clc;
clear;
close all;

% Load the .mat file
data = load('p2.mat'); 

% Display the variable names in the loaded structure
disp(fieldnames(data));

% Extract the signals x_t and y_t from the data
x_t = data.x;
y_t = data.y;
t = data.t;

% Plot x_t and y_t versus time
figure;
subplot(2,1,1); % Create a subplot for the first signal
plot(t, x_t);
xlabel('Time (t)');
ylabel('x_t');
title('Signal x_t vs Time');

subplot(2,1,2); % Create a subplot for the second signal
plot(t, y_t);
xlabel('Time (t)');
ylabel('y_t');
title('Signal y_t vs Time');

% Create a scatter plot of x_t versus y_t
figure;
plot(x_t, y_t, '.');
xlabel('x_t');
ylabel('y_t');
title('Scatter Plot of x_t vs y_t');

% Define the objective function to minimize
objective = @(params) sum((y_t - (params(1) * x_t + params(2))).^2);

% Initial guesses for alpha and beta
initial_guess = [1, 1]; % [alpha, beta]

% Use fminsearch to minimize the objective function
params_opt = fminsearch(objective, initial_guess);

% Extract the optimized alpha and beta
alpha_opt = params_opt(1);
beta_opt = params_opt(2);

% Display the results
fprintf('Optimized alpha: %.4f\n', alpha_opt);
fprintf('Optimized beta: %.4f\n', beta_opt);

% Plot the fit
figure;
plot(x_t, y_t, '.', 'DisplayName', 'Noisy Data');
hold on;
plot(x_t, alpha_opt * x_t + beta_opt, 'r-', 'DisplayName', 'Fitted Line');
xlabel('x_t');
ylabel('y_t');
title('Fitting y_t = \alpha x_t + \beta');
legend;
hold off;


