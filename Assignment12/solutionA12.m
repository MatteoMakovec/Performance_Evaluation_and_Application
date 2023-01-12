clc
clear all
format long


lambda = 50;
D = 0.015;

U_tot = lambda * D;
r = U_tot;

N_0 = (1 - r );
N_1 = (1 - r ) * r;
N_2 = (1 - r ) * (r^2);
N_3 = (1 - r ) * (r^3);
N_less4 = N_0 + N_1 + N_2 + N_3;

Q_avg = (r^2) / (1 - r);

R = D / (1-r);

R_more05 = exp(- (1/D - lambda) * 0.5);

percentile90 = -log(1 - 90/100) * R;

fprintf("Total Utilization: %4f\n", U_tot);
fprintf("One job in the system: %4f\n", N_1);
fprintf("Less than 4 jobs: %4f\n", N_less4);
fprintf("Average Queue Length: %4f\n", Q_avg);
fprintf("Average Response Time: %4f\n", R);
fprintf("Response Time greater than 0.5s: %4f\n", R_more05);
fprintf("Percentile 90: %4f\n", percentile90);


disp('------------------------------------------------------------');



lambda_new = 85;

r_MM2 = lambda_new / 2 * D;

U_tot = lambda_new * D;

U_avg = U_tot / 2;

N0_MM2 = ((1 - r_MM2) / (1 + r_MM2));
N1_MM2 = 2 * r_MM2 * ((1 - r_MM2) / (1 + r_MM2));
N2_MM2 = 2 * (r_MM2^2) * ((1 - r_MM2) / (1 + r_MM2));
N3_MM2 = 2 * (r_MM2^3) * ((1 - r_MM2) / (1 + r_MM2));
N_less4_MM2 = N0_MM2 + N1_MM2 + N2_MM2 + N3_MM2;

Q_avg_MM2 = lambda_new * (r_MM2 ^ 2) * D / (1 - (r_MM2 ^ 2));

R_MM2 = D / (1 - (r_MM2 ^ 2));


fprintf("Average Utilization: %4f\n", U_avg);
fprintf("Total Utilization: %4f\n", U_tot);
fprintf("One job in the system: %4f\n", N1_MM2);
fprintf("Less than 4 jobs: %4f\n", N_less4_MM2);
fprintf("Average Queue Length: %4f\n", Q_avg_MM2);
fprintf("Average Response Time: %4f\n", R_MM2);











