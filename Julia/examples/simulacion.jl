### A Pluto.jl notebook ###
# v1.0.4

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    #! format: off
    return quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
    #! format: on
end

# ╔═╡ d3514600-c27f-11f1-97a9-d94ace925b17
begin
	import Pkg
	Pkg.activate(joinpath(@__DIR__, ".."))
	using IEE3514, Plots, PlutoUI, SpecialFunctions
	using DSP: conv
end

# ╔═╡ d3514588-c27f-11f1-b35c-87463b93ee0d
md"""
# Simulación de enlace QAM
Cadena completa: PRBS15 → QAM → pulso → canal → AWGN → filtro adaptado → decisión.
"""

# ╔═╡ d3514614-c27f-11f1-9f47-098aff44010f
md"""
## Parámetros
M: $(@bind M Select([2, 4, 16, 64], default=16))
Nup: $(@bind Nup Slider(1:16, default=8, show_value=true))
Eb/N0 [dB]: $(@bind EbNo Slider(0:0.5:20, default=12, show_value=true))

Pulso: $(@bind tipo_pulso Select([1 => "coseno alzado (1 T)", 2 => "raíz coseno alzado"]))
β: $(@bind beta Slider(0.05:0.05:1, default=0.25, show_value=true))

Canal: $(@bind tipo_canal Select([1 => "ideal", 2 => "sinc", 3 => "dos rayos", 4 => "Rayleigh exponencial"]))
"""

# ╔═╡ d351461c-c27f-11f1-aaf2-b18bae62495a
params_pulso = (beta, 8)

# ╔═╡ d3514628-c27f-11f1-ae48-5beb864af879
params_canal = tipo_canal == 2 ? (1.0, 8) : tipo_canal == 4 ? (0.5, 4, 1, 2) : nothing

# ╔═╡ d351463c-c27f-11f1-bc41-918f4d64300a
function simular(M, EbNo, Nup, p, h; Nbits = 60_000)
	bits, _ = prbs15(Nbits, ones(15))
	si, sq = qammod(bits, M)
	y = conv(d2a(complex.(si, sq), Nup, p), h)
	ni, nq, _, _ = awgn(EbNo, length(y), 1, 2, M)
	r = y .+ complex.(ni, nq)
	z = fa(r, Nup, p, retardo(p, h))[1:length(si)]
	_, Err_b = errores(bits, qamdemod(real(z), imag(z), M), M)
	return (; r, z, ber = Err_b / Nbits)
end

# ╔═╡ d3514646-c27f-11f1-a5c6-2702080abd8a
p = pulso(Nup, tipo_pulso, params_pulso)

# ╔═╡ d351464e-c27f-11f1-936c-331bb6d9667b
h, _, _ = canal(Nup, tipo_canal, params_canal)

# ╔═╡ d35146a0-c27f-11f1-88bb-1dd1d59e3a06
sim = simular(M, EbNo, Nup, p, h)

# ╔═╡ d35146b4-c27f-11f1-aa59-937b8917af13
md"BER simulada: **$(sim.ber)**" 

# ╔═╡ d35146be-c27f-11f1-a115-e5956eadac86
scatter(real(sim.z), imag(sim.z); ms = 1, msw = 0, alpha = 0.3,
aspect_ratio = 1, legend = false, title = "Constelación recibida")

# ╔═╡ d35146c8-c27f-11f1-8dd6-ef2e66e20672
let
	y = real(conv(sim.r, reverse(p)))
	d = retardo(p, h) - Nup
	seg = [y[d + k*Nup .+ (0:2Nup)] for k in 1:min(300, length(sim.z) - 3)]
	plot(0:2Nup, seg; color = :blue, alpha = 0.1, legend = false,
		title = "Diagrama de ojo (fase I)", xlabel = "muestra")
end

# ╔═╡ d35146dc-c27f-11f1-b671-9980612ffc0f
function ber_teorica(M, EbNo_dB)
	γ = 10^(EbNo_dB / 10)
	M == 2 && return erfc(sqrt(γ)) / 2
	k = log2(M)
	return 2 / k * (1 - 1 / sqrt(M)) * erfc(sqrt(3k * γ / (2(M - 1))))
end

# ╔═╡ d35146e6-c27f-11f1-a4be-55a9ed5a4fef
let
	ebno = 0:2:20
	ber = [simular(M, e, Nup, p, h).ber for e in ebno]
	plot(ebno, ber_teorica.(M, ebno); yscale = :log10, label = "teórica AWGN",
		ylims = (1e-6, 1), xlabel = "Eb/N0 [dB]", ylabel = "BER")
	scatter!(ebno, max.(ber, 1e-7); label = "simulada")
end

# ╔═╡ Cell order:
# ╠═d3514588-c27f-11f1-b35c-87463b93ee0d
# ╠═d3514600-c27f-11f1-97a9-d94ace925b17
# ╠═d3514614-c27f-11f1-9f47-098aff44010f
# ╠═d351461c-c27f-11f1-aaf2-b18bae62495a
# ╠═d3514628-c27f-11f1-ae48-5beb864af879
# ╠═d351463c-c27f-11f1-bc41-918f4d64300a
# ╠═d3514646-c27f-11f1-a5c6-2702080abd8a
# ╠═d351464e-c27f-11f1-936c-331bb6d9667b
# ╠═d35146a0-c27f-11f1-88bb-1dd1d59e3a06
# ╠═d35146b4-c27f-11f1-aa59-937b8917af13
# ╠═d35146be-c27f-11f1-a115-e5956eadac86
# ╠═d35146c8-c27f-11f1-8dd6-ef2e66e20672
# ╠═d35146dc-c27f-11f1-b671-9980612ffc0f
# ╠═d35146e6-c27f-11f1-a4be-55a9ed5a4fef
