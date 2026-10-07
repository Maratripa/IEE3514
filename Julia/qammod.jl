function qammod(mensaje, M)
    if M == 2
        return 2 .* mensaje .- 1, zeros(length(mensaje))
    elseif M == 4
        return (2 .* mensaje[1:2:end] .- 1) ./ sqrt(2),
               (2 .* mensaje[2:2:end] .- 1) ./ sqrt(2)
    elseif M == 16 || M == 64
        k = Int(log2(M)) / 2
        c, s = M == 16 ? ([-3, -1, 3, 1], sqrt(10)) :
                         ([-7, -5, -1, -3, 7, 5, 1, 3], sqrt(42))
        b = Int.(reshape(mensaje, 2k, :))
        w = 2 .^ (k-1:-1:0)
        di = vec(w' * b[1:k, :])
        dq = vec(w' * b[k+1:end, :])
        return c[di .+ 1] ./ s, c[dq .+ 1] ./ s
    else
        error("Error. M ($M) no es un valor M-ario soportado.")
    end
end
