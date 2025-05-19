#############################################################
#  src/steady_state.jl – analytical steady-state solver     #
#  for the heterogeneous Bilbiie-Sedlacek model (3 + 7 I)    #
#############################################################

using LinearAlgebra, Statistics


# ──────────────────────────────────────────────────────────
# Generic root-finder (Brent / bisection mix)
# ──────────────────────────────────────────────────────────
"""
    bisection(f, a, b; tol = 1e-10, maxiter = 10_000)

Simple bracket-and-bisection routine.
Assumes `f(a)` and `f(b)` have opposite signs.
"""
function bisection(f, a, b; tol = 1e-10, maxiter = 10_000)
    fa, fb = f(a), f(b)
    @assert sign(fa) != sign(fb) "Initial interval does not bracket a root."

    for _ in 1:maxiter
        c  = (a + b) / 2
        fc = f(c)
        if abs(fc) ≤ tol || abs(b - a) ≤ tol
            return c
        end
        if sign(fc) == sign(fa)
            a, fa = c, fc
        else
            b, fb = c, fc
        end
    end
    error("Bisection did not converge.")
end

# ──────────────────────────────────────────────────────────
# Main steady-state routine
# ──────────────────────────────────────────────────────────
"""
    steady_state(model::MyHeteroBilbiieModel; tol = 1e-10)

Compute the steady state of the full heterogeneous model.

The returned **named tuple** contains the 3 aggregate unknowns  
`(w, L, r)` and the 7 per-sector unknowns  
`(C_i, M_i, ρ_i, v_i, d_i, e_i, Π_i)`.  

Diagnostics such as `C` or intermediate objects (*yᵢ, lᵢ, mᵢ*) are
computed internally but not exported.
"""
function steady_state(model::MyHeteroBilbiieModel; tol = 1e-15)

    ## ─── Parameters ─────────────────────────────────────────────
    β      = model.β
    δdeath = model.δ                       # firm exit shock
    θ      = model.θ                       # within-sector elasticity
    η      = model.η                       # across-sector elasticity
    α      = model.α                       # returns-to-scale vector (length I)
    fE     = model.fE
    Z̄      = 1.0                           # productivity normalisation
    X      = 1.0                           # composition shock normalisation
    χ      = model.χ
    ϕ      = model.ϕ                       # elasticity of matching
    Π̄      = model.Π                       # success probabilities (taken as exogenous)
    φ      = model.φ                       # Frisch elasticity of labor supply

    I      = length(α)                     # number of sectors
    μ      = θ / (θ - 1)                  # constant markup μ = θ/(θ-1)

    ##  discount & valuation helpers
    r      = 1/β - 1                      # from Euler: 1 = β (1+r)
    κ      = (r + δdeath)/(1 - δdeath)      # κ = (r + δ)/(1-δ)

    const_part = κ * fE / (Z̄ * (1 - 1/μ))  # appears in Cᵢ/Mᵢ

    ## ─── Sector-level closure given a candidate wage w ─────────
    function sector_block(w)

        Mi = zeros(I);  Ci = similar(Mi);  ρi = similar(Mi)
        di = similar(Mi); vi = similar(Mi); ei = similar(Mi); ψi = similar(Mi);
         

        # Internals
        yi = similar(Mi); li = similar(Mi); mi = similar(Mi)

        for i in 1:I
            αi        = α[i]
            p_success = Π̄[i]                  # fixed success probability

            # (B)  Cᵢ/Mᵢ
            Ci_over_Mi = const_part * w / p_success
            cost = (w * fE) / (Z̄ * X)

            # (E)  pricing condition → Mᵢ
            Ki   = μ * w /(Z̄ * αi) * (Ci_over_Mi / Z̄)^(1/αi - 1)
            Mi[i] = Ki^(θ - 1)

            # Back-out remaining sectoral objects
            Ci[i] = Ci_over_Mi * Mi[i]
            yi[i] = Ci_over_Mi
            li[i] = (yi[i]/Z̄)^(1/αi)
            di[i] = (1 - 1/μ) * yi[i]
            vi[i] = di[i] / κ
            mi[i] = δdeath/(1 - δdeath) * Mi[i]
            ei[i] = mi[i] / (cost / vi[i])
            ρi[i] = Mi[i]^(1/(θ - 1))          # relative price pᵢ/P
            # version exponent 1/(1-ϕ)
            ψi[i] = ei[i] * ( cost / vi[i] )^( 1 / (1 - ϕ) )
 
        end

        # Aggregates
        C = (sum(Ci .^ ((η - 1)/η)))^(η/(η - 1))   # top-level CES
        L = sum(Mi .* li .+ ei * fE / Z̄)           # labour demand

        return (; C, L, Mi, Ci, ρi, di, vi, ei, ψi, li, yi)
    end

    ## ─── Household intratemporal FOC residual g(w) ─────────────
    function g(w)
        blk = sector_block(w)
        χ * blk.L^(1/φ) - w / blk.C
    end

    ## ─── Outer loop: find unique w with g(w)=0 ────────────────
    w_low, w_high = 1e-4, 1.0
    while sign(g(w_low)) == sign(g(w_high))
        w_high *= 2
        w_high > 1e6 && error("Could not bracket the steady-state wage.")
    end
    w_star = bisection(g, w_low, w_high; tol)

    ## ─── Assemble final steady-state tuple ─────────────────────
    blk = sector_block(w_star)

    ss = (
        # ── aggregates (3) ──
        w = w_star,
        L = blk.L,
        r = r,

        # *C returned for convenience, not counted among unknowns
        C = blk.C,

        # ── sectoral block (7 I) ──
        M      = blk.Mi,
        C_i    = blk.Ci,
        ρ_i    = blk.ρi,
        v_i    = blk.vi,
        d_i    = blk.di,
        e_i    = blk.ei,
        ψ_i    = blk.ψi,
        Π_i    = Π̄,
        l_i    = blk.li,
        y_i    = blk.yi,
        s_lag_Z = 1.0,               # Z̄₋₁
    )

    return ss
end

export steady_state



# ────────────────────────────────────────────────────────────────────────