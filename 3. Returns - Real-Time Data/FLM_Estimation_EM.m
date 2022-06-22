function [FLM, States, MSE] = FLM_Estimation_EM(Returns, m)

% Expectation Maximisation Algorithm 
% Returns:(nxDays)
% States: (mxDays)
% FLM:    (nxm)
% MSE: Mean Square Error

n = size(Returns,1);
Mean_Returns = mean(Returns,2);
Returns = bsxfun(@minus,Returns,Mean_Returns);

FLM = rand(n,m);
tolerance = 1e-6;
MSE = inf;

Iterations = 250;
for i = 1:Iterations
    States = (FLM'*FLM)\(FLM'*Returns);
    FLM = (Returns*States')/(States*States');
    Last_MSE = MSE;
    V = Returns-FLM*States;
    MSE = mean(dot(V(:),V(:)));

    if abs(Last_MSE-MSE)<MSE*tolerance
        break;
    end
end

end