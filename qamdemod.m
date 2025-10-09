function [out] = qamdemod(rx_i, rx_q, M)
  switch M
    case 2
      out = rx_i > 0;
    case 4
      % think of out(1:2:N) = rx_i > 0
      %          out(2:2:N) = rx_q > 0
      bit_matrix = [rx_i > 0; rx_q > 0];
      out = reshape(bit_matrix, 1, []);
    case 16
      constellation = [-3 -1 1 3]';
      rx_i_norm = rx_i * sqrt(10);
      rx_q_norm = rx_q * sqrt(10);
      [~, indices_i] = min(abs(rx_i_norm - constellation));
      [~, indices_q] = min(abs(rx_q_norm - constellation));

      bits_matrix = [0 0 1 1; 0 1 1 0];

      bits_i = bits_matrix(:, indices_i);
      bits_q = bits_matrix(:, indices_q);
      out = reshape([bits_i; bits_q], 1, []);
    case 64
      constellation = [-7 -5 -3 -1 1 3 5 7]';
      rx_i_norm = rx_i * sqrt(42);
      rx_q_norm = rx_q * sqrt(42);
      [~, indices_i] = min(abs(rx_i_norm - constellation));
      [~, indices_q] = min(abs(rx_q_norm - constellation));

      bits_matrix = [0 0 0 0 1 1 1 1; 0 0 1 1 1 1 0 0; 0 1 1 0 0 1 1 0];

      bits_i = bits_matrix(:, indices_i);
      bits_q = bits_matrix(:, indices_q);
      out = reshape([bits_i; bits_q], 1, []);
    otherwise
      error("Error. M (%d) no es un valor M-ario soportado.", M);
  end
end
