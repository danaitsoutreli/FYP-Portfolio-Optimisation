%% FLM Estimation - Synthetic Data

clc;
clear;
close all;

n = 10; % n: Number of assets/portfolio Size
k = 3;  % k: Number of factors affecting the asset portfolio
p = 1;  % p: lag-order
Days = 7; %Time
bound = 0.001;

m = k*(p+1); % m: number of factors x (lag-order + 1), factors influencing the asset returns
q = m;
r = n;

A = [zeros(k,m-k),zeros(k,k);eye(k*p),zeros(m-k,k)]; 
B = eye(m,k);
G = eye(q,q);
C = randn(n,m); 
D = zeros(n,k);
H = zeros(n,m);

% Noise and Indiosyncratic Component
Q = eye(q,q);
Level_of_noise = 0.5;
R = Level_of_noise*randn(r,r); 

u = zeros(k,Days-1);
w = zeros(q,Days-1);
v = zeros(n,Days-1);

for i = 1:(Days-2)
    u(:,i) = B(k,k)*randn(k,1); % u(kx1)
    w(:,i) = Q*randn(m,1); % w(mx1)
    v(:,i) = R*randn(n,1); % V(nx1)
end 

% Inital state
X(:,1) = [u(:,1); zeros(k*p,1)]; %(mx1) 

% Dynamic Model:
% X(t)   = AX(t-1) + Bu(t-1) + Gw(t-1)
% Y(t-1) = Cx(t-1) + Du(t-1) + Hw(t-1) + v(t-1)
for t = 2:Days   
    X(:,t)   = A*X(:,t-1) + B*u(:,t-1) + G*w(:,t-1);
    Y(:,t-1) = C*X(:,t-1) + D*u(:,t-1) + H*w(:,t-1) + v(:,t-1);
end

Yhat = Y; 
Xhat = X; 
Xhat(:,end)=[];

[FLM] = FLM_Estimation(Yhat,Xhat,A,B,G,u,v,w,m,n,k,q,bound);

% Average Error
Difference_abs = abs(C - FLM);
Error_Average_FLM = mean(Difference_abs, 'all');

% Normalised FLM Error
Error_Normalised_FLM = norm(C-FLM);
Error_Normalised_FLM = Error_Normalised_FLM/norm(C);