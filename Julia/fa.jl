function fa(r_an, Nup, pulso, retardo)
    filtered = conv(r_an, reverse(pulso))
    return filtered[retardo:Nup:end]
end
