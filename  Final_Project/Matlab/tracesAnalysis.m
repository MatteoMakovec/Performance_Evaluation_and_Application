clear all
clc
format long

global M1;
global M2;
global M3;

% Data traces
files = ["TraceD-A.txt" "TraceD-B.txt" "TraceD-C.txt" "TraceD-D.txt"];

t = tiledlayout(2,2);
for z=1:size(files, 2)
    trace = readmatrix(files(z));

    % Compute interarrivals
    data = trace(2:end) - trace(1:end-1);
    
    % Compute moments
    M1 = mean(data);
    M2 = mean(data .^2);
    M3 = mean(data .^3);
    
    sizeData = size(data,1);
    sortData = sort(data(:,1));
    cv = std(data(:,1)) / M1(:,1);
    
    
    % --- UNIFORM distribution ---
    Unif_a = M1(1) - sqrt(12*(M2(1) - M1(1).^2))/2;
    Unif_b = M1(1) + sqrt(12*(M2(1) - M1(1).^2))/2;
    x = linspace(min(data(:,1)), max(data(:,1)), sizeData);
    Unif_cdf = [];
    for i = 1:sizeData 
        if(x(i) < Unif_a)
            Unif_cdf(end+1) = 0;
        elseif(x(i) > Unif_b)
            Unif_cdf(end+1) = 1;
        else
            Unif_cdf(end+1) = (x(i)-Unif_a) / (Unif_b-Unif_a);
        end
    end
    
    
    % --- EXPONENTIAL distribution ---
    Exp_lambda_MM = 1 / M1(1); 
    Exp_cdf = 1 - exp(-Exp_lambda_MM * x);
    
    
    % --- 2 STAGES HYPER-EXPONENTIAL distribution ---
    mhe = false;
    if cv >= 1
        mhe = true;
        HE_pars_MM = fsolve(@HyperExp, [0.5, 0.5, 0.5]);
        Hyper_cdf = 1 - HE_pars_MM(3) * exp(-x * HE_pars_MM(1)) - (1 - HE_pars_MM(3)) * exp(-x * HE_pars_MM(2));
    end
    
    
    % --- 2 STAGES HYPOEXPONENTIAL distribution ---
    mho = false;
    if cv <= 1
        mho = true;
        HYPO_param_MM = fsolve(@HypoExp, [0.5, 0.4]);
        l1_MM = HYPO_param_MM(1);
        l2_MM = HYPO_param_MM(2);
        Hypo_cdf = 1 - l2_MM * exp(-l1_MM * x) / (l2_MM - l1_MM) + l1_MM * exp(-l2_MM * x) / (l2_MM - l1_MM);
    end
    
    % Plotting
    nexttile
    plot(sortData, [1:sizeData]/sizeData, ".", x, Unif_cdf, "x")
    hold on
    plot(sortData, [1:sizeData]/sizeData, ".", x, Exp_cdf, '+')
    hold on
    if cv >= 1
        plot(sortData, [1:sizeData]/sizeData, ".", x, Hyper_cdf, '-')
        legend('Trace', 'Uniform', 'Exponential', 'Hyper-Exponential');
    else
        plot(sortData, [1:sizeData]/sizeData, ".", x, Hypo_cdf, '*')
        legend('Trace', 'Uniform', 'Exponential', 'Hypo-Exponential');
    end
    title(files(z))
    fprintf('File %s: Lambda=%.4f\n', files(z), Exp_lambda_MM*10^3);
end