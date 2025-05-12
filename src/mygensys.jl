
module MyGenSys

using LinearAlgebra

export gensys

# Replacement for eye
@inline eye(n::Integer) = Matrix{Float64}(I, n, n)

# Top‐level: accept (Γ0,Γ1,c,Ψ,Π,div)
function gensys(Γ0::Matrix{Float64},
               Γ1::Matrix{Float64},
               c::Vector{Float64},
               Ψ::Matrix{Float64},
               Π::Matrix{Float64},
               div::Float64 = 0.0;
               verbose::Symbol = :high)

    # 1) Schur‐decompose
    F = try
        schur!(complex(Γ0), complex(Γ1))
    catch ex
        if isa(ex, LinearAlgebra.LAPACKException)
            Base.@info "LAPACK exception in Schur"
            eu = [-3,-3]
            return zeros(0,0), Float64[], zeros(0,0),
                   zeros(0,0), zeros(0,0), ComplexF64[],
                   ComplexF64[], eu, zeros(0,0)
        else
            rethrow(ex)
        end
    end

    # 2) pick up a default div if needed
    if div == 0.0
        div = new_div(F)
    end

    return gensys(F, c, Ψ, Π, div; verbose=verbose)
end

# F‐based, full‐output branch
function gensys(F::LinearAlgebra.GeneralizedSchur,
               c::Vector{Float64},
               Ψ::Matrix{Float64},
               Π::Matrix{Float64},
               div::Float64;
               verbose::Symbol = :low)

    # prepare
    n    = size(F.S,1)
    eu   = [0,0]
    ϵ    = 1e-6

    # 3) identify stable eigenvalues
    select = BitVector(undef, n)
    for i in 1:n
        select[i] = !(abs(F.T[i,i]) > div * abs(F.S[i,i]))
    end

    # 4) count unstable = jumps
    nunstab = count(!, select)
    n_jumps = nunstab

    # 5) reorder Schur so stable first
    FS = ordschur!(F, select)
    a, b, qt, z = FS.S, FS.T, FS.Q, FS.Z

    # 6) diagnostic print
    println(">>> gensys DEBUG: total vars n = ", n)
    println(">>> gensys DEBUG: unstable roots nunstab = ", nunstab)
    println(">>> gensys DEBUG: jump variables n_jumps = ", n_jumps)

    # 7) partition Q into stable/unstable blocks
    ns = n - nunstab
    qt1 = qt[:, 1:ns]            # for |λ|<1
    qt2 = qt[:, ns+1:end]        # for |λ|>1
    etawt = adjoint(qt2) * Π

    # 8) compute expected‐error loading for unstable block
    etawt2 = adjoint(qt2) * Π     # size nunstab × neta
    sv2    = svd(etawt2)
    bigev2 = findall(sv2.S .> ϵ)
    neta   = size(Π,2)

    # Right before the existence check in gensys, add:
    println("   ▶ size(Π)       = ", size(Π))
    println("   ▶ size(qt2)     = ", size(qt2))
    println("   ▶ size(etawt)   = ", size(etawt))
    singvals = svd(etawt).S
    println("   ▶ rank(etawt)   = ", sum(singvals .> ϵ), "/", length(singvals))
    println("   ▶ singular vals = ", singvals)


    # 9) existence check
    if length(bigev2) >= nunstab
        eu[1] = 1
    else
        if verbose == :high
            @warn "Nonexistence: #unstab roots > #jumps"
        end
    end

    # 10) compute loading for stable block and SVD
    etawt1 = adjoint(qt1) * Π     # ns × neta
    sv1    = svd(etawt1)
    bigev1 = findall(sv1.S .> ϵ)

    # 11) uniqueness: project out unstable directions
    U2   = sv2.U[:, bigev2]
    V2   = sv2.V[:, bigev2]
    U1   = sv1.U[:, bigev1]
    V1   = sv1.V[:, bigev1]

    # projection matrix onto span{V2}
    P = V2 * adjoint(V2)
    # loose = directions in V1 orthogonal to V2
    loose = V1 .- P * V1

    # test uniqueness
    if isempty(loose)
        eu[2] = 1
    else
        svl = svd(loose)
        nloose = count(x->x>ϵ*n, svl.S)
        if nloose == 0
            eu[2] = 1
        elseif verbose == :high
            @warn "Indeterminacy: $nloose loose endogenous error(s)"
        end
    end

    # 12) build G0, G1
    tmat = hcat(eye(ns), -(U2 * (Diagonal(sv2.S[bigev2]) \ adjoint(V2)) * loose)')
    G0   = vcat(tmat * a,
                hcat(zeros(nunstab, ns), eye(nunstab)))
    G1   = vcat(tmat * b, zeros(nunstab, n))

    G0I    = inv(G0)
    G1s    = G0I * G1

    usub = (ns+1):n
    Busub = b[usub, usub]
    Ausub = a[usub, usub]

    # 13) constant & impact
    Cmat   = G0I * vcat(
                tmat * (adjoint(qt) * c),
                (Ausub - Busub) \ (adjoint(qt2) * c)
             )
    impact = G0I * vcat(
                tmat * (adjoint(qt) * Ψ),
                zeros(nunstab, size(Ψ,2))
             )

    # 14) shock‐ & expectation‐feedback
    fmat = Busub \ Ausub
    fwt  = -Busub \ (adjoint(qt2) * Ψ)
    ywt  = G0I[:, usub]

    # 15) rotate back to original basis
    G1r = real(z * (G1s * adjoint(z)))
    Cr  = real(z * Cmat)
    impr= real(z * impact)

    gev = hcat(diag(a), diag(b))

    return G1r, Cr, impr, fmat, fwt, ywt, gev, eu, loose
end

# compute default div
function new_div(F::LinearAlgebra.GeneralizedSchur)
    ϵ    = 1e-6
    n    = size(F.T, 1)
    a, b = F.S, F.T
    div  = 1.01
    for i in 1:n
        if abs(a[i,i]) > 0
            hd = abs(b[i,i]) / abs(a[i,i])
            if 1 + ϵ < hd <= div
                div = 0.5 * (1 + hd)
            end
        end
    end
    return div
end

end # module MyGenSys
