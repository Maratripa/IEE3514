# Export every notebook in examples/ to static HTML in site/.
# Run: julia --project=Julia Julia/export.jl
using PlutoSliderServer
PlutoSliderServer.export_directory(joinpath(@__DIR__, "examples"); Export_output_dir = joinpath(@__DIR__, "site"))
