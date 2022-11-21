clc
format long


state = 1;
Tmax = 100000;
t = 0;
P = 0;
NJ = 0;
GC = 0;
C = 0;

while t < Tmax
    if state == 1 
        dt = - log(rand()) / 0.05;
        NJ = NJ + dt;
        next_state = 2;
    end

    if state == 2
        dt_NJ_GC = - log(rand()) / 0.1;
        dt_NJ_P = - log(rand()) / 1;
        dt = min([dt_NJ_GC, dt_NJ_P]);

        if (dt == dt_NJ_GC)
            next_state = 3;
            P = P + dt_NJ_GC;
        end

        if (dt == dt_NJ_P)
            next_state = 1;
            P = P + dt_NJ_P;
            C = C + 1;
        end
    end

    if state == 3
        dt_GC_NJ = - log(rand()) / 0.4;
        dt_GC_P = - log(rand()) / 0.3;
        dt = min([dt_GC_NJ, dt_GC_P]);

        if (dt == dt_GC_NJ)
            next_state = 2;
            GC = GC + dt_GC_NJ;
        end

        if (dt == dt_GC_P)
            next_state = 1;
            GC = GC + dt_GC_P;
            C = C + 1;
        end
    end

    state = next_state;
    t = t + dt;
end


Pr_P = P / Tmax;
Pr_NJ = NJ / Tmax;
Pr_GC = GC / Tmax;
X = C / Tmax;

fprintf("New Job Probability: %4f\n", Pr_NJ);
fprintf("Full Speed Probability: %4f\n", Pr_P);
fprintf("Garbage Collector Probability: %4f\n", Pr_GC);
fprintf("Throughput: %4f\n", X);
