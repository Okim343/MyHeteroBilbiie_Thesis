

# calibration & prior blocks

const β = 0.96 # discount factor to match 4% annual interest rate from Sedlacek (2012)
const δ = 0.09631 # exogenous firm exit shock converted from quarters to yearly
const θ = 3.8 # CES sectoral parameter
const η = 2 # elasticity of substitution across sectors from Carvalho and Lee (2011)
const fE = 1 # steady-state entry cost
const Z = 1 # initial productivity
const χ = 0.924271 #Disutility of labor from Bilbiie (2007)
const ϕ = 4 # elasticity of labor supply
const Ψ = 0.090 # measure of business opportunities
const φ = 0.3 # elasticity in the entry function
const α = [0.890,0.932,0.946,0.956,0.963,0.968,0.972,0.976,0.988] #returns to scale parameters for each of the 9 sectors
const Π = [0.625, 0.357, 0.218, 0.123, 0.070, 0.040, 0.022, 0.013, 0.002] #Probability of successful entry for each of the 9 sectors

# shocks
const ρ_Z, σ_Z = 0.976,   0.0072^2
const ρ_X, σ_X = 0.415,  0.000009
const ρ_r = 0.7
const γ_fE = 1 # persistance of the entry cost shock between 1 and 0 (arbitrary)
