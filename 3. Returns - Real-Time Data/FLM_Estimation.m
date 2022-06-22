function [FLM] = FLM_Estimation(Yhat,Xhat,A,B,G,~,u,w,v,m,n,k)
% FLM: factor loading matrix

[~,Days] = size(Xhat); %(mxDays)
% Yhat = (mxDays)

n_D = Days*n;
m_D = Days*m;
k_D = Days*k;

y = Dimension_transformation(Yhat); %(nxDays)
x_0 = kron(ones(Days,1),Xhat(:,1)); %(mxDays)

u = Dimension_transformation(u); %(kxDays)
v = Dimension_transformation(v); %(nxDays)

[Ax,Du,~,Dv] = Stacking(A,B,G,Days,m,n);

% Matrix r (data)
r = [x_0; u; v]; 

% r: Upper and lower bounds for r
r_upper_bound = r+0.0001*abs(r);
r_lower_bound = r-0.0001*abs(r);

Ax  = [Ax ; zeros(n_D,m_D)]; % (140x90) = (
Du  = [Du ; zeros(n_D,k_D)]; % (140x30) = 
Dv  = [zeros(m_D,n_D) ; Dv]; % (140x50) 

X = [Ax, Du, Dv]; 

% CVX
cvx_begin sdp quiet 
cvx_precision low

variable gamma2 nonnegative;
variable F(n,m);
variable R(Days*(m+k+n),Days*(m+k+n)) diagonal;

C = [kron(eye(Days),F), eye(n_D)];

% Schur Complement
L11 = y'*y-gamma2+r_lower_bound'*R*r_upper_bound;   %[1x1]
L12 = -y'*C*X-0.5*(r_upper_bound+r_lower_bound)'*R; %[1x(Days*(m+k+n))]
L13 = zeros(1,n_D);                                 %[1x(Days*n)]
L22 = R;                                            %[(Days*(m+k+n))x(Days*(m+k+n))]
L23 = X'*C';                                        %[(Days*(m+k+n))x(Days*n)]                                       
L33 = -eye(n_D);                                    %[(Days*n)x(Days*n)]

L = [L11 , L12 , L13;
     L12', L22 , L23;
     L13', L23', L33];

minimize(gamma2);   
subject to
    R <= 0; 
    L <= 0;

FLM = F;

cvx_end 

end