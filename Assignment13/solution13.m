clc
clear all
format long


% M/M/1/16
lambda = 1200;
D = 0.00125;
c = 1;
k = 16;

r = lambda * D;

U = (r - r.^(k+1)) / (1 - r.^(k+1));

N_14 = (1-r) / (1 - (r.^(k+1))) * (r.^14);

N = (r / (1-r)) - (((k+1) * r.^(k+1)) / (1 - r.^(k+1)));

r_k = (r.^k - r.^(k+1)) / (1 - r.^(k+1));
X = lambda * (1 - r_k);
drop_rate = lambda * r_k;

R = N / (lambda * (1 - r_k));
Q = R - D;

fprintf("Average Utilization: %4f\n", U);
fprintf("Probability of having 14 packets in the system: %4f\n", N_14);
fprintf("Average number of packets in the system: %4f\n", N);
fprintf("Throughput: %4f\n", X);
fprintf("Drop Rate: %4f\n", drop_rate);
fprintf("Average Response Time: %4f\n", R);
fprintf("Average Time spent in the Queue: %4f\n", Q);



disp("---------------------------------------------------------------------------");


% M/M/2/16
c = 2;
r_2 = lambda * D / c;


sum = 0;
for i=0 : (c-1)
    sum = sum + (((c * r_2).^i) / factorial(i));
end
r0_2 = (((c * r_2).^c) / factorial(c) * ((1 - (r_2.^(k-c+1))) / (1 - r_2)) + sum).^-1;

sum_ut1 = 0;
sum_ut2 = 0;
for i=1 : c
    if i < c
        sum_ut1 = sum_ut1 + (i * (r0_2 / factorial(i)) * ((c * r_2).^i));
    else
        sum_ut1 = sum_ut1 + (i * (r0_2 * (c.^c) * r_2.^i) / factorial(c));
    end
end

for i=(c+1) : k
    sum_ut2 = sum_ut2 + (r0_2 * (c.^c) * r_2.^i / factorial(c));
end


U_2 = (sum_ut1 + c * sum_ut2) / c;


N_14_2 = (r0_2 * (c.^c) * (r_2.^14)) / factorial(c);


sumi = 0;
for i = 1:k
    if i < c
        ri_2 = r0_2 / factorial(i) * (c * r_2).^i;
    else
        ri_2 = r0_2 * c.^c * r_2.^i / factorial(c);
    end
    sumi = sumi + i * ri_2;
end
N_2 = sumi;


rk = r0_2 * c.^c * r_2.^k / factorial(c);
X_2 = lambda * (1 - rk);
drop_rate_2 = lambda * rk;


R_2 = N_2 / (lambda * (1 - rk));
Q_2 = R_2 - D;

fprintf("Average Utilization: %4f\n", U_2);
fprintf("Probability of having 14 packets in the system: %4f\n", N_14_2);
fprintf("Average number of packets in the system: %4f\n", N_2);
fprintf("Throughput: %4f\n", X_2);
fprintf("Drop Rate: %4f\n", drop_rate_2);
fprintf("Average Response Time: %4f\n", R_2);
fprintf("Average Time spent in the Queue: %4f\n", Q_2);