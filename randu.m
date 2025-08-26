function [u, eN] = randu2(N, e0)
  powers = (7^5).^(1:N);
  powers_mod = powers - floor(powers/(2^31 - 1))*(2^31-1);
  
  u = (powers_mod*e0)/(2^31 - 1) - floor(powers_mod*e0/(2^31-1));
  eN = u(N)*(2^31-1);
end
