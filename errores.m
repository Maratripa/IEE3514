function [Err_s, Err_b] = errores(enviado, recibido, M)

  Err_b = sum(bitxor(enviado, recibido));

  tx_i, tx_q = qammod(enviado, M);
  rx_i, rx_q = qammod(recibido, M);

  Err_s = sum(bitor(bitxor(tx_i, rx_i), bitxor(tx_q, rx_q)));
end
