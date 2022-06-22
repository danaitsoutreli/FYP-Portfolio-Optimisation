function [Y_Actual_Returns, Y_Predicted_Returns] = Kalman_Filter_Procedure(A,B,Q,G,E,X,Y,Days,FLM,m,u)

X_p(:,1) = zeros(m,1); % Predicted State Estimate Xp
X_c(:,1) = zeros(m,1); % Corrected State Estimate Xc

P_p(:,:,1) = eye(m,m);

for t = 2:Days
    
    % Kalman Gain Estimation
    % K = P_p(:,:,t-1)*FLM'*inv(FLM*P_p(:,:,t-1)*FLM'+E); 
    K = (P_p(:,:,t-1)*FLM')/(FLM*P_p(:,:,t-1)*FLM'+E);
   
    % Auto-covariance of corrected state estimate error
    P_p(:,:,t) = A*A' - A*K*FLM*P_p(:,:,t-1)*A' + G*Q*G';

    X_p(:,t)   = A*(eye(m,m)-K*FLM)*X_p(:,t-1) + A*K*Y(:,t-1) + B*u(:,t-1);

    X_c(:,t-1) =   (eye(m,m)-K*FLM)*X_p(:,t-1) +   K*Y(:,t-1);    

    if t == Days
        Y_Actual_Returns = FLM*X(:,end-1); 
        Y_c = FLM*X_c(:,t-1); %Y_c
        Y_Predicted_Returns = Y_c;

    end

end

end
