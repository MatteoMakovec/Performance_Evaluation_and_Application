function F = HyperExp(p)
    global M1
    global M2
    global M3
    global trace

    l1 = p(1);
    l2 = p(2);
    p1 = p(3);
    F = [];
    F(1) = (p1 / l1 + (1-p1) / l2) / M1(trace) - 1;
    F(2) = 2 * ((p1 / l1^2) + (1-p1) / l2^2) / M2(trace) - 1;
    F(3) = 6 * ((p1 / l1^3) + (1-p1) / l2^3) / M3(trace) - 1;
end