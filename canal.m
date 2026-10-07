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
        case 3
            Canal = zeros(1, Nup*3);
            Canal(1:Nup:end) = [0, 0.98*exp(1j*pi/12), sqrt(1 - 0.98^2)*exp(1j*pi/6)];
        case 4
            Trms = ParamsCanal(1);
            Ntc = ParamsCanal(2);
            SemillaCanal_I = ParamsCanal(3);
            SemillaCanal_Q = ParamsCanal(4);

            L = ceil(2*Ntc*Nup*Trms);

            [X, b1] = randg(L, SemillaCanal_I);
            [Y, b2] = randg(L, SemillaCanal_Q);
            
            Canal = exp(- (0:L-1) / (2 * Nup * Trms)) .* (X + 1j*Y);

            Canal = Canal * sqrt((1-exp(-1/(Nup*Trms)))/2);
        otherwise
            error("Tipo no reconocido")
    end
end
