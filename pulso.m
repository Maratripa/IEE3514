function Pulso = pulso(Nup, tipo, ~)
    t = (0:(Nup-1)) / Nup;

    switch tipo
      case 1
        % Pulso coseno elevado, asumimos beta = 1
        Pulso = sinc(t) .* cos(pi * t) ./ (1 - 4*(t.^2));

        if mod(Nup, 2) == 0
            Pulso(Nup/2 + 1) = 0.5;
        end

        Pulso = Pulso / sqrt(sum(Pulso.^2));
    otherwise
      error("Tipo no reconocido")
    end
end
