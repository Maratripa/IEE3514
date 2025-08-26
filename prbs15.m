function [prbs, eN] = prbs15(N, e0)
  prbs = zeros(1, N);
  eN = e0;

  for i=1:N
    prbs(i) = xor(eN(1), eN(15));
    eN = [prbs(i) eN(1:14)];
  end
end
