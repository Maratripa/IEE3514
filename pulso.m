function Pulso = pulso(Nup, tipo, ParamsPulso)
    switch tipo
        case 1
            t = 2*(-Nup/2 : (Nup/2 - 1)) / Nup;
            % Pulso coseno elevado, asumimos beta = 1
            Pulso = (1 + cos(pi .* (abs(t)))) / 2;

        case 2
            % ESTO NO ES RAIZ COSENO ELEVADO
            beta = ParamsPulso(1);
            NTPulso = ParamsPulso(2);

            f = (-Nup*NTPulso/2 : Nup*NTPulso/2 - 1) / NTPulso;
    
            Pulso_fft = zeros(1, length(f));
    
            for i = 1:length(Pulso_fft)
                if abs(f(i)) <= (1 - beta)/2
                    Pulso_fft(i) = 1;
                elseif (1-beta)/2 < abs(f(i)) && abs(f(i)) <= (1+beta)/2
                    Pulso_fft(i) = sqrt((1 + cos(pi/beta * (abs(f(i)) - (1 - beta)/2))) / 2);
                end
            end

            Pulso = fftshift(ifft(ifftshift(Pulso_fft)));

        otherwise
          error("Tipo no reconocido")
    end

    Pulso = Pulso / sqrt(sum(Pulso.^2));
end
