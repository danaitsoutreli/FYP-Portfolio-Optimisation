function [Actual_Returns,Predicted_Returns_FLM_actual,Predicted_Returns_FLM_est] = Kalman_Filter_Estimation(A,B,Q,E,X,Y,G,Days,FLM_actual,FLM_est,m,u)

% FLM(actual)
[Actual_Returns, Predicted_Returns_FLM_actual] = Kalman_Filter_Procedure(A,B,Q,G,E,X,Y,Days,FLM_actual,m,u);
% Actual_Returns - Actual Returns with FLM_actual
% Predicted_Returns_FLM_actual - Estimated Returns with FLM_actual

% FLM(estimated)
[~, Predicted_Returns_FLM_est] = Kalman_Filter_Procedure(A,B,Q,G,E,X,Y,Days,FLM_est,m,u);
% Predicted_Returns_FLM_est - Estimated Returns with FLM_est

end