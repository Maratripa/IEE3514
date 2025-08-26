function [u, eN] = randu(N, e0)
  u = zeros(1, N);

  u(1) = mod(7^5 * e0, 2^31 - 1);

  for i=2:N
    u(i) = mod(7^5 * u(i-1), 2^31 - 1);
  end

  eN = u(N);
  u = u ./ (2^31 - 1);
end
