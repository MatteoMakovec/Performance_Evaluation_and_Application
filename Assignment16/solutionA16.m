clc
clear all
format long

lambda0 = 15;
s1 = 0.085;
s2 = 0.075;
s3 = 0.060;

A = [1   0   0;
    -1   1   0;
     0  -1   1];

B = [10; 0; 5];

lambda = linsolve(A,B);

%  Visits
v1 = lambda(1)/lambda0;
v2 = lambda(2)/lambda0;
v3 = lambda(3)/lambda0;

% Demands
D1 = v1 * s1;
D2 = v2 * s2;
D3 = v3 * s3;

% Throughputs
X1 = lambda(1);
X2 = lambda(2);
X3 = lambda(3);

% Throughput of the system
X = X1 / v1;

% Utilizations
U1 = X * D1;
U2 = X * D2;
U3 = X * D3;

% Response Times
R1 = D1 / (1 - U1);
R2 = D2 / (1 - U2);
R3 = D3 / (1 - U3);

% Average Response Time
R = R1 + R2 + R3;

% Average Number of Jobs
N1 = X * R1;
N2 = X * R2;
N3 = X * R3;

disp("-------------------------------------------------------")
disp("VISITS:")
fprintf("Web Server: %4f\n", v1);
fprintf("Database Server: %4f\n", v2);
fprintf("Storage Server: %4f\n", v3);
disp("-------------------------------------------------------")
disp("DEMANDS:")
fprintf("Web Server: %4f\n", D1);
fprintf("Database Server: %4f\n", D2);
fprintf("Storage Server: %4f\n", D3);
disp("-------------------------------------------------------")
fprintf("System Throughput: %4f\n", X);
disp("-------------------------------------------------------")
disp("UTILIZATIONS:")
fprintf("Web Server: %4f\n", U1);
fprintf("Database Server: %4f\n", U2);
fprintf("Storage Server: %4f\n", U3);
disp("-------------------------------------------------------")
disp("NUMBER OF JOBS:")
fprintf("Web Server: %4f\n", N1);
fprintf("Database Server: %4f\n", N2);
fprintf("Storage Server: %4f\n", N3);
disp("-------------------------------------------------------")
fprintf("System Response Time: %4f\n", R);
disp("-------------------------------------------------------")