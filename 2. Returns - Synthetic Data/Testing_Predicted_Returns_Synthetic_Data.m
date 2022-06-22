%% Returns Estimation - Synthetic Data

clc;
clear;
close all;

% Set the control random number generator
rng('default');

% Parameter Initialisation
n = 10; % n: Number of assets/portfolio Size
k = 2;  % k: Number of factors affecting the asset portfolio
N = 60; % N: Number of Days
T = (2:N+1); % T: Time Period

p = 1; % Lag Order
m = k*(p+1); % m: number of factors x (lag-order + 1)
q = m;
r = n;

% Inputs:
% Yhat(nxT): asset returns
% Xhat(mxT): dynamic factors

% Matrix Initialisations
% A(mxm): weight transition model – state transition matrix
% B(mxk): control input matrix
% G(qxq): process noise gain matrix
% C(nxm): covariance matrix - factor loading matrix
% D(nxm): zero control matrix
% H(nxm): gain matrix
% Q(kxk): process noise covariance matrix
% R(mxm): measurement noise covariance matrix

A = [zeros(k,m-k),zeros(k,k);eye(k*p),zeros(m-k,k)]; 
B = eye(m,k);
G = eye(q,q);
C = randn(n,m); 
D = zeros(n,k);
H = zeros(n,m);

% Noise and Indiosyncratic Component
Level_of_noise = 0.5;
Q = eye(q,q);
R = Level_of_noise*randn(r,r); 
% Variance of the noise level
E = (R*R')+(R*R'); % Symmetric Positive Definite

% Preallocating Zero Values
Actual_Returns = zeros();
Predicted_Returns_FLM_actual = zeros();
Predicted_Returns_FLM_est = zeros();
Returns_Error_FLM_actual = zeros();
Returns_Error_FLM_est = zeros();
Normalised_FLM_error = zeros();

% Estimation method
for i = 1:N
    Days = T(i);

    u = zeros(k,Days-1); % u: contol input
    w = zeros(m,Days-1); 
    v = zeros(n,Days-1);
    
    for updated_days = 1:(Days-2)
        u(:,updated_days) = B(k,k)*randn(k,1); % u(kx1)
        w(:,updated_days) = Q*randn(m,1); % w(mx1)
        v(:,updated_days) = R*randn(n,1); % V(nx1)
    end

    [Actual_Returns(:,i),Predicted_Returns_FLM_actual(:,i),Predicted_Returns_FLM_est(:,i), Returns_Error_FLM_actual(:,i), Returns_Error_FLM_est(:,i), Normalised_FLM_error(:,i), FLM_actual, FLM_est] = Returns_Estimation(p,n,k,m,Days,A,B,C,D,R,Q,H,u,w,v,E,G);

end 

% Normalised Returns - Plot
Returns_Plot(Actual_Returns,Predicted_Returns_FLM_actual,Predicted_Returns_FLM_est,n,k,Level_of_noise,N);

% Normalised Returns Error - Plot
Returns_Error_Plot(Returns_Error_FLM_actual, Returns_Error_FLM_est, N, n, k, Level_of_noise)

% Factor Loading Matrix Estimation Error - Plot
FLM_Error_Plot (Normalised_FLM_error,n,k,Level_of_noise,N);