function [FLM] = FLM_Estimation(Yhat,Xhat,A,B,G,u,v,w,m,n,k,q,bound) 

[~,Days] = size(Xhat);

n_D = Days*n;
m_D = Days*m;
k_D = Days*k;

y = Dimension_transformation(Yhat);
x_0 = kron(ones(Days,1),Xhat(:,1));

u = Dimension_transformation(u);
w = Dimension_transformation(w);
v = Dimension_transformation(v);

[Ax,Du,Dw,Dv] = Stacking(A,B,G,Days,m,n);

% Matrix r
r = [x_0; u; w; v];

% r: Upper and lower bounds for r
bound = 0.001;
r_upper_bound = r+bound*abs(r);
r_lower_bound = r-bound*abs(r);

Ax  = [Ax ; zeros(n_D,m_D)];
Du  = [Du ; zeros(n_D,k_D)];
Dw  = [Dw ; zeros(n_D,m_D)];
Dv  = [zeros(m_D,n_D) ; Dv];

X = [Ax, Du, Dw, Dv];

% CVX
cvx_begin sdp quiet 
cvx_precision low

variable gamma2 nonnegative;
variable F(n,m);
variable R(Days*(m+q+k+n),Days*(m+q+k+n)) diagonal;

C = [kron(eye(Days),F), eye(n_D)];

% Schur Complement
L11 = y'*y-gamma2+r_lower_bound'*R*r_upper_bound;   %[1x1]
L12 = -y'*C*X-0.5*(r_upper_bound+r_lower_bound)'*R; %[1x(Days*(m+k+n))]
L13 = zeros(1,n_D);                                 %[1x(Days*n)]
L21 = L12';                                         %[(Days*(m+k+n))x1]
L22 = R;                                            %[(Days*(m+k+n))x(Days*(m+k+n))]
L23 = X'*C';                                        %[(Days*(m+k+n))x(Days*n)]
L31 = L13';                                         %[(Days*n)x1]
L32 = L23';                                         %[(Days*n)x(Days*(m+k+n))]
L33 = -eye(n_D);                                    %[(Days*n)x(Days*n)]

L = [L11, L12, L13;
     L21, L22, L23;
     L31, L32, L33]; 

minimize(gamma2)    
subject to
    R <= 0; 
    L <= 0;

FLM = F;
    
cvx_end 

end 