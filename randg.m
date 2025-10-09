function [g, eN] = randg(N, e0)
  g = zeros(1, N);
  n = 1;
  eN = e0;
  
  while n <= N
    [u, eN] = randu2(N, eN);

    s = (2*u(batch_i) - 1)^2 + (2*u(batch_i + 1) - 1)^2;

    if s < 1
      g(n) = (2*u(1) - 1)*sqrt(-2*log(s)/s);
      n = n + 1;
    end
  end
end