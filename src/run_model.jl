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

ctx = @dynare "src/DynareModFiles/main.mod" "stoponerror";


# ──────────────────────────────────────────────────────────
# Plotting IRFs for the aggregate shocks
# ──────────────────────────────────────────────────────────

mr  = ctx.results.model_results[1]         # the first (and maybe only) run
shocks = mr.irfs                           # this is a ::Dict{Symbol, AxisArrayTable}
#println("shocks : ", shocks)  # print the keys of the shocks

# ─────────────────────Aggreagate productivity shock Z─────────────────────────────────────

p = plot_irfs(mr, :eps_Z, [:logL, :logC, :logw]; horizon=75, ncols=3)
savefig(p, "src/images/irf_epsZAgg.pdf")  # paper-ready PDF

p = plot_irfs(mr, :eps_Z, [:logv1, :logv2, :logv3, :logv4, :logv5, :logv6, :logv7, :logv8, :logv9]; horizon=75, ncols=3)
savefig(p, "src/images/irf_epsZ_logv.pdf")  # paper-ready PDF

p = plot_irfs(mr, :eps_Z, [:logd1, :logd2, :logd3, :logd4, :logd5, :logd6, :logd7, :logd8, :logd9]; horizon=75, ncols=3)
savefig(p, "src/images/irf_epsZ_logd.pdf")  # paper-ready PDF

p = plot_irfs(mr, :eps_Z, [:e1, :e2, :e3, :e4, :e5, :e6, :e7, :e8, :e9]; horizon=75, ncols=3)
savefig(p, "src/images/irf_epsZ_e.pdf")  # paper-ready PDF

p = plot_irfs(mr, :eps_Z, [:M1, :M2, :M3, :M4, :M5, :M6, :M7, :M8, :M9]; horizon=75, ncols=3)
savefig(p, "src/images/irf_epsZ_M.pdf")  # paper-ready PDF