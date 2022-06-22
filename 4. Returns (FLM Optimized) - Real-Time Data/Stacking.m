function [Ax,Du,Dw,Dv] = Stacking(A,B,G,Days,m,n)

m_D = Days*m;
n_D = Days*n;

% Stacking matrix: Ax, Du, Dw
A0 = zeros(m_D,m);
Ax = zeros(m_D,m_D);
Bu = kron(eye(Days),B);
Gw = kron(eye(Days),G);
A2 = zeros(m_D,m_D);

for a = (1:Days)
    A0((m*(a-1)+1):m*a,1:m) = A^(a-1);
    Ax((m*(a-1)+1):m*a,(m*(a-1)+1):m*a) = A^(a-1);
end

for b = (1:Days-1)
    A2((m*b+1):end,(m*b+1)-m:m*b) = A0(1:m_D-m*b,:);
end

Du = A2*Bu;
Dw = A2*Gw;

% Stacking matrix: Dv
Dv = eye(n_D);

end