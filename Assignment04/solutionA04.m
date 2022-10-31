clear all
clc
format long

global M1;
global M2;
global M3;
global trace;

data = readmatrix("Traces.csv");
sizeData = size(data,1);

trace = 1;

M1 = mean(data);
M2 = mean(data .^2);
M3 = mean(data .^3);

sortData = sort(data(:,trace));
cv = std(data(:, trace)) / M1(:, trace);


% METHOD OF MOMENTS

% --- UNIFORM ---
Unif_a = M1(trace) - sqrt(12*(M2(trace) - M1(trace).^2))/2;
Unif_b = M1(trace) + sqrt(12*(M2(trace) - M1(trace).^2))/2;
x = linspace(min(data(:,trace)), max(data(:,trace)), sizeData);
Unif_cdf = [];
for i = 1:sizeData 
    if(x(i) < Unif_a)
        Unif_cdf(end + 1) = 0;
    elseif(x(i) > Unif_b)
        Unif_cdf(end + 1) = 1;
    else
        Unif_cdf(end + 1) = (x(i) - Unif_a) / (Unif_b - Unif_a);
    end
end


% --- EXPONENTIAL ---
Exp_lambda_MM = 1 / M1(trace); 
Exp_cdf = 1 - exp(- Exp_lambda_MM * x);


% --- 2 STAGES HYPER-EXPONENTIAL ---
mhe = false;
if cv >= 1
    mhe = true;
    HE_pars_MM = fsolve(@HyperExp, [0.5, 0.5, 0.5]);
    Hyper_cdf = 1 - HE_pars_MM(3) * exp(- x * HE_pars_MM(1)) - (1 - HE_pars_MM(3)) * exp(- x * HE_pars_MM(2));
end


% 2 STAGES HYPOEXPONENTIAL
mho = false;
if cv <= 1
    mho = true;
    HYPO_param_MM = fsolve(@HypoExp, [0.5, 0.6]);
    l1_MM = HYPO_param_MM(1);
    l2_MM = HYPO_param_MM(2);
    Hypo_cdf = 1 - l2_MM * exp(- l1_MM * x) / (l2_MM - l1_MM) + l1_MM * exp(- l2_MM * x) / (l2_MM - l1_MM);
end


t = tiledlayout(1,2);
nexttile
plot(sortData, [1:sizeData]/sizeData, ".", x, Unif_cdf, "x")
hold on
plot(sortData, [1:sizeData]/sizeData, ".", x, Exp_cdf, '+')
if mhe == true
    plot(sortData, [1:sizeData]/sizeData, ".", x, Hyper_cdf, '-')
end
if mho == true
    plot(sortData, [1:sizeData]/sizeData, ".", x, Hypo_cdf, '*')
end
hold off

if mhe == true
    legend('Trace', 'Uniform', 'Exponential', 'Hyper-Exponential');
else
    legend('Trace', 'Uniform', 'Exponential', 'Hypo-Exponential');
end


% ---------------------------------------------------------------------------------------------------------------


% MAXIMUM LIKELIHOOD

% --- UNIFORM ---
a_ML = min(data(:,trace));
b_ML = max(data(:,trace));
Unif_cdf = [];
for i = 1:sizeData 
    if(x(i) < a_ML)
        Unif_cdf(end + 1) = 0;

    elseif(x(i) > b_ML)
        Unif_cdf(end + 1) = 1;
    
    else
        Unif_cdf(end + 1) = (x(i) - a_ML) / (b_ML - a_ML);
    end
end


%EXPONENTIAL
Exp_lambda_ML = 1 / M1(trace); 
Exp_cdf = 1 - exp(- Exp_lambda_ML * x); 


% 2 STAGES HYPER
lhe = false;
if cv >= 1
    lhe = true;
    HyperExp_pars_ML = mle(data(:,trace), 'pdf', @HyperExp_pdf, 'start', [0.5, 0.5, 0.5], 'LowerBound', [0,0,0], 'UpperBound', [Inf, Inf, 1]);
    Hyper_cdf = 1 - HyperExp_pars_ML(3) * exp(- x * HyperExp_pars_ML(1)) - (1 - HyperExp_pars_ML(3)) * exp(- x * HyperExp_pars_ML(2));
end


% 2 STAGES HYPOEXPONENTIAL
lho = false;
if cv <= 1
    lho = true;
    HypoExp_param_ML = mle(data(:,trace), 'pdf', @HypoExp_pdf, 'start', [0.5, 0.6], 'LowerBound', [0,0], 'UpperBound', [Inf, Inf]);
    l1_ML = HypoExp_param_ML(1);
    l2_ML = HypoExp_param_ML(2);
    Hypo_cdf = 1 - l2_ML * exp(- l1_ML * x) / (l2_ML - l1_ML) + l1_ML * exp(- l2_ML * x) / (l2_ML - l1_ML);
end

nexttile
hold on
plot(sortData, [1:sizeData]/sizeData, ".", x, Exp_cdf, '+')
if lhe == true
    plot(sortData, [1:sizeData]/sizeData, ".", x, Hyper_cdf, '-')
end
if lho == true
    plot(sortData, [1:sizeData]/sizeData, ".", x, Hypo_cdf, '*')
end
hold off

if lhe == true
    legend('Trace', 'Exponential', 'Hyper-Exponential');
else
    legend('Trace', 'Exponential', 'Hypo-Exponential');
end