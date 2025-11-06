function r = fa(r_an, Nup, Pulso, Retardo)
    filtered = conv(r_an, flip(Pulso));

    r = filtered(Retardo:Nup:end);
end