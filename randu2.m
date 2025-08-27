function [u, eN] = randu2(e0)
  u = zeros(1, 2);

  u(1) = mod(7^5 * e0, 2^31 - 1);
  u(2) = mod(7^5 * u(1), 2^31 - 1);

  eN = u(2);
  u = u ./ (2^31 - 1);
end
