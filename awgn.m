function [n_i, n_q, ei, eq] = awgn(EbNo, N, ei0, eq0)
  snr = 10^(EbNo / 10);

  [ni ei] = randg(N, ei0);
  [nq eq] = randg(N, eq0);

  n_i = sqrt(snr) .* ni;
  n_q = sqrt(snr) .* nq;
end
