module IEE3514

using DSP: conv
using FFTW: ifft, fftshift, ifftshift

export prbs15, randu, randg, qammod, qamdemod, pulso, d2a, canal, awgn, fa, retardo, errores

include("prbs15.jl")
include("randu.jl")
include("randg.jl")
include("qammod.jl")
include("qamdemod.jl")
include("pulso.jl")
include("d2a.jl")
include("canal.jl")
include("awgn.jl")
include("fa.jl")
include("retardo.jl")
include("errores.jl")

end
