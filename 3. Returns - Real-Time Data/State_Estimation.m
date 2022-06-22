function [X] = State_Estimation (Factors,p,k,N)

Factors_Matrix = reshape(repmat(Factors',p,1),[],k*p)';

for i = 1:N
    X(:,i) = [Factors(:,i); Factors_Matrix(:,1)];
end

end