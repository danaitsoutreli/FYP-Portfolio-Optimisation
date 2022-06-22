function [Actual_Returns,Predicted_Returns_CVX, Predicted_Returns_EM, Returns_Error_CVX, Returns_Error_EM]= Returns_Estimation_Real_Data(n,k,m,Days,A,B,D,Q,R,u,G,Y,X,N,Level_of_noise)

Yhat = Y;
Xhat = X;
uhat = u;

[~, vhat, E] = Indiosyncratic_component_generation(N,Q,R,Level_of_noise,m,n);

% FLM Estimation - CVX Optimisation
[FLM_CVX] = FLM_Estimation_CVX(Yhat,Xhat,A,B,G,D,uhat,vhat,m,n,k);
[Actual_Returns,Predicted_Returns_CVX] = Kalman_Filter_Procedure_Real_Data(A,B,Q,G,E,Y,Days,FLM_CVX,m,uhat);

% FLM Estimation - Expectation Maximization Algorithm
[FLM_EM] = FLM_Estimation_EM(Y, m);
[~, Predicted_Returns_EM] = Kalman_Filter_Procedure_Real_Data(A,B,Q,G,E,Y,Days,FLM_EM,m,uhat);

Actual_Returns = norm(Actual_Returns);
Predicted_Returns_CVX = norm(Predicted_Returns_CVX);
Predicted_Returns_EM = norm(Predicted_Returns_EM);

Returns_Error_CVX = norm(Actual_Returns-Predicted_Returns_CVX)/norm(Actual_Returns);
Returns_Error_EM = norm(Actual_Returns-Predicted_Returns_EM)/norm(Actual_Returns);

end