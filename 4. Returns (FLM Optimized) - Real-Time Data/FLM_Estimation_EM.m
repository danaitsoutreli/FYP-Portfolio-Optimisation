function [FLM, States, Mean_Square_Error] = FLM_Estimation_EM(Returns, m)

% Expectation Maximisation Algorithm 
% Returns:(nxDays)
% States: (mxDays)
% FLM:    (nxm)

n = size(Returns,1);
Mean_Returns = mean(Returns,2);
Returns = bsxfun(@minus,Returns,Mean_Returns);

FLM = rand(n,m);
tolerance = 1e-6;
Mean_Square_Error = inf;

Iterations = 250;
for i = 1:Iterations
    % (X - Step)
    States = (FLM'*FLM)\(FLM'*Returns);
    % (C - Step)
    FLM = (Returns*States')/(States*States');

    Last_Mean_Square_Error = Mean_Square_Error;
    Error = Returns-FLM*States;
    Mean_Square_Error = mean(dot(Error(:),Error(:)));

    if abs(Last_Mean_Square_Error-Mean_Square_Error)<Mean_Square_Error*tolerance
        break;
    end
end

end