//------------------------------------------------
//  equations.mod
//------------------------------------------------

//e@{i}   - psi_bar@{i}*((w(-1)*fE)/(Z(-1)*X(-1)*v@{i}(-1)))^(1/(phi - 1))          = 0;

// ─── 1.  Sectoral FOCs (6 per sector since Pi_bar is a parameter and m_i is a definition) ───────────────────
@#for i in 1:I
    rho@{i} - M@{i}^(1/(theta-1))                                                     = 0;
    rho@{i} - (theta/(theta-1))*(w/(alpha@{i}*Z))*(C@{i}/M@{i}/Z)^(1/alpha@{i}-1)     = 0;
    d@{i}   - (1 - 1/(theta/(theta-1)))*C@{i}/M@{i}                                   = 0;
    v@{i}   - beta*(1-delta)*(C@{i}/C@{i}(+1))*(v@{i}(+1)+d@{i}(+1))                  = 0;
    psi@{i} - psi_bar@{i} * (X)^(1/(1-phi)) * (Z)^(1/(1-phi))                         = 0; // Z doesnt actually belong here, but since Pi is a parameter, we need to define it here to have it impact e and M (trick used by Sedlacek)
    e@{i}   - psi@{i}*(Pi_bar@{i})^(1/(phi - 1))                                      = 0;
    M@{i}   - (1-delta)*(M@{i}(-1) + Pi_bar@{i}*e@{i}(-1))                            = 0;
    y@{i}   - C@{i}/M@{i}                                                             = 0; // This is merely for reporting the definition yi
    l@{i}   - (y@{i}/Z)^(1/alpha@{i})                                                 = 0; // This is merely for reporting the definition li
@#endfor

// ─── 2.  Define top‐level CES aggregate ───────────────
C   = (
    @#for i in 1:I
    + C@{i}^((eta-1)/eta)
    @#endfor
)^(eta/(eta-1));

// ─── 3.  Aggregate FOC ────────────────────────────────
chi*L^(1/varphi)             - w/C         = 0;


// ─── 4.  Aggregate Labor  ────────────────────────────────
L   = (
    @#for i in 1:I
        + (M@{i}*(C@{i}/(Z*M@{i}))^(1/alpha@{i}) + e@{i}*(fE/Z))
    @#endfor
);

Le = (
    @#for i in 1:I
        + (e@{i}*(fE/Z))
    @#endfor
);

Lc = L - Le;

Y = w*L
@#for i in 1:I
  + d@{i}*M@{i}
@#endfor
;

// ─── 5.  Shock processes in logs ───────────────────────
ln(Z) - rho_Z*ln(Z(-1)) - eps_Z = 0; // productivity shock
ln(X) - rho_X*ln(X(-1))- eps_X = 0;   // composition shock


// 6.Empirically Relevant Log Transformations

@#for i in 1:I
    logM@{i} - log(M@{i})= 0;
    logC@{i} - log(C@{i})= 0;
    logd@{i} - log(d@{i})= 0;
    logv@{i} - log(v@{i})= 0;
    loge@{i} - log(e@{i})= 0;
    logy@{i} - log(y@{i})= 0;
    logrho@{i} - log(rho@{i})= 0;
    logl@{i} - log(l@{i})= 0;
@#endfor

logC = log(C);
logw = log(w);
logL = log(L);
logLe = log(Le);
logLc = log(Lc);
logY = log(Y);