function [Actual_Returns,Predicted_Returns_FLM_actual,Predicted_Returns_FLM_est, Returns_Error_FLM_actual, Returns_Error_FLM_est, Error_FLM, FLM_actual, FLM_est] = Returns_Estimation(p,n,k,m,Days,A,B,C,D,~,Q,H,u,w,v,E,G)

% Initialisations
X(:,1) = [u(:,1); zeros(k*p,1)]; % Initial State

Y = zeros(size(v,1),Days-1); % Y: asset returns

% Dynamic Model:
% X(t) = AX(t-1) + Bu(t-1) + Gw(t-1)
% Y(t-1) = Cx(t-1) + Du(t-1) + V(t-1) + Hw(t-1)
for t = 2:Days   
    X(:,t)   = A*X(:,t-1)+B*u(:,t-1)+G*w(:,t-1);
    Y(:,t-1) = C*X(:,t-1)+D*u(:,t-1)+H*w(:,t-1)+v(:,t-1);
end

Yhat = Y;
Xhat = X; 
Xhat(:,end)=[];
FLM_actual = C;

[FLM_est] = FLM_Estimation(Yhat,Xhat,A,B,G,H,u,w,v,m,n,k);

% Kalman Filter Estimation Method
[Y_actual_FLM_actual,Predicted_Returns_FLM_actual,Predicted_Returns_FLM_est] = Kalman_Filter_Estimation(A,B,Q,E,X,Y,G,Days,FLM_actual,FLM_est,m,u);

% Normalised Returns
Actual_Returns = norm(Y_actual_FLM_actual); 
Predicted_Returns_FLM_actual = norm(Predicted_Returns_FLM_actual);
Predicted_Returns_FLM_est = norm(Predicted_Returns_FLM_est);

% Normalised Errors
Returns_Error_FLM_actual = norm(Actual_Returns-Predicted_Returns_FLM_actual)/norm(Actual_Returns);
Returns_Error_FLM_est = norm(Actual_Returns-Predicted_Returns_FLM_est)/norm(Actual_Returns);

Error_FLM = norm(FLM_actual-FLM_est)/norm(C);

end