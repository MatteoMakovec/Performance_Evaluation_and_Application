clc
format long

files = ["Data1.txt" "Data2.txt" "Data3.txt" "Data4.txt"];
disp("----------------------------------------");
for z=1:size(files, 2)
    data = readtable(files(z));
    data.Properties.VariableNames = ["Inter Arrivals"];
    N = size(data,1);
    
    % First 5 moments
    EX1 = sum(data.("Inter Arrivals")) / N;
    EX2 = sum(data.("Inter Arrivals") .^ 2) / N;
    EX3 = sum(data.("Inter Arrivals") .^ 3) / N;
    EX4 = sum(data.("Inter Arrivals") .^ 4) / N;
    EX5 = sum(data.("Inter Arrivals") .^ 5) / N;
    
    % First 5 centered moments
    EX2_centered = sum((data.("Inter Arrivals") - EX1) .^ 2) / N;
    EX3_centered = sum((data.("Inter Arrivals") - EX1) .^ 3) / N;
    EX4_centered = sum((data.("Inter Arrivals") - EX1) .^ 4) / N;
    EX5_centered = sum((data.("Inter Arrivals") - EX1) .^ 5) / N;
    
    % First 5 standardized moments
    standard_deviation = sqrt(EX2_centered);
    EX3_standardized = sum(((data.("Inter Arrivals") - EX1)/standard_deviation) .^ 3) / N;
    EX4_standardized = sum(((data.("Inter Arrivals") - EX1)/standard_deviation) .^ 4) / N;
    EX5_standardized = sum(((data.("Inter Arrivals") - EX1)/standard_deviation) .^ 5) / N;
    
    % Coefficient of variation
    cv = standard_deviation / EX1;
    
    % Excess Kurtosis
    kurtosis = EX4_standardized - 3;
    
    
    % Percentiles
    sorted_data = sort(data.("Inter Arrivals"));
    
    h = 0.1 * N;
    p10 = sorted_data(floor(h)) + (h - floor(h)) * (sorted_data(floor(h)+1) - sorted_data(floor(h)));
    
    h = 0.25 * N;
    p25 = sorted_data(floor(h)) + (h - floor(h)) * (sorted_data(floor(h)+1) - sorted_data(floor(h)));
    
    h = 0.50 * N;
    p50 = sorted_data(floor(h)) + (h - floor(h)) * (sorted_data(floor(h)+1) - sorted_data(floor(h)));
    
    h = 0.75 * N;
    p75 = sorted_data(floor(h)) + (h - floor(h)) * (sorted_data(floor(h)+1) - sorted_data(floor(h)));
    
    h = 0.90 * N;
    p90 = sorted_data(floor(h)) + (h - floor(h)) * (sorted_data(floor(h)+1) - sorted_data(floor(h)));
    
    % Cross-covariance
    A = table2array(data);
    cov1 = sum((A(1:N-1)-EX1) .* (A(2:N)-EX1)) / (N-1);
    cov2 = sum((A(1:N-2)-EX1) .* (A(3:N)-EX1)) / (N-2);
    cov3 = sum((A(1:N-3)-EX1) .* (A(4:N)-EX1)) / (N-3);
    
    % Pearson correlation
    pearson1 = sum((A(1:N-1)-EX1) .* (A(2:N)-EX1)) / (N-1) ./ (standard_deviation .^ 2);
    pearson2 = sum((A(1:N-2)-EX1) .* (A(3:N)-EX1)) / (N-2) ./ (standard_deviation .^ 2);
    pearson3 = sum((A(1:N-3)-EX1) .* (A(4:N)-EX1)) / (N-3) ./ (standard_deviation .^ 2);
    
    
    % OUTPUTS
    fprintf("FILE: %s\n", files(z))
    fprintf("First moment: %f\n", EX1);
    fprintf("Second moment: %f\n", EX2);
    fprintf("Third moment: %f\n", EX3);
    fprintf("Fourth moment: %f\n", EX4);
    fprintf("Fifth moment: %f\n", EX5);
    fprintf("Second centered moment: %f\n", EX2_centered);
    fprintf("Third centered moment: %f\n", EX3_centered);
    fprintf("Fourth centered moment: %f\n", EX4_centered);
    fprintf("Fifth centered moment: %f\n", EX5_centered);
    fprintf("Third standardized moment: %f\n", EX3_standardized);
    fprintf("Fourth standardized moment: %f\n", EX4_standardized);
    fprintf("Fifth standardized moment: %f\n", EX5_standardized);
    fprintf("Standard deviation: %f\n", standard_deviation);
    fprintf("Coefficient of variation: %f\n", cv);
    fprintf("Kurtosis: %f\n", kurtosis);
    fprintf("10-percentile: %f\n", p10);
    fprintf("25-percentile: %f\n", p25);
    fprintf("50-percentile: %f\n", p50);
    fprintf("75-percentile: %f\n", p75);
    fprintf("90-percentile: %f\n", p90);
    fprintf("Cross coviariance m=1: %f\n", cov1);
    fprintf("Cross coviariance m=2: %f\n", cov2);
    fprintf("Cross coviariance m=3: %f\n", cov3);
    fprintf("Pearson correlation m=1: %f\n", pearson1);
    fprintf("Pearson correlation m=2: %f\n", pearson2);
    fprintf("Pearson correlation m=3: %f\n", pearson3);
    disp("----------------------------------------");
end


% Plots
t = tiledlayout(2,2);
for h=1:size(files, 2)
    AD = readtable(files(h));
    N = size(AD,1);
    sAD = sort(AD.Var1);
    nexttile
    plot(sAD, (1:N)/N, "+")
end