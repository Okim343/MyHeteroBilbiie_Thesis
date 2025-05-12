# Julia version of bgm_nok.mod (non-capital Bilbiie-Ghironi-Melitz model)
# This script sets up the parameters, computes the steady state, and outlines the simulation.

using NLsolve
using Printf
using LinearAlgebra

#--------------------------------------------------------------------------
# 1. Parameter definitions (same as in Dynare)
#--------------------------------------------------------------------------
const beta   = 0.99
const deltaf = 0.025
const thetta = 3.8
const fe     = 1.0
const chii   = 0.924271
const psii   = 4.0
const phii   = 0.979

# Derived parameters
const r  = beta^(-1) - 1.0          # r = beta^(-1) - 1
const muu = thetta / (thetta - 1)    # muu = thetta/(thetta-1)

#--------------------------------------------------------------------------
# 2. Steady state computation
#
# In Dynare the steady state is given by closed-form formulas.
# Here we set z = 1 and compute n and c using these expressions.
#--------------------------------------------------------------------------
function compute_steady_state()
    z = 1.0
    # Steady state for n from the Dynare initval block:
    n = ((1 - deltaf) / (chii * thetta * (r + deltaf))) *
        (((chii * thetta * (r + deltaf)) / (thetta * (r + deltaf) - r))^(1/(1 + psii))) *
        z / fe

    # Steady state for c from the Dynare code:
    c = (r + deltaf) * (thetta - 1) * fe * n^(thetta/(thetta - 1)) / (1 - deltaf)
    
    # Derived steady state variables:
    rhoo = n^(1/(thetta - 1))
    w    = rhoo * z / muu
    d_val= (1 - 1/muu) * (c / n)
    v    = w * fe / z
    ne   = (deltaf / (1 - deltaf)) * n
    l    = ((w / c) / chii)^(psii)
    Y    = c + ne * v
    YI   = w * l + n * d_val
    le   = ne * fe / z
    lc   = l - le

    # Log variables (for IRFs, etc.)
    ln_c    = log(c)
    ln_ca   = log(c / rhoo)
    ln_d    = log(d_val)
    ln_da   = log(d_val / rhoo)
    ln_w    = log(w)
    ln_wa   = log(w / rhoo)
    ln_v    = log(v)
    ln_vva  = log(v / rhoo)
    ln_Y    = log(Y)
    ln_YA   = log(Y / rhoo)
    ln_l    = log(l)
    ln_le   = log(le)
    ln_lc   = log(lc)
    ln_ne   = log(ne)
    ln_n    = log(n)
    ln_rhoo = log(rhoo)
    
    # Ratios:
    vc  = v / c
    vy  = v / Y
    vn  = v * n
    vnc = vn / c
    vny = vn / Y

    return Dict(
        :z      => z,
        :n      => n,
        :c      => c,
        :rhoo   => rhoo,
        :w      => w,
        :d      => d_val,
        :v      => v,
        :ne     => ne,
        :l      => l,
        :Y      => Y,
        :YI     => YI,
        :le     => le,
        :lc     => lc,
        :ln_c   => ln_c,
        :ln_ca  => ln_ca,
        :ln_d   => ln_d,
        :ln_da  => ln_da,
        :ln_w   => ln_w,
        :ln_wa  => ln_wa,
        :ln_v   => ln_v,
        :ln_vva => ln_vva,
        :ln_Y   => ln_Y,
        :ln_YA  => ln_YA,
        :ln_l   => ln_l,
        :ln_le  => ln_le,
        :ln_lc  => ln_lc,
        :ln_ne  => ln_ne,
        :ln_n   => ln_n,
        :ln_rhoo=> ln_rhoo,
        :vc     => vc,
        :vy     => vy,
        :vn     => vn,
        :vnc    => vnc,
        :vny    => vny
    )
end

# Compute steady state and print values:
ss = compute_steady_state()
@printf("\nSteady state values:\n")
for (key, value) in ss
    @printf("  %10s : %8.4f\n", string(key), value)
end

#--------------------------------------------------------------------------
# 3. Shock specification and simulation setup
#
# In Dynare the shocks block specifies:
#     var e = 0.0072^2;
# Here we simply set the variance for the exogenous shock e.
#--------------------------------------------------------------------------
sigma_e = 0.0072^2
@printf("\nShock variance (sigma_e): %8.6f\n", sigma_e)

#--------------------------------------------------------------------------
# 4. Placeholder for stochastic simulation (IRFs)
#
# Dynare’s stoch_simul (order=2, irf=25) ln_n ln_ne
# performs a second-order approximation and computes impulse response functions for ln_n and ln_ne.
#
# In Julia you might use packages such as PerturbationAnalysis.jl or DSGE.jl to:
#   (i) linearize or take a higher-order approximation of the model,
#  (ii) compute the Jacobian and Hessian matrices, and
# (iii) simulate impulse responses.
#
# The full implementation of such a simulation is beyond this short example.
# Here we only print a note that this part is not implemented.
#--------------------------------------------------------------------------
println("\n[Note] Stochastic simulation and IRF computation (order=2) not implemented in this example.")
println("You can use packages like PerturbationAnalysis.jl or DSGE.jl for a complete solution.")