 clear all
clc
format long

N = 50000;
K = 200;
M = 250;
unif_a = 5;
unif_b = 10;
p1 = 0.1;
l1_hyper = 0.02;
l2_hyper = 0.2;

R_vals = [];
N_vals = [];
U_vals = [];
X_vals = [];

for k = 1:K
    InterArrivals = [];
    for i=1:M
        if rand(1,1) < p1  
            InterArrivals(i,1) = - log(rand(1,1)) / l1_hyper;
        else
            InterArrivals(i,1) = - log(rand(1,1)) / l2_hyper;
        end
    end

    Service = unif_a + (unif_b - unif_a) * rand(M, 1);

    Arrivals(1, 1) = 0;
    Completions(1,1) = Service(1,1);
    Response(1, 1) = Completions(1,1) - Arrivals(1,1);
    for i=2:M
        Arrivals(i,1) = sum(InterArrivals(1:i-1,1),1);
        Completions(i,1) = max(Arrivals(i,1), Completions(i-1,1)) + Service(i,1);
        Response(i,1) = Completions(i,1) - Arrivals(i,1);
    end

    R_vals(end+1,1) = mean(Response);

    W = sum(Response,1);
    T = Completions(end,1);

    N_vals(end+1,1) = W / T;

    B = sum(Service,1);

    U_vals(end+1,1) = B / T;
    X_vals(end+1,1) = M / T;
end

% Confidence intervals
R_min = mean(R_vals) - 1.96 * sqrt(var(R_vals)/K);
R_max = mean(R_vals) + 1.96 * sqrt(var(R_vals)/K);
fprintf("Average system response time (R) confidence interval: [%4f, %4f]\n", R_min, R_max);
N_min = mean(N_vals) - 1.96 * sqrt(var(N_vals)/K);
N_max = mean(N_vals) + 1.96 * sqrt(var(N_vals)/K);
fprintf("Average system population (N) confidence interval: [%4f, %4f]\n", N_min, N_max);
X_min = mean(X_vals) - 1.96 * sqrt(var(X_vals)/K);
X_max = mean(X_vals) + 1.96 * sqrt(var(X_vals)/K);
fprintf("Throughput (X) confidence interval: [%4f, %4f]\n", X_min, X_max);
U_min = mean(U_vals) - 1.96 * sqrt(var(U_vals)/K);
U_max = mean(U_vals) + 1.96 * sqrt(var(U_vals)/K);
fprintf("Utilization (U) confidence interval: [%4f, %4f]\n", U_min, U_max);

