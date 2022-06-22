function [Actual_Returns,Predicted_Returns, Returns_Error] = Returns_Estimation_Real_Data_Optimized(n,k,m,Days,A,B,D,Q,R,u,G,Y,X,N,Level_of_noise)

[~, v, E] = Indiosyncratic_component_generation(N,Q,R,Level_of_noise,m,n);

if Days <= 20
%FLM Estimation - CVX Optimisation
if N > 20
    day = 20;
else 
    day = N; 
end
Yhat = Y(1:n,1:day);
Xhat = X(1:m,1:day);
uhat = u(1:k,1:day);
vhat = v(1:n,1:day);
[FLM_CVX_EM] = FLM_Estimation_CVX(Yhat,Xhat,A,B,G,uhat,vhat,m,n,k);
[Actual_Returns,Predicted_Returns] = Kalman_Filter_Procedure_Real_Data(A,B,Q,G,E,Y,Days,FLM_CVX_EM,m,uhat);
end

if Days > 20
% FLM Estimation - Expectation Maximization Algorithm
[FLM_CVX_EM] = FLM_Estimation_EM(Y, m);
[Actual_Returns,Predicted_Returns] = Kalman_Filter_Procedure_Real_Data(A,B,Q,G,E,Y,Days,FLM_CVX_EM,m,u);
end

Actual_Returns = norm(Actual_Returns);
Predicted_Returns = norm(Predicted_Returns);
Returns_Error = norm(Actual_Returns-Predicted_Returns)/norm(Actual_Returns);

end