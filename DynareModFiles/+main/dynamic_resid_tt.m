function T = dynamic_resid_tt(T, y, x, params, steady_state, it_)
% function T = dynamic_resid_tt(T, y, x, params, steady_state, it_)
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

assert(length(T) >= 63);

T(1) = 1/(params(4)-1);
T(2) = params(4)/(params(4)-1);
T(3) = T(2)*y(87)/(params(18)*y(84));
T(4) = y(22)/y(21)/y(84);
T(5) = 1/params(18);
T(6) = T(4)^(T(5)-1);
T(7) = 1-1/T(2);
T(8) = params(2)*(1-params(3));
T(9) = y(85)^(1/(1-params(9)));
T(10) = 1/(params(9)-1);
T(11) = params(19)^T(10);
T(12) = T(2)*y(87)/(y(84)*params(21));
T(13) = y(29)/y(28)/y(84);
T(14) = 1/params(21);
T(15) = T(13)^(T(14)-1);
T(16) = params(22)^T(10);
T(17) = T(2)*y(87)/(y(84)*params(24));
T(18) = y(36)/y(35)/y(84);
T(19) = 1/params(24);
T(20) = T(18)^(T(19)-1);
T(21) = params(25)^T(10);
T(22) = T(2)*y(87)/(y(84)*params(27));
T(23) = y(43)/y(42)/y(84);
T(24) = 1/params(27);
T(25) = T(23)^(T(24)-1);
T(26) = params(28)^T(10);
T(27) = T(2)*y(87)/(y(84)*params(30));
T(28) = y(50)/y(49)/y(84);
T(29) = 1/params(30);
T(30) = T(28)^(T(29)-1);
T(31) = params(31)^T(10);
T(32) = T(2)*y(87)/(y(84)*params(33));
T(33) = y(57)/y(56)/y(84);
T(34) = 1/params(33);
T(35) = T(33)^(T(34)-1);
T(36) = params(34)^T(10);
T(37) = T(2)*y(87)/(y(84)*params(36));
T(38) = y(64)/y(63)/y(84);
T(39) = 1/params(36);
T(40) = T(38)^(T(39)-1);
T(41) = params(37)^T(10);
T(42) = T(2)*y(87)/(y(84)*params(39));
T(43) = y(71)/y(70)/y(84);
T(44) = 1/params(39);
T(45) = T(43)^(T(44)-1);
T(46) = params(40)^T(10);
T(47) = T(2)*y(87)/(y(84)*params(42));
T(48) = y(78)/y(77)/y(84);
T(49) = 1/params(42);
T(50) = T(48)^(T(49)-1);
T(51) = params(43)^T(10);
T(52) = (params(5)-1)/params(5);
T(53) = y(22)^T(52)+y(29)^T(52)+y(36)^T(52)+y(43)^T(52)+y(50)^T(52)+y(57)^T(52)+y(64)^T(52)+y(71)^T(52)+y(78)^T(52);
T(54) = (y(22)/(y(21)*y(84)))^T(5);
T(55) = params(13)/y(84);
T(56) = (y(29)/(y(84)*y(28)))^T(14);
T(57) = (y(36)/(y(84)*y(35)))^T(19);
T(58) = (y(43)/(y(84)*y(42)))^T(24);
T(59) = (y(50)/(y(84)*y(49)))^T(29);
T(60) = (y(57)/(y(84)*y(56)))^T(34);
T(61) = (y(64)/(y(84)*y(63)))^T(39);
T(62) = (y(71)/(y(84)*y(70)))^T(44);
T(63) = (y(78)/(y(84)*y(77)))^T(49);

end
