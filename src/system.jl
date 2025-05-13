###########################################################################
#  src/system.jl – build the linearised DSGE system and call gensys        #
#  (system size: 3 + 8·I controls / residuals)                             #
###########################################################################

module LinearSystem

include("mygensys.jl")            # gensys function

using LinearAlgebra, SparseArrays
using DSGE                          # provides gensys & system wrappers
using ..MyGenSys: gensys

import ..Types: MyHeteroBilbiieModel
import ..SteadyState: steady_state
import ..Jacobian: build_G_blocks
import ..EqCond: eqcond
import ..MyGenSys: gensys

export build_system!

# ──────────────────────────────────────────────────────────────────
# Helpers to pack steady-state *state* and *control* vectors
# in exactly the order expected by eqcond.jl (3 + 8·I)
# ──────────────────────────────────────────────────────────────────

"""
    control_names(I) -> Vector{String}

Return the list of variable names in **exactly** the order
`ss_control_vector` builds the control vector
[w, L, r, M₁, C₁, ρ₁, d₁, v₁, e₁, Π₁, M₁₊, …].

N = 3 + 7I elements.
"""
function control_names(I::Integer)
    names = String["w", "L", "r"]
    for i in 1:I
        push!(names, "C_$i")
        push!(names, "rho_$i")
        push!(names, "d_$i")
        push!(names, "v_$i")
        push!(names, "e_$i")
        push!(names, "Pi_$i")
        push!(names, "Mplus_$i")      # next-period Mᵢ
    end
    return names
end

"""
    ss_state_vector(ss, model) -> s̄

Builds the **state vector**

s̄ = [ M̄₁ … M̄ᴵ,
       Z̄  = 1,
       X̄  = 1,
       f̄_E,
       Z̄₋₁ = 1,
       f̄_{E,₋1} = f̄_E
     ]
# length = I + 5

`X̄` is a placeholder (composition shock) that `eqcond` ignores.
"""
function ss_state_vector(ss, model)
    I = length(model.α)
    s = Vector{Float64}(undef, I + 5)

    # incumbents
    s[1:I]     = ss.M

    # current-period exogenous levels
    s[I + 1]   = 1.0         # Z̄  (normalisation)
    s[I + 2]   = 1.0         # X̄  (unused in current eqcond)
    s[I + 3]   = model.fE    # f̄_E

    # lagged states (initialised at steady state)
    s[I + 4]   = 1.0         # Z̄₋₁
    s[I + 5]   = model.fE    # f̄_{E,₋1}

    return s
end



"""
    ss_control_vector(ss, model) -> x̄

Builds the **control vector** in the order

[w, L, r, C₁,ρ₁,d₁,v₁,e₁,Π₁,M₁₊, … , Cᴵ,ρᴵ,dᴵ,vᴵ,eᴵ,Πᴵ,Mᴵ₊]


whose length is `n = 3 + 7 I`.
"""
function ss_control_vector(ss, model)
    I = length(model.α)
    n = 3 + 7I + 2                     # ← 3 aggregate + 7·I sectoral + 2 exogenous shocks
    x = Vector{Float64}(undef, n)

    # ── aggregate block (w, L, r) ──
    x[1:3] .= (ss.w, ss.L, ss.r)

    # ── sectoral block  (C, ρ, d, v, e, Π, Mplus) ──
    @inbounds for i in 1:I
        base = 3 + 7*(i - 1)         # starting index for sector i
        x[base + 1] = ss.C_i[i]
        x[base + 2] = ss.ρ_i[i]
        x[base + 3] = ss.d_i[i]
        x[base + 4] = ss.v_i[i]
        x[base + 5] = ss.e_i[i]
        x[base + 6] = ss.Π_i[i]     # success probability Πᵢ,t
        x[base + 7] = ss.M[i]       # next-period incumbents Mᵢ,t+1 (≡ Mplusᵢ)
        x[base + 8] = ss.s_lag_Z    # = 1.0
        x[base + 9] = ss.s_lag_fE   # = model.fE
    end
    return x
end

# ──────────────────────────────────────────────────────────────────
# Top-level builder
# ──────────────────────────────────────────────────────────────────
"""
    build_system!(model) -> (sys, ss)

1. Computes the non-linear steady state  
2. Derives Jacobian blocks `(G1, G0)`  
3. Solves the linear rational-expectations system with `gensys`  
4. Returns the DSGE.jl `System` **and** the steady-state record `ss`
"""
function build_system!(model::MyHeteroBilbiieModel)

    # 1. Non-linear steady state
    ss  = steady_state(model)

    # 2. Pack state & control vectors in the order eqcond expects
    s̄   = ss_state_vector(ss, model)
    x̄   = ss_control_vector(ss, model)

    # 3. Jacobian blocks   G1 · x_{t+1} + G0 · x_t = 0
    G1, G0 = build_G_blocks(s̄, x̄, x̄, model)
    #= println("G1 = ", size(G1))
    println("G0 = ", size(G0)) =#

    #= res = eqcond(model, s̄, x̄, x̄)
    println("--- largest absolute residuals in steady state ---")
    for (k, v) in enumerate(sortperm(abs.(res), rev = true)[1:10])
        println(rpad(k,3), ":  |res[", v, "]| = ", abs(res[v]))
    end =#

    @assert all(abs.(eqcond(model, s̄, x̄, x̄)) .< 1e-10) "Steady state not exact"

    # 4. Constant/shock matrices (zeros for now)
    n_resid = size(G1, 1)
    c  = zeros(Float64, n_resid)            # deterministic constant

    # we'll have exactly 1 structural shock (ε_Z); fill Ψ next
    Ψ  = zeros(Float64, n_resid, 1)         # structural shocks
    Ψ[n_resid - 1, 1] = 1.0

    Π  = zeros(Float64, n_resid, 0)         # expectational errors

    # now the number of predetermined (lagged) states is exactly length(s̄)
    n_states   = length(s̄)
    state_inds = collect(1:n_states)          # [1, 2, …, I+5]
    

    # 2) build the jump indices = everything else
    all_inds  = collect(1:size(G0,1))
    jump_inds = Base.filter(i -> i ∉ state_inds, all_inds)

    # 3) permutation: states first, jumps second
    perm = vcat(state_inds, jump_inds)

    # 4) permute rows & cols of G0,G1 and permute c,Ψ,Π rows
    G0p = G0[perm, perm]
    G1p = G1[perm, perm]
    cp  = c[perm]
    Ψp  = Ψ[perm, :]
    Πp  = Π[perm, :]

    #@show size(cp), size(Ψp), size(Πp)


    # 5) call gensys with an explicit, nonzero `div`
    G1g, Cg, Rg, fmat, fwt, ywt, gev, eu, loose =
        MyGenSys.gensys(
        G1p,       # Γ0
        -G0p,       # Γ1
        cp,        # constant
        Ψp,        # 75×0 shock-loading
        Πp,        # 75×66 expectational-error
        1e-3      # nonzero “div” so gensys takes the 9-output branch
        )

    # extract the transition matrices
    TTT = G1g
    RRR = Rg
    CCC = Cg

    # now `eu` really is the two-element existence/uniqueness flag
    if any(eu .!= 1)
    @warn "gensys signalled existence/uniqueness problems:" eu
    end

    # 6. Wrap into DSGE.jl `System`
    n_states  = length(s̄)
    trans = Transition(TTT, RRR, CCC)      
    meas      = Measurement(zeros(0, n_states), zeros(0),
                            zeros(0, 0), zeros(0, 0))

    sys = System(trans, meas)

    return sys, ss
end

end # module

