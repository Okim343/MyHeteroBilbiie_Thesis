function T = dynamic_g1_tt(T, y, x, params, steady_state, it_)
% function T = dynamic_g1_tt(T, y, x, params, steady_state, it_)
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

assert(length(T) >= 174);

T = main.dynamic_resid_tt(T, y, x, params, steady_state, it_);

T(64) = (-y(22))/(y(21)*y(21))/y(84);
T(65) = getPowerDeriv(T(4),T(5)-1,1);
T(66) = (-(y(84)*y(22)))/(y(21)*y(84)*y(21)*y(84));
T(67) = getPowerDeriv(y(22)/(y(21)*y(84)),T(5),1);
T(68) = T(66)*T(67);
T(69) = 1/y(21)/y(84);
T(70) = getPowerDeriv(y(22),T(52),1);
T(71) = getPowerDeriv(T(53),params(5)/(params(5)-1),1);
T(72) = 1/(y(21)*y(84));
T(73) = (-y(29))/(y(28)*y(28))/y(84);
T(74) = getPowerDeriv(T(13),T(14)-1,1);
T(75) = (-(y(84)*y(29)))/(y(84)*y(28)*y(84)*y(28));
T(76) = getPowerDeriv(y(29)/(y(84)*y(28)),T(14),1);
T(77) = T(75)*T(76);
T(78) = 1/y(28)/y(84);
T(79) = getPowerDeriv(y(29),T(52),1);
T(80) = 1/(y(84)*y(28));
T(81) = (-y(36))/(y(35)*y(35))/y(84);
T(82) = getPowerDeriv(T(18),T(19)-1,1);
T(83) = (-(y(84)*y(36)))/(y(84)*y(35)*y(84)*y(35));
T(84) = getPowerDeriv(y(36)/(y(84)*y(35)),T(19),1);
T(85) = T(83)*T(84);
T(86) = 1/y(35)/y(84);
T(87) = getPowerDeriv(y(36),T(52),1);
T(88) = 1/(y(84)*y(35));
T(89) = (-y(43))/(y(42)*y(42))/y(84);
T(90) = getPowerDeriv(T(23),T(24)-1,1);
T(91) = (-(y(84)*y(43)))/(y(84)*y(42)*y(84)*y(42));
T(92) = getPowerDeriv(y(43)/(y(84)*y(42)),T(24),1);
T(93) = T(91)*T(92);
T(94) = 1/y(42)/y(84);
T(95) = getPowerDeriv(y(43),T(52),1);
T(96) = 1/(y(84)*y(42));
T(97) = (-y(50))/(y(49)*y(49))/y(84);
T(98) = getPowerDeriv(T(28),T(29)-1,1);
T(99) = (-(y(84)*y(50)))/(y(84)*y(49)*y(84)*y(49));
T(100) = getPowerDeriv(y(50)/(y(84)*y(49)),T(29),1);
T(101) = T(99)*T(100);
T(102) = 1/y(49)/y(84);
T(103) = getPowerDeriv(y(50),T(52),1);
T(104) = 1/(y(84)*y(49));
T(105) = (-y(57))/(y(56)*y(56))/y(84);
T(106) = getPowerDeriv(T(33),T(34)-1,1);
T(107) = (-(y(84)*y(57)))/(y(84)*y(56)*y(84)*y(56));
T(108) = getPowerDeriv(y(57)/(y(84)*y(56)),T(34),1);
T(109) = T(107)*T(108);
T(110) = 1/y(56)/y(84);
T(111) = getPowerDeriv(y(57),T(52),1);
T(112) = 1/(y(84)*y(56));
T(113) = (-y(64))/(y(63)*y(63))/y(84);
T(114) = getPowerDeriv(T(38),T(39)-1,1);
T(115) = (-(y(84)*y(64)))/(y(84)*y(63)*y(84)*y(63));
T(116) = getPowerDeriv(y(64)/(y(84)*y(63)),T(39),1);
T(117) = T(115)*T(116);
T(118) = 1/y(63)/y(84);
T(119) = getPowerDeriv(y(64),T(52),1);
T(120) = 1/(y(84)*y(63));
T(121) = (-y(71))/(y(70)*y(70))/y(84);
T(122) = getPowerDeriv(T(43),T(44)-1,1);
T(123) = (-(y(84)*y(71)))/(y(84)*y(70)*y(84)*y(70));
T(124) = getPowerDeriv(y(71)/(y(84)*y(70)),T(44),1);
T(125) = T(123)*T(124);
T(126) = 1/y(70)/y(84);
T(127) = getPowerDeriv(y(71),T(52),1);
T(128) = 1/(y(84)*y(70));
T(129) = (-y(78))/(y(77)*y(77))/y(84);
T(130) = getPowerDeriv(T(48),T(49)-1,1);
T(131) = (-(y(84)*y(78)))/(y(84)*y(77)*y(84)*y(77));
T(132) = getPowerDeriv(y(78)/(y(84)*y(77)),T(49),1);
T(133) = T(131)*T(132);
T(134) = 1/y(77)/y(84);
T(135) = getPowerDeriv(y(78),T(52),1);
T(136) = 1/(y(84)*y(77));
T(137) = T(2)*(-(y(87)*params(18)))/(params(18)*y(84)*params(18)*y(84));
T(138) = (-(y(22)/y(21)))/(y(84)*y(84));
T(139) = T(2)*(-(y(87)*params(21)))/(y(84)*params(21)*y(84)*params(21));
T(140) = (-(y(29)/y(28)))/(y(84)*y(84));
T(141) = T(2)*(-(y(87)*params(24)))/(y(84)*params(24)*y(84)*params(24));
T(142) = (-(y(36)/y(35)))/(y(84)*y(84));
T(143) = T(2)*(-(y(87)*params(27)))/(y(84)*params(27)*y(84)*params(27));
T(144) = (-(y(43)/y(42)))/(y(84)*y(84));
T(145) = T(2)*(-(y(87)*params(30)))/(y(84)*params(30)*y(84)*params(30));
T(146) = (-(y(50)/y(49)))/(y(84)*y(84));
T(147) = T(2)*(-(y(87)*params(33)))/(y(84)*params(33)*y(84)*params(33));
T(148) = (-(y(57)/y(56)))/(y(84)*y(84));
T(149) = T(2)*(-(y(87)*params(36)))/(y(84)*params(36)*y(84)*params(36));
T(150) = (-(y(64)/y(63)))/(y(84)*y(84));
T(151) = T(2)*(-(y(87)*params(39)))/(y(84)*params(39)*y(84)*params(39));
T(152) = (-(y(71)/y(70)))/(y(84)*y(84));
T(153) = T(2)*(-(y(87)*params(42)))/(y(84)*params(42)*y(84)*params(42));
T(154) = (-(y(78)/y(77)))/(y(84)*y(84));
T(155) = (-(y(21)*y(22)))/(y(21)*y(84)*y(21)*y(84));
T(156) = (-params(13))/(y(84)*y(84));
T(157) = (-(y(28)*y(29)))/(y(84)*y(28)*y(84)*y(28));
T(158) = (-(y(35)*y(36)))/(y(84)*y(35)*y(84)*y(35));
T(159) = (-(y(42)*y(43)))/(y(84)*y(42)*y(84)*y(42));
T(160) = (-(y(49)*y(50)))/(y(84)*y(49)*y(84)*y(49));
T(161) = (-(y(56)*y(57)))/(y(84)*y(56)*y(84)*y(56));
T(162) = (-(y(63)*y(64)))/(y(84)*y(63)*y(84)*y(63));
T(163) = (-(y(70)*y(71)))/(y(84)*y(70)*y(84)*y(70));
T(164) = (-(y(77)*y(78)))/(y(84)*y(77)*y(84)*y(77));
T(165) = getPowerDeriv(y(85),1/(1-params(9)),1);
T(166) = T(2)*1/(params(18)*y(84));
T(167) = T(2)*1/(y(84)*params(21));
T(168) = T(2)*1/(y(84)*params(24));
T(169) = T(2)*1/(y(84)*params(27));
T(170) = T(2)*1/(y(84)*params(30));
T(171) = T(2)*1/(y(84)*params(33));
T(172) = T(2)*1/(y(84)*params(36));
T(173) = T(2)*1/(y(84)*params(39));
T(174) = T(2)*1/(y(84)*params(42));

end
