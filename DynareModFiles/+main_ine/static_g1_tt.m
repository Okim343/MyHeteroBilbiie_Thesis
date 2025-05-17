function T = static_g1_tt(T, y, x, params)
% function T = static_g1_tt(T, y, x, params)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T         [#temp variables by 1]  double   vector of temporary terms to be filled by function
%   y         [M_.endo_nbr by 1]      double   vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1]       double   vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1]     double   vector of parameter values in declaration order
%
% Output:
%   T         [#temp variables by 1]  double   vector of temporary terms
%

assert(length(T) >= 74);

T = main_ine.static_resid_tt(T, y, x, params);

T(54) = getPowerDeriv(T(4),1/params(18)-1,1);
T(55) = getPowerDeriv(y(2)/(y(1)*y(64)),1/params(18),1);
T(56) = getPowerDeriv(T(43),params(5)/(params(5)-1),1);
T(57) = getPowerDeriv(T(11),1/params(21)-1,1);
T(58) = getPowerDeriv(y(9)/(y(64)*y(8)),1/params(21),1);
T(59) = getPowerDeriv(T(15),1/params(24)-1,1);
T(60) = getPowerDeriv(y(16)/(y(64)*y(15)),1/params(24),1);
T(61) = getPowerDeriv(T(19),1/params(27)-1,1);
T(62) = getPowerDeriv(y(23)/(y(64)*y(22)),1/params(27),1);
T(63) = getPowerDeriv(T(23),1/params(30)-1,1);
T(64) = getPowerDeriv(y(30)/(y(64)*y(29)),1/params(30),1);
T(65) = getPowerDeriv(T(27),1/params(33)-1,1);
T(66) = getPowerDeriv(y(37)/(y(64)*y(36)),1/params(33),1);
T(67) = getPowerDeriv(T(31),1/params(36)-1,1);
T(68) = getPowerDeriv(y(44)/(y(64)*y(43)),1/params(36),1);
T(69) = getPowerDeriv(T(35),1/params(39)-1,1);
T(70) = getPowerDeriv(y(51)/(y(64)*y(50)),1/params(39),1);
T(71) = getPowerDeriv(T(39),1/params(42)-1,1);
T(72) = getPowerDeriv(y(58)/(y(64)*y(57)),1/params(42),1);
T(73) = (-params(13))/(y(64)*y(64));
T(74) = getPowerDeriv(y(65),1/(1-params(9)),1);

end
