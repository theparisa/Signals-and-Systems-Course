% Parameters (unknown R will be estimated)
c = 3e8;             % Speed of light (m/s)
alpha = 0.5;         % Amplitude of the received signal
tau = 1e-6;          % Duration of the signal (seconds)
t_s = 1e-9;          % Sampling time (seconds)
T = 1e-5;            % Total time for the simulation (seconds)
t = 0:t_s:T;         % Time vector
tlen = round(T/t_s); 
N = round(tau/t_s);
R_true = 450;        % True distance that we will estimate
t_d_true = 2 * R_true / c;  % True time delay


num_trials = 100;  % Number of trials for each noise level
distance_limit = 10;   