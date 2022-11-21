clc
format long


Tmax = 100000;
state = 1;
t = 0;
ts1 = 0;
ts2 = 0;
ts3 = 0;
ts4 = 0;
C = 0;

unif_a = 10;
unif_b = 20;

while t < Tmax
    if state == 1 
        dt = unif_a + (unif_b - unif_a) * rand();
        ts1 = ts1 + dt;

        if rand() < 0.2
            future_state = 4;
        elseif rand() < 0.3
            future_state = 3;
        else
            future_state = 2;
        end
    end

    if state == 2
        dt = - (log(rand()) + log(rand()) + log(rand())) / 0.1;
        ts2 = ts2 + dt;
        future_state = 1;
        C = C + 1;
    end

    if state == 3
        dt = - log(rand()) / 0.05;  
        ts3 = ts3 + dt;
        future_state = 2;
    end

    if state == 4
        dt = - log(rand()) / 0.03; 
        ts4 = ts4 + dt;
        future_state = 2;
    end

    state = future_state;
    t = t + dt;
end


Pr_state1 = ts1 / Tmax;
Pr_state2 = ts2 / Tmax;
Pr_state3 = ts3 / Tmax;
Pr_state4 = ts4 / Tmax;
Frequency = C / Tmax;

fprintf("Sensing Probability: %4f\n", Pr_state2);
fprintf("Using CPU Probability: %4f\n", Pr_state1);
fprintf("Turning on the Heat Pump Probability: %4f\n", Pr_state4);
fprintf("Turning on the Air Conditioning Probability: %4f\n", Pr_state3);
fprintf("Sensing Frequency: %4f\n", Frequency);