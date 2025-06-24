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
varphi    = 0;           % elasticity of substitution in the labor aggregator (Inelastic labor)
C_ss      = 1.700502012234013;           % consumption steady state value
r         = 0.04166666666666674;         % interest rate equal to beta^(-1)-1

/*
  2) Sectoral tech & success probabilities
*/

alpha1 = 0.890;  alpha2 = 0.932;  alpha3 = 0.946;
alpha4 = 0.956;  alpha5 = 0.963;  alpha6 = 0.968;
alpha7 = 0.972;  alpha8 = 0.976;  alpha9 = 0.988;

Pi_bar1 = 0.625;  Pi_bar2 = 0.357;  Pi_bar3 = 0.218;
Pi_bar4 = 0.123;  Pi_bar5 = 0.070;  Pi_bar6 = 0.040;
Pi_bar7 = 0.022;  Pi_bar8 = 0.013;  Pi_bar9 = 0.002;

psi_bar1 = 2.4849167507183568e-5;
psi_bar2 = 2.962350244842537e-5;
psi_bar3 = 2.7781198791930234e-5;
psi_bar4 = 2.416213425111354e-5;
psi_bar5 = 2.0357549454442965e-5;
psi_bar6 = 1.6837942332060095e-5;
psi_bar7 = 1.356527323909209e-5;
psi_bar8 = 1.1057426631013021e-5;
psi_bar9 = 4.958929060919093e-6;

/*
  3) Shock processes 
*/
rho_Z   = 0.9;                 % AR(1) for productivity
sigma_Z = (log(1.01))^2;       % variance of eps_Z

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
