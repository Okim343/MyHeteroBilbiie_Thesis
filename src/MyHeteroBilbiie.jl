###############################
#  MyHeteroBilbiie.jl (root)  #
#  Umbrella module that loads  #
#  all sub‑files and re‑exports#
###############################

module MyHeteroBilbiie

# ─────────────────────────────────────────────────────────────
# Include sub‑modules in explicit order so they can reference
# each other via `import ..Name`. `params.jl` has only consts.
# ─────────────────────────────────────────────────────────────

include("params.jl")           # calibration constants – no module wrapper
include("types.jl")            # module Types
include("steady_state.jl")     # module SteadyState
include("eqcond.jl")           # module EqCond
include("jacobian.jl")         # module Jacobian
include("mygensys.jl")         # module MyGenSys
include("system.jl")           # module LinearSystem


# ─────────────────────────────────────────────────────────────
# Re‑export for user convenience                              
# ─────────────────────────────────────────────────────────────

using .Types
using .SteadyState
using .EqCond
using .Jacobian
using .MyGenSys
using .LinearSystem


export Types, SteadyState, EqCond, Jacobian, LinearSystem
export steady_state                     # from SteadyState
export build_G_blocks                   # from Jacobian
export build_system!                    # from LinearSystem
export gensys                          # from MyGenSys
end # module