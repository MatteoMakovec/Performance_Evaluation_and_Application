clc
format long

MTTF_1 = 20;
MTTR_1 = 2;
MTTF_2 = 3;
MTTR_2 = 8;
MTTreset = 100;

l1 = 1 / MTTF_1;
m1 = 1 / MTTR_1;
l2 = 1 / MTTF_2;
m2 = 1 / MTTR_2;
r = 1 / MTTreset;


Q = [-l1-l2-r,     l2,     l1,      r;
            m2, -l1-m2,      0,      l1;
            m1,      0, -l2-m1,      l2;
            0,      m1,     m2,  -m1-m2];

p0 = [1, 0, 0, 0];

[t, sol] = ode45(@(t,x) Q'*x, [0, 300], p0');

plot(t, sol, "-");
legend("s1", "s2", "s3", "s4");











