function qamdemod(rx_i, rx_q, M)
    if M == 2
        return rx_i .> 0
    elseif M == 4
        return vec(permutedims(hcat(rx_i .> 0, rx_q .> 0)))
    elseif M == 16 || M == 64
        c, tbl, s = M == 16 ?
            ([-3, -1, 1, 3], [0 0 1 1; 0 1 1 0], sqrt(10)) :
            (collect(-7:2:7), [0 0 0 0 1 1 1 1; 0 0 1 1 1 1 0 0; 0 1 1 0 0 1 1 0], sqrt(42))
        slice(x) = [argmin(abs.(v .- c)) for v in x .* s]
        return vec([tbl[:, slice(rx_i)]; tbl[:, slice(rx_q)]])
    else
        error("Error. M ($M) no es un valor M-ario soportado.")
    end
end
