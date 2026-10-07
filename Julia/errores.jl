function errores(enviado, recibido, N)
    dif = enviado .!= recibido[1:length(enviado)]
    Err_b = sum(dif)
    Err_s = sum(any(reshape(dif, Int(log2(M)), :), dims=1))
    return Err_s, Err_b
end
