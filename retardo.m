function Retardo = retardo(Pulso, Canal)
  Retardo = length(Pulso) + floor(length(Canal)/2);
end
