
####################################################################
#  src/jacobian.jl – dense Jacobian blocks for eqcond.jl           #
#                                                                  #
#  Splits the Jacobian into G1 (x_{t+1}) and G0 (x_t) so they can  #
#  be fed directly to gensys or any other linear-solver routine.   #
#  System dimension: 3 + 7·I controls/residuals.                   #
####################################################################

module Jacobian

using ForwardDiff, LinearAlgebra
import ..EqCond: eqcond                 # residual function (non-mutating)
import ..Types: MyHeteroBilbiieModel

export build_G_blocks

# ────────────────────────────────────────────────────────────
# Helpers – system size depends only on the number of sectors
# ────────────────────────────────────────────────────────────
_n_controls(model)  = 3 + 8 * length(model.α)      # w,L,r  + 7 per sector
_n_residuals(model) = _n_controls(model)           # square system

# ────────────────────────────────────────────────────────────
# Residual stacker for z = [x_{t+1}; x_t] at given state s_t
# ────────────────────────────────────────────────────────────
"""
    fstack(z, model, s) -> Vector

Convenience wrapper that returns the stacked residual vector
`eqcond(model, s, x_t, x_{t+1})` for a single input `z = [x_{t+1}; x_t]`.
Allocated form, suitable for ForwardDiff.
"""
function fstack(z::AbstractVector{TZ},
                model::MyHeteroBilbiieModel,
                s::AbstractVector{TS}) where {TZ,TS}

    n = _n_controls(model)
    x_next = @view z[1:n]          # x_{t+1}
    x_curr = @view z[n+1:2n]       # x_t

    # promote state vector to the element type of z (Duals when AD runs)
    s_prom = convert.(TZ, s)

    return eqcond(model, s_prom, x_curr, x_next)
end

# ────────────────────────────────────────────────────────────
# Public entry point
# ────────────────────────────────────────────────────────────
"""
    build_G_blocks(s, x_next, x, model) -> (G1, G0)

* `s`      – state vector (length `I + 3`)
* `x_next` – control vector x_{t+1}
* `x`      – control vector x_t
* `model`  – `MyHeteroBilbiieModel`

Returns the dense Jacobian split  
`G1 · x_{t+1} + G0 · x_t = 0`.
"""
function build_G_blocks(s::AbstractVector,
                        x_next::AbstractVector,
                        x::AbstractVector,
                        model::MyHeteroBilbiieModel)

    n = _n_controls(model)
    @assert length(x_next) == n && length(x) == n "control-vector length mismatch"

    z = [x_next; x]                               # stacked vector (length 2n)

    # define a closure with the correct signature for ForwardDiff
    f(u) = fstack(u, model, s)

    J = ForwardDiff.jacobian(f, z)                # dense n × 2n matrix

    G1 = J[:, 1:n]        # columns premultiplying x_{t+1}
    G0 = J[:, n+1:2n]     # columns premultiplying x_t
    return G1, G0
end

"""
    check_determinacy(s, x_next, x, model; pred_mask=nothing)

Compute the generalized eigenvalues of (G0, G1) at your steady state,
count how many satisfy |λ| < 1 and compare against your predetermined
variable count.

# Arguments
- `s`, `x_next`, `x`, `model`:    same inputs you already pass to `build_G_blocks`
- `pred_mask`:  `Bool` vector of length `n_controls(model)` marking which
                controls are predetermined (backward‐looking).  If you
                prefer, just pass `n_pred` as an Int and omit `pred_mask`.

# Returns
- `λ`:  vector of all generalized eigenvalues
- `n_inside`:  count(|λ| < 1)
- `n_pred`:    sum(pred_mask) or your supplied `n_pred`
"""
function check_determinacy(s, x_next, x, model; pred_mask=nothing, n_pred::Integer=nothing)
    # 1) build G blocks
    G1, G0 = build_G_blocks(s, x_next, x, model)

    # Sanity checks on G0, G1
    @assert all(isfinite, G0)   "G0 contains non-finite entries!"
    @assert all(isfinite, G1)   "G1 contains non-finite entries!"

    # Print dimensions and ranks
    println("G0 size: ", size(G0), "   rank: ", rank(Matrix(G0)))
    println("G1 size: ", size(G1), "   rank: ", rank(Matrix(G1)))


    # 1) Compute the ℓ₂-norm of each column of G₁
    col_norms = [norm(G1[:, j]) for j in 1:size(G1, 2)]

    # 2) Tolerance for “zero” columns
    tol = 1e-8

    # 3) Find all columns where every coefficient is effectively zero
    zero_cols = findall(norm_val -> norm_val < tol, col_norms)

    println("→ Columns of G₁ with no t+1 terms (length $(length(zero_cols))):")
    println(zero_cols)

    # Identify any static equations that have NO coefficients
    bad_rows = findall(i -> all(abs.(G0[i, :]) .< tol) && all(abs.(G1[i, :]) .< tol), 1:size(G0,1))
    println("→ Static equations with no nonzero coefficients at rows: ", bad_rows)

    # 2) gen eigenvalues of (G0, G1)
    λ = eigvals(G0, G1)

    # 3) count inside unit circle
    n_inside = count(abs.(λ) .< 1.0)

    # 4) determine how many pred vars you have
    if pred_mask !== nothing
        n_pred = sum(pred_mask)
    elseif n_pred === nothing
        error("must supply either pred_mask or n_pred")
    end

    # 5) print a quick diagnostic
    println("→ Generalized eigenvalues:\n   ", λ)
    println("→ #|λ|<1:", n_inside, "   #predetermined:", n_pred)

    return λ, n_inside, n_pred
end


end # module
