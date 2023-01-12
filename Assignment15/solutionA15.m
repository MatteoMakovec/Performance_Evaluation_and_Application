clc
clear all
format long

lambda0 = 10;

s1 = 0.040;
s2 = 0.100;
s3 = 0.120;

A = [1   -1  -0.2;
    -0.3  1  -0.8;
    -0.2  0   1];

B = [10; 0; 0];

lambda = linsolve(A,B);

% Visits
v1 = lambda(1) / lambda0;
v2 = lambda(2) / lambda0;
v3 = lambda (3) / lambda0;

% Demands
D1 = v1 * s1;
D2 = v2 * s2;
D3 = v3 * s3;

% Throughputs
X1 = lambda(1);
X2 = lambda(2);
X3 = lambda(3);

disp("-------------------------------------------------------")
disp("VISITS:")
fprintf("CPU: %4f\n", v1);
fprintf("Disk: %4f\n", v2);
fprintf("Network: %4f\n", v3);
disp("-------------------------------------------------------")
disp("DEMANDS:")
fprintf("CPU: %4f\n", D1);
fprintf("Disk: %4f\n", D2);
fprintf("Network: %4f\n", D3);
disp("-------------------------------------------------------")
disp("THROUGHOUTS:")
fprintf("CPU: %4f\n", X1);
fprintf("Disk: %4f\n", X2);
fprintf("Network: %4f\n", X3);
disp("-------------------------------------------------------")