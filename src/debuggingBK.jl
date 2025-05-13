using MyHeteroBilbiie
using MyHeteroBilbiie.Types
using MyHeteroBilbiie.Jacobian: check_determinacy
using MyHeteroBilbiie.LinearSystem: ss_state_vector, ss_control_vector
using DSGE

# 1. Build calibrated model
model = Types.MyHeteroBilbiieModel()

# 2. Compute steady state (keep in NamedTuple)
ss = steady_state(model)

# 3. Build the state & control vectors for Jacobian
s̄ = ss_state_vector(ss, model)       
x̄ = ss_control_vector(ss, model)      

# 4. Construct pred_mask: mark each sector‐incumbent Mᵢ as predetermined
n = length(x̄)
I = length(model.α)
pred_mask = falses(n)
for i in 1:I
    base = 3 + (i-1)*7 + 1
    pred_mask[base] = true
end

# 5. Run the BK determinacy check
λ, n_inside, n_pred = check_determinacy(
    s̄,
    x̄,
    x̄,
    model;
    pred_mask = pred_mask,
    n_pred    = sum(pred_mask)
)

println("""
→ You have $n_inside eigenvalues |λ|<1 
  but $n_pred predetermined variables.
→ $(n_inside == n_pred ? "✓ Blanchard–Kahn conditions satisfied" :
                       "⚠️ BK mismatch – check for indeterminacy or explosive roots")
""")



