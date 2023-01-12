clc
clear all
format long


lambda_e = 5;
lambda_p = 10;

D_1e = 0.05;
D_2e = 0.1;
D_1p = 0.06;
D_2p = 0.04;


% Utilizations
U_1e = lambda_e * D_1e;
U_2e = lambda_e * D_2e;
U_1p = lambda_p * D_1p;
U_2p = lambda_p * D_2p;
U_CRM = U_1e + U_1p;
U_FS = U_2e + U_2p;


% Residence times
R_1e = D_1e / (1 - (U_1e + U_1p));
R_1p = D_1p / (1 - (U_1e + U_1p));
R_2e = D_2e / (1 - (U_2e + U_2p));
R_2p = D_2p / (1 - (U_2e + U_2p));
R_CRM = lambda_e / (lambda_e+lambda_p) * R_1e + lambda_p / (lambda_e+lambda_p) * R_1p;
R_FS = lambda_e / (lambda_e+lambda_p) * R_2e + lambda_p / (lambda_e+lambda_p) * R_2p;


% System response time
R = R_CRM + R_FS;

disp("-------------------------------------------------------")
disp("-----------  CRM ----------")
fprintf("Utilization: %4f\n", U_CRM);
fprintf("Residence time: %4f\n", R_CRM);
disp("-----------  FS ----------")
fprintf("Utilization: %4f\n", U_FS);
fprintf("Residence time: %4f\n", R_FS);
disp("--------------------------")
fprintf("System response time: %4f\n", R);
disp("-------------------------------------------------------")

