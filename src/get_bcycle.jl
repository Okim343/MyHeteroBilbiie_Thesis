using LinearAlgebra
@info "BLAS config: " BLAS.get_config() # Used for debugging since BLAS is currently unstable in Dynare.jl depending on the Julia version
using Dynare
using AxisArrayTables
using Plots

# ──────────────────────────────────────────────────────────
# Main model routine
# ──────────────────────────────────────────────────────────

const SRC = @__DIR__
include(joinpath(SRC,"helper_functions","plot_irfs.jl"))  # defines plot_irfs(...)

ctx = @dynare "src/DynareModFiles/main_bcycle.mod" "stoponerror";


# ──────────────────────────────────────────────────────────
# Plotting IRFs for the aggregate shocks
# ──────────────────────────────────────────────────────────

mr  = ctx.results.model_results[1]         # the first (and maybe only) run
shocks = mr.irfs                           # this is a ::Dict{Symbol, AxisArrayTable}
#println("shocks : ", shocks)  # print the keys of the shocks


