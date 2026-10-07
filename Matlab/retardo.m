function Retardo = retardo(Pulso, Canal)
    [~, argmax] = max(abs(Canal));
    Retardo = length(Pulso) + argmax - 1;
end
