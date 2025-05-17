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
BigPsi    = 0.090;       % measure of business opportunities
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
  3) Shock processes 0.0072^2
*/
rho_Z   = 0.9;               % AR(1) for productivity
sigma_Z = (log(1.01))^2;            % variance of eps_Z

rho_X   = 0.415;               % AR(1) for composition shocks
sigma_X = 0.000009;            % variance of composition shocks


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
  var eps_Z = 0.00995;
  var eps_X; stderr sqrt(sigma_X);
end;

