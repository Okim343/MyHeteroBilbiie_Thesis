
//------------------------------------------------
//  declarations.mod
//------------------------------------------------
@#define I = 9

// ─── Predetermined & forward‐looking variables ─────────────
@#for i in 1:I
  var M@{i} C@{i} rho@{i} d@{i} v@{i} e@{i} psi@{i} y@{i} l@{i} L@{i} Y@{i};
@#endfor
var Z X C w L Le Lc Y Yr Cr Ir;

// ─── Exogenous shocks ───────────────────────────────────────
varexo eps_Z eps_X;

// ─── Log Versions ───────────────────────────────────────
@#for i in 1:I
  var logM@{i} logC@{i} logrho@{i} logd@{i} logv@{i} loge@{i} logy@{i} logl@{i} logL@{i} logY@{i};
@#endfor

var logC logw logL logLe logLc logY logYr logCr logIr;

// ─── Calibration parameters ─────────────────────────────────
parameters
  r        beta    delta   theta   eta     fE_par   Z_par
  chi      phi    varphi     BigPsi     C_ss  fE
  rho_Z   sigma_Z rho_X   sigma_X   
@#for i in 1:I
  alpha@{i}  Pi_bar@{i} psi_bar@{i}
@#endfor
;

