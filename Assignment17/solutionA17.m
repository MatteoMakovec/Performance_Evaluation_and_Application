clc
clear all
format long

N = 530;
s1 = 0.080;
s2 = 0.120;
s3 = 0.011;
v1 = 1.00;
v2 = 0.75;
v3 = 10.00;
Z = 120;

% Demands
D1 = v1 * s1;
D2 = v2 * s2;
D3 = v3 * s3;
D = [D1; D2; D3];

Nk = [0; 0; 0];
K = 3;

% Throughput
for n=1:N
    for k=1:K
        Rk(k) = D(k) * (1 + Nk(k));
    end
    X = n / (Z + sum(Rk));
    Nk = X .* Rk;
end

% System Response Time
R = sum(Rk);

% Utilizations
U = D .* X;

% Number of No Thinking
N_not_thinking = N - (N - sum(Nk));


disp("-------------------------------------------------------")
disp("DEMANDS:")
fprintf("Moodle Server: %4f\n", D1);
fprintf("File Server: %4f\n", D2);
fprintf("DB Server: %4f\n", D3);
disp("-------------------------------------------------------")
fprintf("System Throughput: %4f\n", X);
disp("-------------------------------------------------------")
disp("UTILIZATIONS:")
fprintf("Moodle Server: %4f\n", U(1));
fprintf("File Server: %4f\n", U(2));
fprintf("DB Server: %4f\n", U(3));
disp("-------------------------------------------------------")
fprintf("System Response Time: %4f\n", R);
disp("-------------------------------------------------------")
fprintf("Number of students not thinking: %4f\n", N_not_thinking);
disp("-------------------------------------------------------")