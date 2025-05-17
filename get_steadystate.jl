using MyHeteroBilbiie                   # umbrella module (you include all src/*.jl there)
using MyHeteroBilbiie.Types
#= using MyHeteroBilbiie.LinearSystem
using MyHeteroBilbiie.EqCond            # for idx mapping
using DSGE
using Plots =#

# ────────────────────────────────────────────────────────────────────────
#  1. Build calibrated model and solve linear system                      
# ────────────────────────────────────────────────────────────────────────

model = Types.MyHeteroBilbiieModel()    # pulls constants from params.jl
ss = steady_state(model)           # compute steady state
println("ss object = ", ss)