//------------------------------------------------
// main.mod   – drives the whole pipeline
//------------------------------------------------

@#include "declarations.mod"      // var … varexo … parameters …

model;
  @#include "equations.mod"
end;


steady_state_model;
  // 1) Aggregate steady state
  w    = 0.06262480050355407;
  L    = 0.11099948651284855;
  r    = 0.04166666666666674;
  C    = 0.11738613032104049;

  // 2) Sectoral steady state (I = 9)
  M1      = 0.0005204283612358332;
  M2      = 0.0007676219469187895;
  M3      = 0.0008818106632864761;
  M4      = 0.00097434103071902;
  M5      = 0.0010410001675264372;
  M6      = 0.0010912555921917424;
  M7      = 0.0011333153746823387;
  M8      = 0.0011548238681652523;
  M9      = 0.0011474872219058832;

  C1      = 3.0254993414300974e-5;
  C2      = 7.812594637804382e-5;
  C3      = 0.00014697212614915982;
  C4      = 0.0002878206863139975;
  C5      = 0.0005403421962206838;
  C6      = 0.000991248664509965;
  C7      = 0.001871734407528889;
  C8      = 0.003227665523736235;
  C9      = 0.020846540157873447;

  rho1    = 0.06718491467362374;
  rho2    = 0.07718850629494477;
  rho3    = 0.08110780038578369;
  rho4    = 0.08405037198694348;
  rho5    = 0.08606049841116431;
  rho6    = 0.08752187252963735;
  rho7    = 0.08871201044600399;
  rho8    = 0.08930966958773398;
  rho9    = 0.08910661569560191;

  v1      = 0.1001996808056865;
  v2      = 0.17541960925365283;
  v3      = 0.2872697270805232;
  v4      = 0.50914471954109;
  v5      = 0.8946400071936296;
  v6      = 1.5656200125888515;
  v7      = 2.8465818410706394;
  v8      = 4.8172923464272355;
  v9      = 31.312400251777028;

  d1      = 0.015298628908843311;
  d2      = 0.02678331391604221;
  d3      = 0.04386074801847279;
  d4      = 0.0777369355124152;
  d5      = 0.1365949009718153;
  d6      = 0.23904107670067673;
  d7      = 0.4346201394557759;
  d8      = 0.7355110052328515;
  d9      = 4.780821534013534;

  e1      = 8.87427422600637e-5;
  e2      = 0.00022915591579580872;
  e3      = 0.0004310927895989365;
  e4      = 0.0008442241792260478;
  e5      = 0.0015849102194411039;
  e6      = 0.0029074911220658283;
  e7      = 0.005490096852181614;
  e8      = 0.009467260023901615;
  e9      = 0.06114624170996449;

  // 3) Exogenous state shifters
  Z     = 1.0;
  Zlag  = 1.0;
  fE    = fE_par;
  X     = 1.0;

end;


@#include "calibration.mod"       // parameter numbers, shocks, initval …

// -------- Solve & simulate --------

//steady;
check;


model_info ;
// model_diagnostics;


stoch_simul(order=1, irf=25);


//------------------------------------------------
//  declarations.mod
//------------------------------------------------
@#define I = 9

// ─── Predetermined & forward‐looking variables ─────────────
@#for i in 1:I
  var M@{i} C@{i} rho@{i} d@{i} v@{i} e@{i};
@#endfor
var Z X C w L;

// ─── Exogenous shocks ───────────────────────────────────────
varexo eps_Z eps_X;

// ─── Calibration parameters ─────────────────────────────────
parameters
  r        beta    delta   theta   eta     fE_par   Z_par
  chi      phi    varphi     Psi     C_ss  fE
  rho_Z   sigma_Z rho_X   sigma_X  gamma_fE 
@#for i in 1:I
  alpha@{i}  Pi_bar@{i} psi_bar@{i}
@#endfor
;


//------------------------------------------------
//  equations.mod
//------------------------------------------------


// ─── 1.  Sectoral FOCs (6 per sector since Pi_bar is a parameter and m_i is a definition) ───────────────────
@#for i in 1:I
    rho@{i} - M@{i}^(1/(theta-1))                                                     = 0;
    rho@{i} - (theta/(theta-1))*(w/(alpha@{i}*Z))*(C@{i}/M@{i}/Z)^(1/alpha@{i}-1)     = 0;
    d@{i}   - (1 - 1/(theta/(theta-1)))*C@{i}/M@{i}                                   = 0;
    v@{i}   - beta*(1-delta)*(C@{i}/C@{i}(+1))*(v@{i}(+1)+d@{i}(+1))                  = 0;
    e@{i}   - psi_bar@{i}*((w*fE)/(Z*X*v@{i}))^(1/(phi - 1))                          = 0;
    M@{i}   - (1-delta)*(M@{i}(-1) + Pi_bar@{i}*e@{i}(-1))                            = 0;
@#endfor

// ─── 2.  Define top‐level CES aggregate ───────────────
C   = (
    @#for i in 1:I
    + C@{i}^((eta-1)/eta)
    @#endfor
)^(eta/(eta-1));

// ─── 3.  Aggregate FOC ────────────────────────────────
chi*L^(1/varphi)             - w/C         = 0;


// ─── 4.  Aggregate Labor Constraint ────────────────────────────────
L   = (
    @#for i in 1:I
        + (M@{i}*(C@{i}/(Z*M@{i}))^(1/alpha@{i}) + e@{i}*(fE/Z))
    @#endfor
);


// ─── 5.  Shock processes in logs ───────────────────────
ln(Z) - rho_Z*ln(Z(-1)) - eps_Z = 0; // productivity shock
ln(X) - rho_X*ln(X(-1))- eps_X = 0;   // composition shock


%------------------------------------------------
%  calibration.mod
%------------------------------------------------

/*
  1) Scalar calibration
*/
beta      = 0.96;        % discount factor (4% annual interest)
delta     = 0.09631;     % exogenous firm exit rate
theta     = 3.8;         % within‐sector CES parameter
eta       = 2;           % across‐sector substitution elasticity
fE_par    = 1;           % steady‐state entry cost
fE        = 1;           % entry cost normalized
Z_par     = 1;           % productivity normalization
chi       = 0.924271;    % disutility of labor
phi       = 0.3;         % elasticity in the entry function
Psi       = 0.090;       % measure of business opportunities
varphi    = 4;           % elasticity of substitution in the labor aggregator
C_ss      = 0.11738613032104049;           % consumption steady state value
r         = 0.04166666666666674; %interest rate equal to beta^(-1)-1

/*
  2) Sectoral tech & success probabilities
*/

alpha1 = 0.890;  alpha2 = 0.932;  alpha3 = 0.946;
alpha4 = 0.956;  alpha5 = 0.963;  alpha6 = 0.968;
alpha7 = 0.972;  alpha8 = 0.976;  alpha9 = 0.988;

Pi_bar1 = 0.625;  Pi_bar2 = 0.357;  Pi_bar3 = 0.218;
Pi_bar4 = 0.123;  Pi_bar5 = 0.070;  Pi_bar6 = 0.040;
Pi_bar7 = 0.022;  Pi_bar8 = 0.013;  Pi_bar9 = 0.002;

psi_bar1 = 4.5345361614000835e-5 ;
psi_bar2 = 5.2612103735163030e-5 ;
psi_bar3 = 4.8922496063494610e-5 ;
psi_bar4 = 4.2298233608217766e-5 ;
psi_bar5 = 3.5493164580631527e-5 ;
psi_bar6 = 2.9272596208962175e-5 ;
psi_bar7 = 2.3529484214488463e-5 ;
psi_bar8 = 1.9136286564028076e-5 ;
psi_bar9 = 8.5250774644861350e-6 ;

/*
  3) Shock processes
*/
rho_Z   = 0.976;               % AR(1) for productivity
sigma_Z = 0.0072^2;            % variance of eps_Z

rho_X   = 0.415;               % AR(1) for composition shocks
sigma_X = 0.000009;            % (unused)

gamma_fE = 1;                 % persistence of entry‐cost shifter

/*
  4) Initialization of exogenous shocks
*/
initval;
  eps_Z = 0;
  eps_X = 0;
end;

/*
  5) Declare shock variances
*/
shocks;
  var eps_Z;   stderr sqrt(sigma_Z);
  var eps_X;   stderr sqrt(sigma_X);
end;
