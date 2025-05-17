using Pkg
Pkg.activate(@__DIR__)
Pkg.instantiate()
using LinearAlgebra
@info "BLAS config: " BLAS.get_config()
using Dynare

ctx = @dynare "main.mod"

# 3) Grab the IRFs from the context
#    ctx.irfs is a Dict{String,Array{Float64,2}}: shock ⇒ matrix (vars × periods)
irfs = ctx.irfs

# e.g. for the productivity shock "eps_Z":
irf_epsZ = irfs["eps_Z"]       # rows correspond to the order of endogenous variables

# 4) You probably want a mapping from endogenous names to row indices:
varnames = ctx.out_varnames    # e.g. ["M1","M2",…,"C1",…,"w","L","r",…]
# Then you can pick out a series:
w_idx = findfirst(isequal("w"), varnames)
w_irf = irf_epsZ[w_idx, :]

# 5) (Optional) Save IRFs for later plotting
#    Here’s one way—write each variable as a CSV with time in the first column
using CSV, DataFrames

T = size(irf_epsZ,2)
time = 0:(T-1)                 # periods 0…T-1
for (i,var) in enumerate(varnames)
    df = DataFrame(time = time, irf = irf_epsZ[i, :])
    CSV.write(joinpath("irfs", "epsZ_$(var).csv"), df)
end

println("Done: IRFs saved to ./irfs/")