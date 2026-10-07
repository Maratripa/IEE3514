function [Err_s, Err_b] = errores(enviado, recibido, M)

  dif = enviado ~= recibido(1:length(enviado));
  Err_b = sum(dif);

  Err_s = sum(any(reshape(dif, log2(M), []), 1));
end
