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

ctx = @dynare "src/DynareModFiles/main_ineL.mod" "stoponerror";

# ──────────────────────────────────────────────────────────
# Plotting IRFs for the aggregate shocks
# ──────────────────────────────────────────────────────────

mr  = ctx.results.model_results[1]         # the first (and maybe only) run
shocks = mr.irfs                           # this is a ::Dict{Symbol, AxisArrayTable}
#println("shocks : ", shocks)  # print the keys of the shocks

# ─────────────────────Aggreagate productivity shock Z─────────────────────────────────────

p = plot_irfs(mr, :eps_Z, [:logLe, :logLc, :logY, :logw]; horizon=75, ncols=2)
savefig(p, "src/images/inelastic_labor/Zshocks/irf_epsZAgg.pdf")  # paper-ready PDF =#

p = plot_irfs_stacked(mr, :eps_Z, [:e1, :e2, :e3, :e4, :e5, :e6, :e7, :e8, :e9]; horizon=75, ncols=3)
savefig(p, "src/images/inelastic_labor/Zshocks/irf_epsZ_e_stacked.pdf")  # paper-ready PDF

p = plot_irfs_stacked(mr, :eps_Z, [:M1, :M2, :M3, :M4, :M5, :M6, :M7, :M8, :M9]; horizon=75, ncols=3)
savefig(p, "src/images/inelastic_labor/Zshocks/irf_epsZ_M_stacked.pdf")  # paper-ready PDF

p = plot_irfs_stacked(mr, :eps_Z, [:logv1, :logv2, :logv3, :logv4, :logv5, :logv6, :logv7, :logv8, :logv9]; horizon=75, ncols=3)
savefig(p, "src/images/inelastic_labor/Zshocks/irf_epsZ_logv_stacked.pdf")  # paper-ready PDF

p = plot_irfs_stacked(mr, :eps_Z, [:logy1, :logy2, :logy3, :logy4, :logy5, :logy6, :logy7, :logy8, :logy9]; horizon=75, ncols=3)
savefig(p, "src/images/inelastic_labor/Zshocks/irf_epsZ_logy_stacked.pdf") # paper-ready PDF

p = plot_irfs_stacked(mr, :eps_Z, [:rho1, :rho2, :rho3, :rho4, :rho5, :rho6, :rho7, :rho8, :rho9]; horizon=75, ncols=3)
savefig(p, "src/images/inelastic_labor/Zshocks/irf_epsZ_rho_stacked.pdf")  # paper-ready PDF

p = plot_irfs_stacked(mr, :eps_Z, [:logl1, :logl2, :logl3, :logl4, :logl5, :logl6, :logl7, :logl8, :logl9]; horizon=75, ncols=3)
savefig(p, "src/images/inelastic_labor/Zshocks/irf_epsZ_logl_stacked.pdf")  # paper-ready PDF

# ─────────────────────Aggreagate investment shock X─────────────────────────────────────<

p = plot_irfs(mr, :eps_X, [:logLe, :logLc, :logY, :logw]; horizon=75, ncols=2)
savefig(p, "src/images/inelastic_labor/Xshocks/irf_epsX_Agg.pdf")  # paper-ready PDF 

p = plot_irfs_stacked(mr, :eps_X, [:e1, :e2, :e3, :e4, :e5, :e6, :e7, :e8, :e9]; horizon=75, ncols=3)
savefig(p, "src/images/inelastic_labor/Xshocks/irf_epsX_e_stacked.pdf")  # paper-ready PDF

p = plot_irfs_stacked(mr, :eps_X, [:M1, :M2, :M3, :M4, :M5, :M6, :M7, :M8, :M9]; horizon=75, ncols=3)
savefig(p, "src/images/inelastic_labor/Xshocks/irf_epsX_M_stacked.pdf")  # paper-ready PDF

p = plot_irfs_stacked(mr, :eps_X, [:logv1, :logv2, :logv3, :logv4, :logv5, :logv6, :logv7, :logv8, :logv9]; horizon=75, ncols=3)
savefig(p, "src/images/inelastic_labor/Xshocks/irf_epsX_logv_stacked.pdf")  # paper-ready PDF

p = plot_irfs_stacked(mr, :eps_X, [:logd1, :logd2, :logd3, :logd4, :logd5, :logd6, :logd7, :logd8, :logd9]; horizon=75, ncols=3)
savefig(p, "src/images/inelastic_labor/Xshocks/irf_epsX_logd_stacked.pdf")  # paper-ready PDF

p = plot_irfs_stacked(mr, :eps_X, [:logy1, :logy2, :logy3, :logy4, :logy5, :logy6, :logy7, :logy8, :logy9]; horizon=75, ncols=3)
savefig(p, "src/images/inelastic_labor/Xshocks/irf_epsX_logy_stacked.pdf")  # paper-ready PDF

p = plot_irfs_stacked(mr, :eps_X, [:rho1, :rho2, :rho3, :rho4, :rho5, :rho6, :rho7, :rho8, :rho9]; horizon=75, ncols=3)
savefig(p, "src/images/inelastic_labor/Xshocks/irf_epsZ_rho_stacked.pdf")  # paper-ready PDF

p = plot_irfs_stacked(mr, :eps_X, [:logl1, :logl2, :logl3, :logl4, :logl5, :logl6, :logl7, :logl8, :logl9]; horizon=75, ncols=3)
savefig(p, "src/images/inelastic_labor/Xshocks/irf_epsZ_logl_stacked.pdf")  # paper-ready PDF