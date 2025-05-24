const SRC = @__DIR__

using LinearAlgebra, Statistics
using Plots 


# load type definitions first
include(joinpath(SRC, "parameter&types.jl"))    # defines structs, aliases, etc.

# finally your steady‐state solver
include(joinpath(SRC,"helper_functions","steady_state.jl"))  # defines steady_state(...)
include(joinpath(SRC,"helper_functions","steady_state_figures.jl"))  # defines steady_state(...)


# ────────────────────────────────────────────────────────────────────────
#  1. Build calibrated model and solve linear system                      
# ────────────────────────────────────────────────────────────────────────

model = MyHeteroBilbiieModel()    # pulls constants from params.jl

# ────────────────────────────────────────────────────────────────────────

outdir = joinpath(@__DIR__, "..", "src", "images", "steady_state", "elastic_labor")
mkpath(outdir)

ss = steady_state(model)          # compute steady state for elastic labor
print_ss(ss)                     # print steady state

p = steady_state_scatter(ss; size_scale=30, log_y=true, log_x=true) # relationship between y_i l_i and M_i logged

savefig(p, joinpath(outdir,"steady_firm_dynamic_log.pdf"))

p = steady_state_scatter(ss; size_scale=30) # relationship between y_i l_i and M_i 

savefig(p, joinpath(outdir,"steady_firm_dynamic.pdf"))

p = steady_state_entry(ss; log_y=true, log_x=true) # relationship between y_i l_i and M_i logged

savefig(p, joinpath(outdir,"steady_entry_log.pdf"))


# ────────────────────────────────────────────────────────────────────────

outdir = joinpath(@__DIR__, "..", "src", "images", "steady_state", "inelastic_labor")
mkpath(outdir)

ss_inL = steady_state(model; inelasticL=true)          # compute steady state for inelastic labor
print_ss(ss_inL)                     # print steady state

p = steady_state_scatter(ss_inL; size_scale=30, log_y=true, log_x=true) # relationship between y_i l_i and M_i logged

savefig(p, joinpath(outdir,"steady_firm_dynamic_log.pdf"))

p = steady_state_scatter(ss_inL; size_scale=30) # relationship between y_i l_i and M_i 

savefig(p, joinpath(outdir,"steady_firm_dynamic.pdf"))

p = steady_state_entry(ss_inL; log_y=true, log_x=true) # relationship between y_i l_i and M_i logged

savefig(p, joinpath(outdir,"steady_entry_log.pdf"))