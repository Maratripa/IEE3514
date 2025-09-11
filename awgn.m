function [n_i, n_q, ei, eq] = awgn(EbNo, N, ei0, eq0, M)
  snr = 1/sqrt(log2(M)*2*10^(EbNo / 10));

  [ni ei] = randg(N, ei0);
  [nq eq] = randg(N, eq0);

  n_i = snr .* ni;
  n_q = snr .* nq;
end
