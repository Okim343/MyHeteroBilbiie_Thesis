function residual = dynamic_resid(T, y, x, params, steady_state, it_, T_flag)
% function residual = dynamic_resid(T, y, x, params, steady_state, it_, T_flag)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T             [#temp variables by 1]     double   vector of temporary terms to be filled by function
%   y             [#dynamic variables by 1]  double   vector of endogenous variables in the order stored
%                                                     in M_.lead_lag_incidence; see the Manual
%   x             [nperiods by M_.exo_nbr]   double   matrix of exogenous variables (in declaration order)
%                                                     for all simulation periods
%   steady_state  [M_.endo_nbr by 1]         double   vector of steady state values
%   params        [M_.param_nbr by 1]        double   vector of parameter values in declaration order
%   it_           scalar                     double   time period for exogenous variables for which
%                                                     to evaluate the model
%   T_flag        boolean                    boolean  flag saying whether or not to calculate temporary terms
%
% Output:
%   residual
%

if T_flag
    T = main_ine.dynamic_resid_tt(T, y, x, params, steady_state, it_);
end
residual = zeros(116, 1);
residual(1) = y(23)-y(21)^T(1);
residual(2) = y(23)-T(3)*T(6);
residual(3) = y(24)-y(22)*T(7)/y(21);
residual(4) = y(25)-T(8)*y(22)/y(137)*(y(139)+y(138));
residual(5) = y(27)-params(20)*T(9);
residual(6) = y(26)-y(27)*T(11);
residual(7) = y(21)-(1-params(3))*(y(1)+params(19)*y(2));
residual(8) = y(30)-y(28)^T(1);
residual(9) = y(30)-T(12)*T(15);
residual(10) = y(31)-T(7)*y(29)/y(28);
residual(11) = y(32)-T(8)*y(29)/y(140)*(y(142)+y(141));
residual(12) = y(34)-T(9)*params(23);
residual(13) = y(33)-y(34)*T(16);
residual(14) = y(28)-(1-params(3))*(y(3)+params(22)*y(4));
residual(15) = y(37)-y(35)^T(1);
residual(16) = y(37)-T(17)*T(20);
residual(17) = y(38)-T(7)*y(36)/y(35);
residual(18) = y(39)-T(8)*y(36)/y(143)*(y(145)+y(144));
residual(19) = y(41)-T(9)*params(26);
residual(20) = y(40)-y(41)*T(21);
residual(21) = y(35)-(1-params(3))*(y(5)+params(25)*y(6));
residual(22) = y(44)-y(42)^T(1);
residual(23) = y(44)-T(22)*T(25);
residual(24) = y(45)-T(7)*y(43)/y(42);
residual(25) = y(46)-T(8)*y(43)/y(146)*(y(148)+y(147));
residual(26) = y(48)-T(9)*params(29);
residual(27) = y(47)-y(48)*T(26);
residual(28) = y(42)-(1-params(3))*(y(7)+params(28)*y(8));
residual(29) = y(51)-y(49)^T(1);
residual(30) = y(51)-T(27)*T(30);
residual(31) = y(52)-T(7)*y(50)/y(49);
residual(32) = y(53)-T(8)*y(50)/y(149)*(y(151)+y(150));
residual(33) = y(55)-T(9)*params(32);
residual(34) = y(54)-y(55)*T(31);
residual(35) = y(49)-(1-params(3))*(y(9)+params(31)*y(10));
residual(36) = y(58)-y(56)^T(1);
residual(37) = y(58)-T(32)*T(35);
residual(38) = y(59)-T(7)*y(57)/y(56);
residual(39) = y(60)-T(8)*y(57)/y(152)*(y(154)+y(153));
residual(40) = y(62)-T(9)*params(35);
residual(41) = y(61)-y(62)*T(36);
residual(42) = y(56)-(1-params(3))*(y(11)+params(34)*y(12));
residual(43) = y(65)-y(63)^T(1);
residual(44) = y(65)-T(37)*T(40);
residual(45) = y(66)-T(7)*y(64)/y(63);
residual(46) = y(67)-T(8)*y(64)/y(155)*(y(157)+y(156));
residual(47) = y(69)-T(9)*params(38);
residual(48) = y(68)-y(69)*T(41);
residual(49) = y(63)-(1-params(3))*(y(13)+params(37)*y(14));
residual(50) = y(72)-y(70)^T(1);
residual(51) = y(72)-T(42)*T(45);
residual(52) = y(73)-T(7)*y(71)/y(70);
residual(53) = y(74)-T(8)*y(71)/y(158)*(y(160)+y(159));
residual(54) = y(76)-T(9)*params(41);
residual(55) = y(75)-y(76)*T(46);
residual(56) = y(70)-(1-params(3))*(y(15)+params(40)*y(16));
residual(57) = y(79)-y(77)^T(1);
residual(58) = y(79)-T(47)*T(50);
residual(59) = y(80)-T(7)*y(78)/y(77);
residual(60) = y(81)-T(8)*y(78)/y(161)*(y(163)+y(162));
residual(61) = y(83)-T(9)*params(44);
residual(62) = y(82)-y(83)*T(51);
residual(63) = y(77)-(1-params(3))*(y(17)+params(43)*y(18));
    residual(64) = (y(86)) - (T(53)^(params(5)/(params(5)-1)));
residual(65) = params(8)*y(88)^(1/params(10))-y(87)/y(86);
    residual(66) = (y(88)) - (y(21)*T(54)+y(26)*T(55)+y(28)*T(56)+y(33)*T(55)+y(35)*T(57)+y(40)*T(55)+y(42)*T(58)+y(47)*T(55)+y(49)*T(59)+y(54)*T(55)+y(56)*T(60)+y(61)*T(55)+y(63)*T(61)+y(68)*T(55)+y(70)*T(62)+y(75)*T(55)+y(77)*T(63)+y(82)*T(55));
residual(67) = log(y(84))-params(14)*log(y(19))-x(it_, 1);
residual(68) = log(y(85))-params(16)*log(y(20))-x(it_, 2);
residual(69) = y(89)-log(y(21));
residual(70) = y(90)-log(y(22));
residual(71) = y(91)-log(y(24));
residual(72) = y(92)-log(y(25));
residual(73) = y(93)-log(y(26));
residual(74) = y(94)-log(y(28));
residual(75) = y(95)-log(y(29));
residual(76) = y(96)-log(y(31));
residual(77) = y(97)-log(y(32));
residual(78) = y(98)-log(y(33));
residual(79) = y(99)-log(y(35));
residual(80) = y(100)-log(y(36));
residual(81) = y(101)-log(y(38));
residual(82) = y(102)-log(y(39));
residual(83) = y(103)-log(y(40));
residual(84) = y(104)-log(y(42));
residual(85) = y(105)-log(y(43));
residual(86) = y(106)-log(y(45));
residual(87) = y(107)-log(y(46));
residual(88) = y(108)-log(y(47));
residual(89) = y(109)-log(y(49));
residual(90) = y(110)-log(y(50));
residual(91) = y(111)-log(y(52));
residual(92) = y(112)-log(y(53));
residual(93) = y(113)-log(y(54));
residual(94) = y(114)-log(y(56));
residual(95) = y(115)-log(y(57));
residual(96) = y(116)-log(y(59));
residual(97) = y(117)-log(y(60));
residual(98) = y(118)-log(y(61));
residual(99) = y(119)-log(y(63));
residual(100) = y(120)-log(y(64));
residual(101) = y(121)-log(y(66));
residual(102) = y(122)-log(y(67));
residual(103) = y(123)-log(y(68));
residual(104) = y(124)-log(y(70));
residual(105) = y(125)-log(y(71));
residual(106) = y(126)-log(y(73));
residual(107) = y(127)-log(y(74));
residual(108) = y(128)-log(y(75));
residual(109) = y(129)-log(y(77));
residual(110) = y(130)-log(y(78));
residual(111) = y(131)-log(y(80));
residual(112) = y(132)-log(y(81));
residual(113) = y(133)-log(y(82));
    residual(114) = (y(134)) - (log(y(86)));
    residual(115) = (y(135)) - (log(y(87)));
    residual(116) = (y(136)) - (log(y(88)));

end
