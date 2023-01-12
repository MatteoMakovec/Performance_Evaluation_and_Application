clc
clear all
format long

Q = [-1/10,         1/10,              0,          0;   % Idle
      1/50,   -1/50-1/20-1/10,       1/10,       1/20;  % CPU
         0,         1/5,            -1/5,          0;   % I/O
         0,         1/2,               0,       -1/2];  % GPU

p0 = [1, 0, 0, 0];

Qi = Q;
Qi(:,1) = ones(4,1);
pi = p0 * inv(Qi);

alpha = [0.1, 2, 0.5, 10]; 
[t, sol] = ode45(@(t,x) Q'*x, [0 500], p0');
plot(t, sol, "-");
legend("Idle", "CPU", "I/O", "GPU");

% State rewards evolution
plot(t, sol*alpha', "-");
legend("State rewards evolution");


% Utilization
alpha_utilization = [0, 1, 1, 1];  
U = sum(pi*alpha_utilization');


% System Throughput
e_X_s = [0, 0, 0, 0;   % idle
         1, 0, 0, 0;   % cpu
         0, 0, 0, 0;   % i/o
         0, 0, 0, 0];  % gpu

X_system = 0;
for i = 1:4
    temp = 0;
    for j = 1:4
        if i ~= j
            temp = temp + Q(i,j) * e_X_s(i,j);
        end
    end
    X_system = X_system + pi(i) * temp;
end


% GPU Throughput
e_X_g = [0, 0, 0, 0;   % idle
         0, 0, 0, 0;   % cpu
         0, 0, 0, 0;   % i/o
         0, 1, 0, 0];  % gpu

X_gpu = 0;
for i = 1:4
    temp = 0;
    for j = 1:4
        if i ~= j
            temp = temp + Q(i,j) * e_X_g(i,j);
        end
    end
    X_gpu = X_gpu + pi(i) * temp;
end


% I/O Throughput
e_X_io = [0, 0, 0, 0;   % idle
          0, 0, 0, 0;   % cpu
          0, 1, 0, 0;   % i/o
          0, 0, 0, 0];  % gpu

X_io = 0;
for i = 1:4
    temp = 0;
    for j = 1:4
        if i ~= j
            temp = temp + Q(i,j) * e_X_io(i,j);
        end
    end
    X_io = X_io + pi(i) * temp;
end

plot(t, sol*(pi*e_X_s')', t, sol*(pi*e_X_g')', t, sol*(pi*e_X_io')');
legend("System Throughput", "GPU Throughput", "I/O Throughput");