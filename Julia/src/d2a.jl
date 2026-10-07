function d2a(s, Nup, pulso)
    stuffed = zeros(eltype(s), length(s) * Nup)
    stuffed[1:Nup:end] = s
    return conv(stuffed, pulso)
end
