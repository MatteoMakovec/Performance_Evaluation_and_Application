function F = HypoExp(p)
    global M1
    global M2
    global trace

    l1 = p(1);
    l2 = p(2);
    F = [];
    F(1) = (   1 / (l1 - l2) * (l1 / l2^1 - l2 / l1^1)   ) / M1(trace) - 1;
    F(2) = (   2 / (l1 - l2) * (l1 / l2^2 - l2 / l1^2)   ) / M2(trace) - 1;
end