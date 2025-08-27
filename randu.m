function [u, eN] = randu(N, e0)
    mult = 7^5;
    modu = 2^31 - 1;

    u = zeros(1, N);

    u(1) = mod(mult * e0, modu);

    for i=2:N
        u(i) = mod(mult * u(i - 1), modu);
    end

    eN = u(N);
    u = u ./ modu;
end

