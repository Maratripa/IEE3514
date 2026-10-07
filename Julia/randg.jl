include("randu.jl")

function randg(N, e0)
    g = zeros(N)
    n = 1

    len = 2*N
    u, eN = randu(len, e0)
    batch_i = 1

    while n <= N
        if batch_i > len
            len = 2*(N - n + 1)
            u, eN = randu(len, eN)
            batch_i = 1
        end

        s = (2 * u[batch_i] - 1)^2 + (2 * u[batch_i + 1] - 1)^2

        if s < 1
            g[n] = (2 * u[batch_i] - 1) * sqrt(-2 * log(s) / s)
            n = n + 1
        end

        batch_i = batch_i + 2
    end

    return g, eN
end
