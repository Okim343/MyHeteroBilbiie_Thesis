# model object + indices

#############################################################
#  src/types.jl – model container & default constructor     #
#############################################################


module Types

include("params.jl")   # brings the constants into scope

export MyHeteroBilbiieModel

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

end # module
