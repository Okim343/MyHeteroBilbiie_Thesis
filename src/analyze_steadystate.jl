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
ss = steady_state(model)          # compute steady state
println("ss object = ", ss)

p = steady_state_scatter(ss; size_scale=30)

savefig(p, "src/images/steady_firm_dynamic.pdf")