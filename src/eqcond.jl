###############################################################
#  src/eqcond.jl – equilibrium residuals  (3 + 8 I system)    #
###############################################################
module EqCond

using ..Types
const T = Float64                     # concrete eltype for AD

"""
    eqcond(model, s, x, x_p)  ->  Vector{T}

Return the equilibrium residual vector **R(s,x,x_p)** of length
`3 + 8I`.  The mapping is

• 3 aggregate conditions (labour-supply FOC, Euler for bonds, goods identity)  
• 8 residuals per sector *i* = 1,…,I in the order  
  1. variety effect ρᵢ – Mᵢ^{1/(θ–1)}  
  2. pricing rule   ρᵢ – µ MCᵢ  
  3. profit definition dᵢ – (1–1/µ) Cᵢ/Mᵢ  
  4. firm-value Euler  
  5. free entry  
  6. success probability  
  7. law of motion for Mᵢ

`model`  : `Types.MyHeteroBilbiieModel`  
`s`      : state vector at *t*  (length `I + 3`)  
`x`      : control vector at *t* (length `3 + 7I`)  
`x_p`    : control vector at *t+1* (same length)
"""
function eqcond(m::Types.MyHeteroBilbiieModel,
                s::AbstractVector{S},
                x::AbstractVector{T},
                x_p::AbstractVector{T}) where {S,T}

    ###########################
    # 0.  Handy aliases       #
    ###########################
    I  = length(m.α)                     # number of sectors
    β  = m.β
    δ  = m.δ                             # “death” shock φ
    θ  = m.θ
    μ  = θ / (θ - 1)
    η  = m.η
    Π̄ = m.Π
    r      = 1/β - 1 
    κ      = (r + δ)/(1 - δ)      # κ = (r + δ)/(1-δ)
    C_ss = 0.11738613032104049
    ρ_bar = [0.06718491467362374, 0.07718850629494477, 0.08110780038578369, 0.08405037198694348, 0.08606049841116431, 
    0.08752187252963735, 0.08871201044600399, 0.08930966958773398, 0.08910661569560191]; 
    e_bar = [8.87427422600637e-5, 0.00022915591579580872, 0.0004310927895989365, 0.0008442241792260478, 0.0015849102194411039,
     0.0029074911220658283, 0.005490096852181614, 0.009467260023901615, 0.06114624170996449];
    Π_bar = [0.625, 0.357, 0.218, 0.123, 0.07, 0.04, 0.022, 0.013, 0.002]

    ###########################
    # 1.  Unpack *states*     #
    ###########################
    Mi    = @view s[1:I]             # incumbents at t
    Zt    = s[I + 1]                 # agg. productivity @ t
    Xt    = s[I + 2]                 # comp. shock (unchanged)
    fEt   = s[I + 3]                 # entry‐cost @ t
    Zlag  = s[I + 4]                 # productivity @ t−1
    fElag = s[I + 5]                 # entry‐cost @ t−1

    ###########################
    # 2.  Unpack *controls*   #
    ###########################
    ## — aggregate block (w , L , r) —
    w, L, r = x[1:3]
    wp, Lp, rp = x_p[1:3]

    ##  Sectors: 7 unknowns each
    ##    (Cᵢ, ρᵢ, dᵢ, vᵢ, eᵢ, Πᵢ, M⁺ᵢ)

    # controls at t
    function slice(base)
        C  = x[base]        #   Cᵢ,t
        ρ  = x[base + 1]
        d  = x[base + 2]
        v  = x[base + 3]
        e  = x[base + 4]
        Π  = x[base + 5]
        M⁺ = x[base + 6]    #   Mplusᵢ,t  (≡ Mᵢ,t+1 decided at t)
        return C, ρ, d, v, e, Π, M⁺
    end

    # controls at t+1
    function slice_p(base)
        Cp  = x_p[base]
        ρp  = x_p[base + 1]
        dp  = x_p[base + 2]
        vp  = x_p[base + 3]
        ep  = x_p[base + 4]
        Πp  = x_p[base + 5]
        M⁺p = x_p[base + 6]
        return Cp, ρp, dp, vp, ep, Πp, M⁺p
    end


    ############################################################
    # 3.  Prepare containers & accumulators                    #
    ############################################################
    R = zeros(T, 3 + 7I + 2)              # output residual vector with exogenous shocks
    next_idx = 4                       # residual pointer (first 3 left for aggregates)

    Ci_vec   = similar(Mi)             # store Cᵢ for aggregation
    Cip_vec  = similar(Mi)             # next-period counterpart
    value_entry  = zero(T)             # Σ vᵢ eᵢ
    profit_term  = zero(T)             # Σ dᵢ Mᵢ
    entry_cost   = zero(T)             # Σ w fE/Z eᵢ
    ρCi_sum  = zero(T)                 # Σ ρᵢ Cᵢ  (real expenditure)
    m_sum    = zero(T)                 # Σ mᵢ      (successful entrants)
    e_sum    = zero(T)                 # Σ e_i   (all entry attempts)
    L_prod       = zero(T)             # Σ Mᵢ lᵢ   (production labour)

    ############################################################
    # 4.  Loop over sectors                                    #
    ############################################################
    for i in 1:I
        base   = 3 + 7*(i-1) + 1     # offset inside x
        base_p = base                # same offset in x_p

        Cᵢ, ρᵢ, dᵢ, vᵢ, eᵢ, Πᵢ, M⁺ᵢ = slice(base)
        Mᵢ = Mi[i]                         # predetermined state at t

        Cᵢp, ρp, dᵢp, vᵢp, ep, Πᵢp, M⁺ᵢp = slice_p(base_p)

        αᵢ = m.α[i]

        # convenient definitions -------------------------------------------
        yi = Cᵢ / Mᵢ
        li = (yi / Zt)^(1/αᵢ)
        MCᵢ = (w / (αᵢ * Zt)) * (yi / Zt)^(1/αᵢ - 1)
        mi  = δ / (1 - δ) * Mᵢ           # successful entrants now at t

        # (1) variety-effect residual: ρᵢ = Mᵢ^{1/(θ-1)}
        R[next_idx] = ρᵢ - Mᵢ^(1 / (θ - 1));             next_idx += 1

        # (2) pricing rule residual: ρᵢ = μ MCᵢ
        R[next_idx] = ρᵢ - μ * MCᵢ;                         next_idx += 1

        # (3) profit definition residual: dᵢ = (1−1/μ) Cᵢ/Mᵢ
        R[next_idx] = dᵢ - (1 - 1/μ) * Cᵢ / Mᵢ;          next_idx += 1

        # (4) firm-value Euler residual
        R[next_idx] = vᵢ - β * (1 - δ) * (Cᵢ / Cᵢp) * (vᵢp + dᵢp); next_idx += 1

        # (5) free-entry residual: Πᵢ vᵢ = w fE/Z
        R[next_idx] = Πᵢ * vᵢ - w * fEt / Zt;               next_idx += 1

        # (6) success probability residual: Πᵢ eᵢ = mᵢ
        R[next_idx] = Πᵢ * eᵢ - mi;                         next_idx += 1

        # (7) law of motion for Mᵢ: Mᵢ₊ = (1−δ)(Mᵢ + mᵢ)
        R[next_idx] = M⁺ᵢp - (1-δ)*(Mᵢ  + mi);      next_idx += 1   

        # ---- aggregation helpers -----------------------------------------
        Ci_vec[i]  = Cᵢ
        Cip_vec[i] = Cᵢp
        m_sum += mi
        e_sum += eᵢ
        L_prod      += Mᵢ * li         # production labour
        ρCi_sum += ρᵢ * Cᵢ

    end

    ############################################################
    # 5.  Aggregate objects                                    #
    ############################################################
    Cpow  = (η - 1) / η
    C     = (sum(Ci_vec  .^ Cpow))^(η / (η - 1))
    Cp    = (sum(Cip_vec .^ Cpow))^(η / (η - 1))
    entry_cost = w * fEt / Zt * e_sum      #  e_sum = Σ eᵢ
    #L_calc     = L_prod + e_sum * fEt / Zt 
    prod_wage  = ρCi_sum / μ
    wage_bill  = entry_cost + prod_wage
    profit_term = (1 - 1/μ) * ρCi_sum

    ############################################################
    # 6.  Aggregate residuals                                  #
    ############################################################
    # (A) intra-temporal FOC  ---- R[1]
    R[1] = m.χ * L^(1 / m.ϕ) - w / C

    # (B) Euler for risk-free bonds ---- R[2]
    R[2] = 1 - β * (1 + r) * C / Cp

    # (C) goods / investment identity ---- R[3]
    
    # USES
    uses = ρCi_sum + entry_cost          # Σ ρᵢ Cᵢ     
    # SOURCES
    sources = wage_bill + profit_term                # Σ ρᵢ dᵢ Mᵢ  (= d_t N_t)

    R[3] = (uses - sources) - (C/C_ss - 1)

    ############################################################
    # 7.  Shock‐process residuals                              #
    ############################################################

    # (D) productivity AR(1):   ln Zₜ = ρ_Z · ln Zₜ₋₁  +  ε_Zₜ
    R[next_idx] = log(Zt) - m.ρ_Z * log(Zlag); next_idx += 1

    # (E) entry‐cost AR(1):     fEₜ = γ_fE · fEₜ₋₁
    R[next_idx] = fEt - m.γ_fE * fElag; next_idx += 1

    return R 
end

end # module
