function pulso(Nup, tipo, ParamsPulso = nothing)
    if tipo == 1
        t = 2 .* (-Nup/2 : Nup/2 - 1) ./ Nup
        p = Nup == 1 ? [1.0] : (1 .+ cos.(pi .* abs.(t))) ./ 2
    elseif tipo == 2
        beta, NTPulso = ParamsPulso
        af = abs.((-Nup*NTPulso/2 : Nup*NTPulso/2 - 1) ./ NTPulso)
        P = Float64.(af .<= (1 - beta)/2)
        m = (af .> (1 - beta)/2) .& (af .<= (1 + beta)/2)
        P[m] .= sqrt.((1 .+ cos.(pi/beta .* (af[m] .- (1 - beta)/2))) ./ 2)
        p = real.(fftshift(ifft(ifftshift(P))))
    else
        error("Tipo no reconocido")
    end

    return p ./ sqrt(sum(abs2, p))
end
