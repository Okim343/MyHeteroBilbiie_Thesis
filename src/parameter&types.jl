# model object + indices

#############################################################
#  src/types.jl – model container & default constructor     #
#############################################################


# calibration & prior blocks

const β = 0.96 # discount factor to match 4% annual interest rate from Sedlacek (2017)
const δ = 0.09631 # exogenous firm exit shock converted from quarters to yearly
const θ = 3.8 # CES sectoral parameter
const η = 2 # elasticity of substitution across sectors from Carvalho and Lee (2021)
const fE = 1 # entry cost
const Z = 1 # initial productivity
const χ = 0.924271 #Disutility of labor from Bilbiie (2012)
const φ = 4 # elasticity of labor supply
const ϕ= 0.3 # elasticity in the entry-matching function
const α = [0.890,0.932,0.946,0.956,0.963,0.968,0.972,0.976,0.988] #returns to scale parameters for each of the 9 sectors
const Π = [0.625, 0.357, 0.218, 0.123, 0.070, 0.040, 0.022, 0.013, 0.002] #Probability of successful entry for each of the 9 sectors

# shocks
const ρ_Z, σ_Z = 0.976,   0.0072^2
const ρ_X, σ_X = 0.415,  0.000009
const γ_fE = 1  


struct MyHeteroBilbiieModel
    β::Float64;   δ::Float64;   θ::Float64;   η::Float64
    α::Vector{Float64};         fE::Float64
    χ::Float64;   ϕ::Float64; φ::Float64
    Π::Vector{Float64}
    ρ_Z::Float64; σ_Z::Float64
    ρ_X::Float64; σ_X::Float64
    γ_fE::Float64;

end

# default constructor – pulls constants from params.jl
function MyHeteroBilbiieModel()
    return MyHeteroBilbiieModel(
        β, δ, θ, η, α, fE, χ, ϕ, φ, Π, ρ_Z, σ_Z, ρ_X, σ_X, γ_fE
    )
end


