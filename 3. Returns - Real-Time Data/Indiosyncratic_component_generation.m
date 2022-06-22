function [what,vhat,E] = Indiosyncratic_component_generation (N,Q,R,Level_of_noise,m,n)

q = m;
r = n;

R = Level_of_noise*R*randn(r,r);
E = (R*R')+(R*R'); % Symmetric Positive Definite

T = (2:N+1); % T: Time Period

for i = 1:N
    Days = T(i);
    what = zeros(m,Days-1); 
    vhat = zeros(n,Days-1);
    
    for updated_days = 1:(N-1)
        what(:,updated_days) = Q*randn(q,1); % w(mx1)
        vhat(:,updated_days) = R*randn(r,1); % V(nx1)
    end
end


end
