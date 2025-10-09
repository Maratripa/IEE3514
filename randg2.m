function [g, eN] = randg2(N, e0)
  g = zeros(1, N);
  n = 1;

  [u, eN] = randu2(2*N, e0);
  batch_i = 1;
  
  while n <= N
    if batch_i > length(u)
        [u, eN] = randu2(2*(N - n + 1), eN);
        batch_i = 1;
    end

    s = (2*u(batch_i) - 1)^2 + (2*u(batch_i + 1) - 1)^2;

    if s < 1
      g(n) = (2*u(1) - 1)*sqrt(-2*log(s)/s);
      n = n + 1;
    end

    batch_i = batch_i + 2;
  end
end
