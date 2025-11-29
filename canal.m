function [Canal, b1, b2] = canal(Nup, TipoCanal, ParamsCanal)
    b1 = 0;
    b2 = 0;
    switch TipoCanal
        case 1
            Canal = 1;
        case 2
            W = ParamsCanal(1);
            NTCanal = ParamsCanal(2);

            t = (-Nup*NTCanal/2 : (Nup*NTCanal - 1)/2) / Nup;

            Canal = W .* sinc(W .* t) / Nup;
        otherwise
          error("Tipo no reconocido")
end