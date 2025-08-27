include("randu2.jl")

function randg(N, e0)
    g = zeros(N)
    eN = e0
    n = 1

    while n <= N
        u, eN = randu2(eN)

        s = (2*u[1] - 1)^2 + (2*u[2] - 1)^2

        if s < 1
            g[n] = (2*u[1] - 1)*sqrt(-2*log(s)/s)
            n = n + 1
        end
    end

    return [g, eN]
end
