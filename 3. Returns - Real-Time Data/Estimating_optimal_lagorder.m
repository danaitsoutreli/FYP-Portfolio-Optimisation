function [lagorder_max, lagorder_avg, lagorder_range] = Estimating_optimal_lagorder(N,k)

% Estimating Optimal Maximum lag-order
cvx_begin sdp quiet 
cvx_precision low

variable lagorder nonnegative;
variable lagorder_max nonnegative;

maximize (lagorder_max)
subject to
    lagorder_max <= N;
    lagorder_max <= ((N-1)/k)-1;

cvx_end 

lagorder_max = round(lagorder_max);

if lagorder_max == 0
    lagorder_max = 1;
end

% Estimating Optimal lag-order range
lagorder_range = (1:1:lagorder_max);

lagorder_avg = round(mean(lagorder_range));

end