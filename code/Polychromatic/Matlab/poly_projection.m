function [poly_prj] = poly_projection(prj, mus, iin)
% Function to calculate polychromatic projections from
% ray length data

num_e = size(mus);
tot_iin = sum(iin);

iout = zeros(size(prj));

for i = 1:num_e(1)
	  iout = iout + iin(i)*exp(-prj*mus(i));
end

poly_prj = -log(iout/tot_iin);
