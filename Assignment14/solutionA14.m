clc
clear all
format long

lambda1 = 500;
mu1  = 1500;
mu2 = 1000;

% SINGLE SERVER
D = (1/mu1) + (1/mu2);
m2 = 2 * ((1/mu1^2) + (1/(mu1*mu2)) + (1/mu2^2)) ;
p1 = lambda1 * D;

% Average Utilization
U_1 = p1;

% Exact Response Time
R_1 = D + (lambda1*m2) / (2*(1 - p1));

% Average Number of Jobs 
N_1 = p1 + ((lambda1^2*m2) / (2*(1-p1)));

disp("-------------------------------------------------------")
fprintf("Average Utilization: %4f\n", U_1);
fprintf("Exact Response Time: %4f\n", R_1);
fprintf("Average Number of Jobs: %4f\n", N_1);

disp("-------------------------------------------------------")
% TWO PARALLEL SERVERS

lambda2 = 4000;
k = 4;
T = k / lambda2;
p2 = D / (2*T);

hypo = sqrt(mu1^2+mu2^2) / (mu1+mu2);
erlang = 1 / sqrt(k);

% Average Utilization
U_2 = 2*p2;

% Exact Response Time
R_2 = D + (hypo^2 + erlang^2) / 2 * (p2^2 * D) / (1 - p2^2) ;

% Average Number of Jobs
N_2 = 1 / T * R_2;

fprintf("Average Utilization: %4f\n", U_2);
fprintf("Exact Response Time: %4f\n", R_2);
fprintf("Average Number of Jobs: %4f\n", N_2);
disp("-------------------------------------------------------")


