clc
clear all
format long

N = 16;
N0 = 8;

b = 0.2;
m = 0.1;

pn = zeros(1, N+1);
pd = zeros(1, N+1);

pn(1,1) = 0;
pd(1,1) = 0;

for i=1:N
	if i < N0
		lim1 = b;
	else
		lim1 = b * (N-i) / (N-N0);
    end
	pn(1, i+1) = pn(1,i) + log(lim1);
	pd(1, i+1) = pd(1,i) + log(m);
end

p = exp(pn - pd);
p = p / sum(p);

plot([0:N], p, "+");
