using Pkg
Pkg.activate(@__DIR__)
Pkg.instantiate()
using LinearAlgebra
@info "BLAS config: " BLAS.get_config()
using Dynare

ctx = @dynare "DynareModFiles/main.mod" "stoponerror";


using AxisArrayTables
for ie in irf()
   display(ie[1])
   for iv in column_labels(ie[2])
      display(ie[2][iv])
   end
end