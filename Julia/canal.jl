function canal(Nup, TipoCanal, ParamsCanal = nothing)
    b1 = b2 = 0
    if TipoCanal == 1
        Canal = [1.0]
    elseif TipoCanal == 2
        W, NTCanal = ParamsCanal
        t = (-Nup*NTCanal/2 : (Nup*NTCanal - 1)/2) ./ Nup
        Canal = W .* sinc.(W .* t) ./ Nup
    elseif TipoCanal == 3
        Canal = zeros(ComplexF64, 3Nup)
        Canal[1:Nup:end] = [0, 0.98cis(pi/12), sqrt(1 - 0.98^2) * cis(pi/6)]
    elseif TipoCanal == 4
        Trms, Ntc, SemillaI, SemillaQ = ParamsCanal
        L = ceil(Int, 2*Ntc*Nup*Trms)
        X, b1 = randg(L, SemillaI)
        Y, b2 = randg(L, SemillaQ)
        Canal = exp.(-(0:L-1) ./ (2Nup*Trms)) .* (X .+ im .* Y) .*
                sqrt((1 - exp(-1/(Nup*Trms))) / 2)
    else
        error("Tipo no reconocido")
    end

    return Canal, b1, b2
end
