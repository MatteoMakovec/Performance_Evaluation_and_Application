function F = HypoExp_pdf(x, l1, l2)
    F = l1*l2 / (l1 - l2) * (exp(- l2 * x) - exp(- l1 * x));
end
