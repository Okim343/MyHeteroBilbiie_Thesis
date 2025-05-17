function g1 = dynamic_g1(T, y, x, params, steady_state, it_, T_flag)
% function g1 = dynamic_g1(T, y, x, params, steady_state, it_, T_flag)
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
%   g1
%

if T_flag
    T = testbilbiie.dynamic_g1_tt(T, y, x, params, steady_state, it_);
end
g1 = zeros(34, 41);
g1(1,11)=1;
g1(1,13)=(-(params(9)/y(21)));
g1(1,21)=(-((-(params(9)*y(13)))/(y(21)*y(21))));
g1(2,11)=1;
g1(2,18)=(-(getPowerDeriv(y(18),1/(params(1)-1),1)));
g1(3,12)=1;
g1(3,18)=(-(T(1)*(-y(20))/(y(18)*y(18))));
g1(3,20)=(-(T(1)*1/y(18)));
g1(4,13)=(-(params(3)/y(21)));
g1(4,19)=1;
g1(4,21)=(-((-(y(13)*params(3)))/(y(21)*y(21))));
g1(5,1)=(-(1-params(7)));
g1(5,2)=(-(1-params(7)));
g1(5,18)=1;
g1(6,13)=T(7);
g1(6,14)=params(4)*getPowerDeriv(y(14),1/params(5),1);
g1(6,20)=(-((-y(13))/(y(20)*y(20))));
g1(7,38)=(-((1-params(7))*params(2)*y(20)/y(40)));
g1(7,19)=1;
g1(7,39)=(-((1-params(7))*params(2)*y(20)/y(40)));
g1(7,20)=(-((y(39)+y(38))*(1-params(7))*params(2)*1/y(40)));
g1(7,40)=(-((y(39)+y(38))*(1-params(7))*params(2)*(-y(20))/(y(40)*y(40))));
g1(8,12)=(-y(18));
g1(8,13)=(-y(14));
g1(8,14)=(-y(13));
g1(8,17)=y(19);
g1(8,18)=(-y(12));
g1(8,19)=y(17);
g1(8,20)=1;
g1(9,3)=(-(params(6)*1/y(3)));
g1(9,21)=1/y(21);
g1(9,41)=(-1);
g1(10,15)=1;
g1(10,17)=(-(params(3)/y(21)));
g1(10,21)=(-((-(params(3)*y(17)))/(y(21)*y(21))));
g1(11,14)=(-1);
g1(11,15)=1;
g1(11,16)=1;
g1(12,9)=1;
g1(12,17)=(-y(19));
g1(12,19)=(-y(17));
g1(12,20)=(-1);
g1(13,10)=1;
g1(13,12)=(-y(18));
g1(13,13)=(-y(14));
g1(13,14)=(-y(13));
g1(13,18)=(-y(12));
g1(14,20)=T(7);
g1(14,23)=1;
g1(15,11)=(-(T(9)/T(2)));
g1(15,20)=(-(T(8)/T(2)));
g1(15,22)=1;
g1(16,12)=(-(1/y(12)));
g1(16,26)=1;
g1(17,11)=(-(T(10)/T(3)));
g1(17,12)=(-(T(8)/T(3)));
g1(17,27)=1;
g1(18,13)=(-(1/y(13)));
g1(18,33)=1;
g1(19,11)=(-(T(11)/T(4)));
g1(19,13)=(-(T(8)/T(4)));
g1(19,34)=1;
g1(20,19)=(-(1/y(19)));
g1(20,28)=1;
g1(21,11)=(-(T(12)/T(5)));
g1(21,19)=(-(T(8)/T(5)));
g1(21,29)=1;
g1(22,9)=(-(1/y(9)));
g1(22,36)=1;
g1(23,9)=(-(T(8)/T(6)));
g1(23,11)=(-(T(13)/T(6)));
g1(23,37)=1;
g1(24,14)=(-(1/y(14)));
g1(24,30)=1;
g1(25,15)=(-(1/y(15)));
g1(25,31)=1;
g1(26,16)=(-(1/y(16)));
g1(26,32)=1;
g1(27,17)=(-(1/y(17)));
g1(27,24)=1;
g1(28,18)=(-(1/y(18)));
g1(28,25)=1;
g1(29,11)=(-T(8));
g1(29,35)=1;
g1(30,4)=1;
g1(30,19)=T(7);
g1(30,20)=(-((-y(19))/(y(20)*y(20))));
g1(31,5)=1;
g1(31,9)=(-((-y(19))/(y(9)*y(9))));
g1(31,19)=(-(1/y(9)));
g1(32,6)=1;
g1(32,18)=(-y(19));
g1(32,19)=(-y(18));
g1(33,6)=T(7);
g1(33,7)=1;
g1(33,20)=(-((-y(6))/(y(20)*y(20))));
g1(34,6)=(-(1/y(9)));
g1(34,8)=1;
g1(34,9)=(-((-y(6))/(y(9)*y(9))));

end
