function [Err_s, Err_b] = errores(enviado, recibido, M)

  dif = enviado ~= recibido;
  Err_b = sum(dif);

  dif_sim = reshape(dif, log2(M), []);
  Err_s = sum(any(dif_sim, 1));
end
