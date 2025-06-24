const SRC = @__DIR__

using LinearAlgebra, Statistics
using Plots 


include(joinpath(SRC, "parameter&types.jl"))    # defines structs, aliases, etc.
include(joinpath(SRC,"helper_functions","steady_state.jl"))  # defines steady_state(...)
include(joinpath(SRC,"helper_functions","steady_state_figures.jl"))  # defines steady_state_scatter(...) and steady_state_entry(...)


# ────────────────────────────────────────────────────────────────────────
#  Build calibrated models and solve system                      
# ────────────────────────────────────────────────────────────────────────

model = MyHeteroBilbiieModel()    # pulls constants from parameter&types.jl

# ──────────────────────────────────────────────────────────────────────── Elastic Labor model ─────────────────────────────────────────────────────────────

outdir = joinpath(@__DIR__, "..", "src", "images", "steady_state", "elastic_labor")
mkpath(outdir)

ss = steady_state(model)          # compute steady state for elastic labor
print_ss(ss)                      # pretty-print steady state

p = steady_state_scatter(ss; size_scale=30, log_y=true, log_x=true) # relationship between y_i l_i and M_i logged

savefig(p, joinpath(outdir,"steady_firm_dynamic_log.pdf"))

p = steady_state_scatter(ss; size_scale=30) # relationship between y_i l_i and M_i 

savefig(p, joinpath(outdir,"steady_firm_dynamic.pdf"))

p = steady_state_entry(ss; log_y=true, log_x=true) # relationship between e_i and m_i logged

savefig(p, joinpath(outdir,"steady_entry_log.pdf"))


# ──────────────────────────────────────────────────────────────────────── Inelastic Labor model ─────────────────────────────────────────────────────────────

outdir = joinpath(@__DIR__, "..", "src", "images", "steady_state", "inelastic_labor")
mkpath(outdir)

ss_inL = steady_state(model; inelasticL=true)          # compute steady state for inelastic labor
print_ss(ss_inL)                                       # pretty-print steady state

p = steady_state_scatter(ss_inL; size_scale=30, log_y=true, log_x=true) # relationship between y_i l_i and M_i logged

savefig(p, joinpath(outdir,"steady_firm_dynamic_log.pdf"))

p = steady_state_scatter(ss_inL; size_scale=30) # relationship between y_i l_i and M_i 

savefig(p, joinpath(outdir,"steady_firm_dynamic.pdf"))

p = steady_state_entry(ss_inL; log_y=true, log_x=true) # relationship between e_i and m_i logged

savefig(p, joinpath(outdir,"steady_entry_log.pdf"))

# ──────────────────────────────────────────────────────────────────────── Business cycle model ─────────────────────────────────────────────────────────────

model_bc = MyHeteroBilbiieModel(
    model.β, model.δ, model.θ, model.η, model.α, model.fE,
    model.χ, model.ϕ, 2.0, model.Π, model.ρ_Z, model.σ_Z,
    model.ρ_X, model.σ_X, model.γ_fE
) # create a new model with Frisch elasticity = 2

ss_bcycle = steady_state(model_bc)       # compute steady state for elastic labor (frisch elasticity = 2)
print_ss(ss_bcycle)                      # pretty-print steady state
