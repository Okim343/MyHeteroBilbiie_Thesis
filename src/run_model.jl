using LinearAlgebra
@info "BLAS config: " BLAS.get_config() # Used for debugging since BLAS is currently unstable in Dynare.jl depending on the Julia version
using Dynare

ctx = @dynare "src/DynareModFiles/main.mod" "stoponerror";


using AxisArrayTables
for ie in irf()
   display(ie[1])
   for iv in column_labels(ie[2])
      display(ie[2][iv])
   end
end