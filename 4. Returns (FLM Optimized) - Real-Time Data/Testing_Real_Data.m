%% Testing Real Data - FLM(CVX,EM)

clc;
clear;
close all;

rng('default');

[Returns, Factors] = Real_Data();

% Parameter Initialisation
n = 10;  % n: Number of ats/portfolio Size
k = size(Factors,1); % k: Number of factors affecting the asset portfolio
N = 10; % N: Number of Days
T = (2:N+1); % T: Time Period

% Estimating Optimal Lag-order
% [p,~,~] = Estimating_optimal_lagorder(N,k);

p = 1;
m = k*(p+1); % m: number of factors x (lag-order + 1)
q = m;
r = n;

% Random Assets - (10 assets)
[FLM_actual] = FLM_Estimation_EM(Returns, m);
[Random_Asset_Range] = Random_Assets (n);
FLM_actual = FLM_actual(Random_Asset_Range,(1:m)); %(nxm)
Returns = Returns(Random_Asset_Range,(1:N)); %(nxN)
Factors = Factors(:,(1:N)); %(kxN)
States = State_Estimation (Factors,p,k,N); %(mxN)

A = [zeros(k,m-k),zeros(k,k);eye(k*p),zeros(m-k,k)]; 
B = eye(m,k);
G = eye(q,q);
D = zeros(n,k);
H = zeros(n,m);
Q = eye(q,q);
R = eye(r,r);
Level_of_noise = 0.5;

% Preallocating Zero Values
Actual_Returns = zeros();
Predicted_Returns = zeros();
Returns_Error = zeros();

% Predicting the returns
for i = 1:N
    Days = T(i);
    [Actual_Returns(:,i),Predicted_Returns(:,i), Returns_Error(:,i)] = Returns_Estimation_Real_Data_Optimized(n,k,m,Days,A,B,D,Q,R,Factors,G,Returns,States,N,Level_of_noise);
end

[Predicted_Returns] = Correction_NaN (Predicted_Returns,N);
[Returns_Error] = Correction_NaN (Returns_Error,N);

Average = mean(Returns_Error);

% Normalised Returns - Plot
Returns_Plot_Real_Data(Actual_Returns,Predicted_Returns,n,k,Level_of_noise, N);
% Normalised Returns Error - Plot
Returns_Error_Plot_Real_Data(Returns_Error,N,n,k,Level_of_noise);