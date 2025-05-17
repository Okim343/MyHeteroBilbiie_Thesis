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


# ─────────────────────────────────────────────────────────────
# Re‑export for user convenience                              
# ─────────────────────────────────────────────────────────────

using .Types
using .SteadyState

export Types, SteadyState
export steady_state                     # from SteadyState

end # module