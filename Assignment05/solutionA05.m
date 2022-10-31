clear all
clc
format long


data = readmatrix("random.csv");
N = size(data, 1);
t = tiledlayout(3,3);

% CONTINUOUS UNIFORM DISTRIBUTION between [5,15]
a = 5;
b  = 15;
trace = 2;
cont_unif_cdf = a + (b - a) * data(:, trace);

t = 5:0.1:15;
analytical_cont_unif_cdf  = max(0, min(1, ((t - a) / (b - a))));

disp("(1) CONTINUOUS UNIFORM DISTRIBUTION:")
fprintf("%6f\n", cont_unif_cdf(1:10))
nexttile
plot(sort(cont_unif_cdf), [1 : N] / N, '.', t, analytical_cont_unif_cdf, '-')
legend('DATASET', 'ANALYTICAL CONTINUOUS UNIFORM DISTRIBUTION');
disp("----------------------------------------------")


% DISCRETE DISTRIBUTION 
values = [5, 10, 15];
probabilities = [0.3, 0.4, 0.3];
trace = 1;
cumsum_probabilities = cumsum(probabilities);
for i = 1:N
    if data(i,trace) < cumsum_probabilities(1)
        discr_cdf(i,trace) = values(1);
    elseif data(i,trace) < cumsum_probabilities(2)
        discr_cdf(i,trace) = values(2);
    else
        discr_cdf(i,trace) = values(3);
    end
end

analytical_discr_cdf = [zeros(probabilities(1) * N, 1) + 5; zeros(probabilities(2) * N, 1) + 10; zeros(probabilities(3) * N, 1) + 15]

disp("(2) DISCRETE DISTRIBUTION:")
fprintf("%6f\n", discr_cdf(1:10))
nexttile
plot(sort(discr_cdf), [1 : N] / N, '.', analytical_discr_cdf, [1 : N] / N, '-')
legend('DATASET', 'ANALYTICAL DISCRETE DISTRIBUTION');
disp("----------------------------------------------")


% EXPONENTIAL DISTRIBUTION
average =  10;
lambda = 1 / average;
exponential_cdf = - log(data(:, 2)) / lambda;

t = 0:0.2:60;
analytical_discr_cdf = 1 - exp(- lambda * t);

disp("(3) EXPONENTIAL DISTRIBUTION:")
fprintf("%6f\n", exponential_cdf(1:10))
nexttile
plot(sort(exponential_cdf), [1:N]/N, '.', t, analytical_discr_cdf, '-')
legend('DATASET', 'ANALYTICAL EXPONENTIAL DISTRIBUTION');
disp("----------------------------------------------")


% 2-STAGES HYPER-EXPONENTIAL DISTRIBUTION
l1 = 0.05;
l2 = 0.175;
p1 = 0.3;

for i = 1:N
    if data(i,1) < p1  
        hyperExp_cdf(i,1) = - log(data(i,2)) / l1;
    else
        hyperExp_cdf(i,1) = - log(data(i,2)) / l2;
    end
end

t = 0:0.2:70;
analytical_hyperExp_cdf = 1 - p1 * exp(- l1 * t) - (1 - p1) * exp(- l2 * t);

disp("(4) 2-STAGES HYPER-EXPONENTIAL DISTRIBUTION:")
fprintf("%6f\n", hyperExp_cdf(1:10))
nexttile
plot(sort(hyperExp_cdf),[1:N]/N, ".", t, analytical_hyperExp_cdf, '-')
legend('DATASET', 'ANALYTICAL HYPER-EXPONENTIAL DISTRIBUTION');
disp("----------------------------------------------")


% 2-STAGES HYPO-EXPONENTIAL DISTRIBUTION
l1 = 0.25;
l2 = 0.16667;
hypoExp_cdf = -log(data(:, 2)) / l1 -log(data(:, 3)) / l2;

t = 0:0.2:35;
analytical_hypoexp_dist = 1 -  l2 * exp(- l1 * t) / (l2-l1) + l1 * exp(- l2 * t) / (l2-l1);

disp("(5) 2-STAGES HYPO-EXPONENTIAL DISTRIBUTION:")
fprintf("%6f\n", hypoExp_cdf(1:10))
nexttile
plot(sort(hypoExp_cdf), [1:N]/N, '.', t, analytical_hypoexp_dist, '-')
legend('DATASET', 'ANALYTICAL HYPO-EXPONENTIAL DISTRIBUTION');
disp("----------------------------------------------")


% HYPER-ERLANG DISTRIBUTION 
probabilities = [0.3, 0.7];
rates = [0.05, 0.35];
for i = 1:N
    if data(i,1) < probabilities(1)
        hyperErl_cdf(i,1) = - log(data(i,2)) / rates(1);
    else
        hyperErl_cdf(i,1) = - (log(data(i,2)) + log(data(i,3))) / rates(2);
    end
end

t = 0:0.2:70;
analytical_hyperErl_cdf = 1 - probabilities(1) .* exp(- rates(1) * t) - probabilities(2) .* (exp(- rates(2) * t) + rates(2) * t .* exp(- rates(2) * t));

disp("(6) HYPER-ERLANG DISTRIBUTION :")
fprintf("%6f\n", hyperErl_cdf(1:10))
nexttile
plot(sort(hyperErl_cdf), [1:N]/N, ".", t, analytical_hyperErl_cdf, "-")
legend('DATASET', 'ANALYTICAL HYPER-ERLANG DISTRIBUTION');