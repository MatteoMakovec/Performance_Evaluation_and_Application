clear all
format long

files = ["Log1.csv" "Log2.csv" "Log3.csv" "Log4.csv"];
disp("----------------------------------------");
for z=1:size(files, 2)
    data = readtable(files(z));

    % Arrival time
    data.arrival_time(1) = 0;
    data.arrival_time(2:end) = cumsum(table2array(data(2:end, 1)));

    % Number of arrivals
    nA = size(data, 1);
    nC = nA;
    
    % Set service time and compute completion time
    service_time = 1.2;
    data.completion_time(1) = data.arrival_time(1) + service_time;
    for i=2:nC
        data.completion_time(i) = max(data.completion_time(i-1),data.arrival_time(i)) + service_time;
    end
    
    % Period
    T = seconds(data.completion_time(end) - data.arrival_time(1));
    
    % Average inter-arrival time
    A_mean = sum(data.Var1) / nA;
    
    % Arrival rate
    lambda = 1 / A_mean;
    
    % Standard deviation
    std_arrivals = std(data.Var1);
    
    % Average response time
    data.ri = data.completion_time - data.arrival_time;
    R = sum(data.ri) / nC;

    %datas = [datas, data.Var1];
    fig = scatter(data.Var1(1:end-1), data.Var1(2:end));
    
    % OUTPUTS
    fprintf("Average inter-arrival time: %f\n", A_mean);
    fprintf("Arrival rate: %f\n", lambda);
    fprintf("Standard deviation arrivals: %f\n", std_arrivals);
    fprintf("Average response time: %f\n", R);
    disp("----------------------------------------");
end

t = tiledlayout(2,2);
for h=1:size(files, 2)
    AD = readtable(files(h));
    nexttile
    scatter(AD.Var1(1:end-1), AD.Var1(2:end));
end