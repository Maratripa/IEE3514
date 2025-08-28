function [g eN] = randg(N, e0)
  g = zeros(1, N);
  eN = e0;
  n = 1;
  u = zeros(1, 2);

  while n <= N
    u(1) = mod(7^5 * eN, 2^31 - 1);
    u(2) = mod(7^5 * u(1), 2^31 - 1);
    eN = u(2);
    u = u ./ (2^31 - 1);

    s = (2*u(1) - 1)^2 + (2*u(2) - 1)^2;

    if s < 1
      g(n) = (2*u(1) - 1)*sqrt(-2*log(s)/s);
      n = n + 1;
    end
  end
end
