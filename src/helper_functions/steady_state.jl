##############################################################################
#  src/helper_functions/steady_state.jl – analytical steady-state solver     #
#  for the heterogeneous Bilbiie-Sedlacek model (3 + 7 I)                    #
##############################################################################

using LinearAlgebra, Statistics, DataFrames


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
    steady_state(model::MyHeteroBilbiieModel; tol = 1e-15, inelasticL::Bool=false)

Compute the steady state of the full heterogeneous model.

The returned **named tuple** contains the aggregates  
`(w, L, Le, Lc, Y, r, C)` plus the per-sector vectors  
`(M_i, C_i, ρ_i, v_i, d_i, e_i, ψ_i, Π_i, α_i, l_i, y_i, L_i)`.

If `inelasticL=true`, the labor FOC uses χ = w/C (φ→0 limit).  
Otherwise it uses χ·L^(1/φ) = w/C.
"""
function steady_state(model::MyHeteroBilbiieModel; tol = 1e-15, inelasticL::Bool=false)

    ## ─── Parameters ─────────────────────────────────────────────
    β      = model.β
    δdeath = model.δ                       # firm exit rate
    θ      = model.θ                       # within-sector CES
    η      = model.η                       # across-sector CES
    α      = model.α                       # sector returns-to-scale
    fE     = model.fE                      # entry cost
    Z̄      = 1.0                           # productivity norm
    X      = 1.0                           # composition shock norm
    χ      = model.χ                       # disutility of labor
    ϕ      = model.ϕ                       # matching elasticity
    Π̄      = model.Π                       # success probabilities
    φ      = model.φ                       # Frisch elasticity

    I      = length(α)
    μ      = θ / (θ - 1)                   # markup

    ## discount & valuation helpers
    r      = 1/β - 1
    κ      = (r + δdeath)/(1 - δdeath)

    const_part = κ * fE / (Z̄ * (1 - 1/μ))

    ## ─── Sector‐level block for a candidate wage w ───────────────
    function sector_block(w)
        Mi = zeros(I);  Ci = similar(Mi);  ρi = similar(Mi)
        di = similar(Mi); vi = similar(Mi); ei = similar(Mi); ψi = similar(Mi)
        yi = similar(Mi); li = similar(Mi); mi = similar(Mi)

        for i in 1:I
            αi        = α[i]
            p_success = Π̄[i]

            # (B) Cᵢ/Mᵢ
            Ci_over_Mi = const_part * w / p_success
            cost       = (w * fE) / (Z̄ * X)

            # (E) pricing → Mᵢ
            Ki        = μ * w/(Z̄ * αi) * (Ci_over_Mi/Z̄)^(1/αi - 1)
            Mi[i]     = Ki^(θ - 1)

            # back out sectorals
            Ci[i]     = Ci_over_Mi * Mi[i]
            yi[i]     = Ci_over_Mi
            li[i]     = (yi[i]/Z̄)^(1/αi)
            di[i]     = (1 - 1/μ)*yi[i]
            vi[i]     = di[i]/κ
            mi[i]     = δdeath/(1 - δdeath)*Mi[i]
            ei[i]     = mi[i]/(cost/vi[i])
            ρi[i]     = Mi[i]^(1/(θ - 1))
            ψi[i]     = ei[i] * (cost/vi[i])^(1/(1 - ϕ))
        end

        # aggregates
        C  = sum(Ci .^ ((η - 1)/η))^(η/(η - 1))
        # total labor
        L  = sum(Mi .* li .+ ei * fE / Z̄)
        # labor to firm production
        Le = sum(ei * fE / Z̄)
        # labor to consumption production
        Lc = L - Le
        # total output
        Y  = w * L + sum(di .* Mi)
        # sectoral labor vector
        L_i = Mi .* li .+ ei * fE / Z̄

        return (; C, L, Le, Lc, Y, Mi, Ci, ρi, di, vi, ei, ψi, li, yi, L_i)
    end

    ## ─── Household intratemporal FOC residual ────────────────────
    function g(w)
        blk = sector_block(w)
        if inelasticL
            return χ - w/blk.C
        else
            return χ * blk.L^(1/φ) - w/blk.C
        end
    end

    ## ─── Find wage w such that g(w)=0 via bisection ──────────────
    w_low, w_high = 1e-4, 1.0
    while sign(g(w_low)) == sign(g(w_high))
        w_high *= 2
        w_high > 1e6 && error("Could not bracket the steady-state wage.")
    end
    w_star = bisection(g, w_low, w_high; tol)

    ## ─── Assemble and return the steady‐state named tuple ─────────
    blk = sector_block(w_star)
    return (
        # aggregates
        w    = w_star,
        L    = blk.L,
        Le   = blk.Le,
        Lc   = blk.Lc,
        Y    = blk.Y,
        r    = r,
        C    = blk.C,

        # sectoral blocks
        M_i    = blk.Mi,
        C_i    = blk.Ci,
        ρ_i    = blk.ρi,
        v_i    = blk.vi,
        d_i    = blk.di,
        e_i    = blk.ei,
        ψ_i    = blk.ψi,
        Π_i    = Π̄,
        α_i    = α,
        l_i    = blk.li,
        y_i    = blk.yi,
        L_i    = blk.L_i,
        s_lag_Z = 1.0,
    )
end



# ──────────────────────────────────────────────────────────

"""
 Nicely print a steady‐state NamedTuple `ss` with:
   • scalars:  w, L, Le, Lc, Y, r, C, s_lag_Z
   • 9‐element vectors: M_i, C_i, ρ_i, v_i, d_i, e_i, ψ_i, Π_i, α_i, l_i, y_i, L_i
"""
function print_ss(ss)
    # 1) scalars
    println("─"^30)
    println(" Steady‐State Scalars ")
    println("─"^30)
    for fld in (:w, :L, :Le, :Lc, :Y, :r, :C, :s_lag_Z)
        @assert hasproperty(ss, fld) "ss has no field $fld"
        println(rpad(string(fld), 10), " = ", getproperty(ss, fld))
    end

    # 2) sectoral vectors 
    vec_fields = (:M_i, :C_i, :ρ_i, :v_i, :d_i, :e_i, :ψ_i, :Π_i, :α_i, :l_i, :y_i, :L_i)
    df = DataFrame(sector = 1:9)
    for fld in vec_fields
        @assert hasproperty(ss, fld) "ss has no field $fld"
        arr = getproperty(ss, fld)
        @assert length(arr) == 9 "field $fld must have length 9"
        clean_name = replace(string(fld),
                             "ρ" => "rho",
                             "Π" => "Pi",
                             "ψ" => "psi",
                             "α" => "alpha")
        df[!, Symbol(clean_name)] = arr
    end

    println("\n", "─"^60)
    println(" Steady‐State Sectoral Vectors (one row per sector) ")
    println("─"^60)
    show(df, allrows=true, allcols=true)
end







# ────────────────────────────────────────────────────────────────────────