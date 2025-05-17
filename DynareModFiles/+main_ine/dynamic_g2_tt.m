function T = dynamic_g2_tt(T, y, x, params, steady_state, it_)
% function T = dynamic_g2_tt(T, y, x, params, steady_state, it_)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T             [#temp variables by 1]     double  vector of temporary terms to be filled by function
%   y             [#dynamic variables by 1]  double  vector of endogenous variables in the order stored
%                                                    in M_.lead_lag_incidence; see the Manual
%   x             [nperiods by M_.exo_nbr]   double  matrix of exogenous variables (in declaration order)
%                                                    for all simulation periods
%   steady_state  [M_.endo_nbr by 1]         double  vector of steady state values
%   params        [M_.param_nbr by 1]        double  vector of parameter values in declaration order
%   it_           scalar                     double  time period for exogenous variables for which
%                                                    to evaluate the model
%
% Output:
%   T           [#temp variables by 1]       double  vector of temporary terms
%

assert(length(T) >= 195);

T = main_ine.dynamic_g1_tt(T, y, x, params, steady_state, it_);

T(175) = getPowerDeriv(T(4),T(5)-1,2);
T(176) = getPowerDeriv(y(85),1/(1-params(9)),2);
T(177) = getPowerDeriv(T(13),T(14)-1,2);
T(178) = getPowerDeriv(T(18),T(19)-1,2);
T(179) = getPowerDeriv(T(23),T(24)-1,2);
T(180) = getPowerDeriv(T(28),T(29)-1,2);
T(181) = getPowerDeriv(T(33),T(34)-1,2);
T(182) = getPowerDeriv(T(38),T(39)-1,2);
T(183) = getPowerDeriv(T(43),T(44)-1,2);
T(184) = getPowerDeriv(T(48),T(49)-1,2);
T(185) = getPowerDeriv(T(53),params(5)/(params(5)-1),2);
T(186) = getPowerDeriv(y(22)/(y(21)*y(84)),T(5),2);
T(187) = getPowerDeriv(y(29)/(y(84)*y(28)),T(14),2);
T(188) = getPowerDeriv(y(36)/(y(84)*y(35)),T(19),2);
T(189) = getPowerDeriv(y(43)/(y(84)*y(42)),T(24),2);
T(190) = getPowerDeriv(y(50)/(y(84)*y(49)),T(29),2);
T(191) = getPowerDeriv(y(57)/(y(84)*y(56)),T(34),2);
T(192) = getPowerDeriv(y(64)/(y(84)*y(63)),T(39),2);
T(193) = getPowerDeriv(y(71)/(y(84)*y(70)),T(44),2);
T(194) = getPowerDeriv(y(78)/(y(84)*y(77)),T(49),2);
T(195) = (-((-params(13))*(y(84)+y(84))))/(y(84)*y(84)*y(84)*y(84));

end
