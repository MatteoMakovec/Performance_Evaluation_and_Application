clear all
format long

files = ["apache1.log" "apache2.log"];
disp("----------------------------------------");
for z=1:size(files, 2)
    % Load log file
    AC = readtable(files(z));
    
    % Timestamps preprocessing
    ts = AC(:,4);
    DataTable = string(ts{:,1});
    newDataTable = extractAfter(DataTable,"[");
    AC.Var4 = datetime (newDataTable, 'Format', 'dd/MMM/yyyy:H:mm:ss.SSS');
    
    % Number of completions
    nC = size(AC, 1);
    
    % Number of arrivals
    nA = nC;
    
    % Completion time
    AC.CT(1) = AC.Var4(1) + milliseconds(table2array(AC(1,11)));
    for i=2:nC
        AC.CT(i) = max(AC.CT(i-1),AC.Var4(i)) + milliseconds(table2array(AC(i,11)));
    end
    
    % Period
    T = seconds(seconds(diff(datetime([AC.Var4(1);AC.CT(end)]))));
    
    % Throughput
    X = nC/seconds(T);
    
    % Average inter-arrival time
    A_mean = T/nA;
    
    % Busy time
    B = sum(milliseconds(table2array(AC(:,11))));
    
    % Utilization time
    U = B/T;
    
    % Average service time
    S  = seconds(B/nC);
    
    % Response time
    ri = seconds(AC.CT(:) - AC.Var4(:));
    
    % Average response time
    R = sum(ri) / nC;
    
    % Number of jobs
    N = X * R;
    
    % Difference between arrivals and departures
    W = N * T;

    % Probability of having m jobs in the web server
    timestamps = AC(:, 4);
    for i=1:nC
        timestamps(nC+i, 1) = AC(i, 12);
    end
    oness = ones(size(AC,1),1);
    for i=1:nC
        oness(nC+i, 1) = -1;
    end
    comb = [timestamps, array2table(oness)];
    comb = sortrows(comb, 1);
    NofT = cumsum(table2array(comb(:,2)));
    dT = seconds(table2array(comb(2:end, 1)) - table2array(comb(1:end-1,1)));
    Y0 = sum(dT .* (NofT(1:end-1, :) == 0))/seconds(T);
    Y1 = sum(dT .* (NofT(1:end-1, :) == 1))/seconds(T);
    Y2 = sum(dT .* (NofT(1:end-1, :) == 2))/seconds(T);
    Y3 = sum(dT .* (NofT(1:end-1, :) == 3))/seconds(T);

    % Probability of having ri less than t
    P_less1 = sum(ri<1) / nC;
    P_less5 = sum(ri<5) / nC;
    P_less10 = sum(ri<10) / nC;
    
    
    % FINAL OUTPUTS
    fprintf('File: %s\n', files(z));
    fprintf('Throughput: %.4f req/sec\n', X); 
    fprintf('Average inter-arrival rate: %.6s\n', A_mean);
    fprintf('Busy time: %.7s\n', B);
    fprintf('Utilization: %.4f\n', U);
    fprintf('W: %.7s\n', W);
    fprintf('Average service time: %.6s \n', seconds(S));
    fprintf('Number of jobs: %.4f\n', N);
    fprintf('Average response time: %.6s\n', seconds(R));
    fprintf('Probability of having m jobs in the web server with m = 0: %.4f\n', Y0);
    fprintf('Probability of having m jobs in the web server with m = 1: %.4f\n', Y1);
    fprintf('Probability of having m jobs in the web server with m = 2: %.4f\n', Y2);
    fprintf('Probability of having m jobs in the web server with m = 3: %.4f\n', Y3);
    fprintf('Probability of having a response time less than t = 1s: %.4f\n', P_less1);
    fprintf('Probability of having a response time less than t = 5s: %.4f\n', P_less5);
    fprintf('Probability of having a response time less than t = 10s: %.4f\n', P_less10);
    disp("----------------------------------------");
end