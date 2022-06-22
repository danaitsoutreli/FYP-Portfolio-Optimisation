function [Actual_Returns, Predicted_Returns] = Kalman_Filter_Procedure_Real_Data(A,B,Q,G,E,Y,Days,FLM,m,u)

X_p(:,1) = zeros(m,1); % Predicted State Estimate Xp
X_c(:,1) = zeros(m,1); % Corrected State Estimate Xc

P_p(:,:,1) = eye(m,m);

for t = 2:Days
    
    % Kalman Gain Estimation
    K = (P_p(:,:,t-1)*FLM')/(FLM*P_p(:,:,t-1)*FLM'+E);
   
    % Auto-covariance of corrected state estimate error
    P_p(:,:,t) = A*A' - A*K*FLM*P_p(:,:,t-1)*A' + G*Q*G';
    X_p(:,t)   = A*(eye(m,m)-K*FLM)*X_p(:,t-1) + A*K*Y(:,t-1) + B*u(:,t-1);
    X_c(:,t-1) =   (eye(m,m)-K*FLM)*X_p(:,t-1) +   K*Y(:,t-1);    

    if t == Days
        Predicted_Returns = FLM*X_c(:,t-1);

    end
    Actual_Returns = norm(Y(:,t-1));
    
end

end


