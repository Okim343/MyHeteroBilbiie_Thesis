# -------------------------------------------------------------------------
#  examples/run_irf.jl – fire‑and‑forget driver to solve the model and      
#  produce impulse‑response plots.                                         
# -------------------------------------------------------------------------
#  Usage:  julia examples/run_irf.jl                                       
#  (assumes the working directory is the project root containing Project.toml)
# -------------------------------------------------------------------------

#= using Pkg
Pkg.activate(@__DIR__ * "/..")          # activate parent project
Pkg.instantiate()    =#                     # make sure deps are there (no‑op if cached)

# ────────────────────────────────────────────────────────────────────────
#  Load the package modules                                               
# ────────────────────────────────────────────────────────────────────────

using MyHeteroBilbiie                   # umbrella module (you include all src/*.jl there)
using MyHeteroBilbiie.Types
using DSGE
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
sys, ss = LinearSystem.build_system!(model)
@show size(sys.transition.TTT)   # = n_states × n_states
@show size(sys.transition.RRR)   # = n_states × n_shocks


# ────────────────────────────────────────────────────────────────────────
#  2. Impulse response – 1σ TFP shock (ε_Z)                               
# ────────────────────────────────────────────────────────────────────────

horizons = 40
# get the full IRFs for all states, observables, pseudo-observables…
states_irf, obs_irf, pseudo_irf = DSGE.impulse_responses(sys, horizons)

# aggregate L is directly in the controls vector at index 2
irf_L = states_irf[2, :, 1]  # L = x[2]

# to get aggregate C, reconstruct it from the sectoral Cᵢ series at each horizon
# sectoral Cᵢ start at index = 3 + 8*(i - 1) + 2 for i = 1 to I

I = length(model.α)
η = model.η
C_pow = (η - 1) / η

# get Cᵢ indices
Ci_indices = [3 + 8*(i - 1) + 2 for i in 1:I]

# reconstruct aggregate C IRF at each time step
irf_C = zeros(horizons + 1)
for t in 1:(horizons + 1)
    Ci_t = [states_irf[idx, t, 1] for idx in Ci_indices]
    irf_C[t] = (sum(Ci_t .^ C_pow))^(η / (η - 1))
end

# and plot those
plt = plot(0:horizons, irf_C, label="ΔC (TFP shock)", lw=2)
plot!(plt, 0:horizons, irf_L, label="ΔL (TFP shock)", lw=2)
plot!(xlabel="Years", ylabel="Deviation from steady state", legend=:right,
      title="Impulse responses to 1σ productivity shock")

savefig(plt, "irf_Z_CL.png")
println("Saved plot to irf_Z_CL.png")