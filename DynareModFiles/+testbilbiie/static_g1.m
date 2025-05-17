function g1 = static_g1(T, y, x, params, T_flag)
% function g1 = static_g1(T, y, x, params, T_flag)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T         [#temp variables by 1]  double   vector of temporary terms to be filled by function
%   y         [M_.endo_nbr by 1]      double   vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1]       double   vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1]     double   vector of parameter values in declaration order
%                                              to evaluate the model
%   T_flag    boolean                 boolean  flag saying whether or not to calculate temporary terms
%
% Output:
%   g1
%

if T_flag
    T = testbilbiie.static_g1_tt(T, y, x, params);
end
g1 = zeros(34, 34);
g1(1,8)=1;
g1(1,10)=(-(params(9)/y(18)));
g1(1,18)=(-((-(params(9)*y(10)))/(y(18)*y(18))));
g1(2,8)=1;
g1(2,15)=(-(getPowerDeriv(y(15),1/(params(1)-1),1)));
g1(3,9)=1;
g1(3,15)=(-((1-1/params(9))*(-y(17))/(y(15)*y(15))));
g1(3,17)=(-((1-1/params(9))*1/y(15)));
g1(4,10)=(-(params(3)/y(18)));
g1(4,16)=1;
g1(4,18)=(-((-(y(10)*params(3)))/(y(18)*y(18))));
g1(5,14)=(-(1-params(7)));
g1(5,15)=1-(1-params(7));
g1(6,10)=T(1);
g1(6,11)=params(4)*getPowerDeriv(y(11),1/params(5),1);
g1(6,17)=(-((-y(10))/(y(17)*y(17))));
g1(7,9)=(-((1-params(7))*params(2)));
g1(7,16)=1-(1-params(7))*params(2);
g1(8,9)=(-y(15));
g1(8,10)=(-y(11));
g1(8,11)=(-y(10));
g1(8,14)=y(16);
g1(8,15)=(-y(9));
g1(8,16)=y(14);
g1(8,17)=1;
g1(9,18)=1/y(18)-params(6)*1/y(18);
g1(10,12)=1;
g1(10,14)=(-(params(3)/y(18)));
g1(10,18)=(-((-(params(3)*y(14)))/(y(18)*y(18))));
g1(11,11)=(-1);
g1(11,12)=1;
g1(11,13)=1;
g1(12,6)=1;
g1(12,14)=(-y(16));
g1(12,16)=(-y(14));
g1(12,17)=(-1);
g1(13,7)=1;
g1(13,9)=(-y(15));
g1(13,10)=(-y(11));
g1(13,11)=(-y(10));
g1(13,15)=(-y(9));
g1(14,17)=T(1);
g1(14,20)=1;
g1(15,8)=(-((-y(17))/(y(8)*y(8))/(y(17)/y(8))));
g1(15,17)=(-(T(2)/(y(17)/y(8))));
g1(15,19)=1;
g1(16,9)=(-(1/y(9)));
g1(16,23)=1;
g1(17,8)=(-((-y(9))/(y(8)*y(8))/(y(9)/y(8))));
g1(17,9)=(-(T(2)/(y(9)/y(8))));
g1(17,24)=1;
g1(18,10)=(-(1/y(10)));
g1(18,30)=1;
g1(19,8)=(-((-y(10))/(y(8)*y(8))/(y(10)/y(8))));
g1(19,10)=(-(T(2)/(y(10)/y(8))));
g1(19,31)=1;
g1(20,16)=(-(1/y(16)));
g1(20,25)=1;
g1(21,8)=(-((-y(16))/(y(8)*y(8))/(y(16)/y(8))));
g1(21,16)=(-(T(2)/(y(16)/y(8))));
g1(21,26)=1;
g1(22,6)=(-(1/y(6)));
g1(22,33)=1;
g1(23,6)=(-(T(2)/(y(6)/y(8))));
g1(23,8)=(-((-y(6))/(y(8)*y(8))/(y(6)/y(8))));
g1(23,34)=1;
g1(24,11)=(-(1/y(11)));
g1(24,27)=1;
g1(25,12)=(-(1/y(12)));
g1(25,28)=1;
g1(26,13)=(-(1/y(13)));
g1(26,29)=1;
g1(27,14)=(-(1/y(14)));
g1(27,21)=1;
g1(28,15)=(-(1/y(15)));
g1(28,22)=1;
g1(29,8)=(-T(2));
g1(29,32)=1;
g1(30,1)=1;
g1(30,16)=T(1);
g1(30,17)=(-((-y(16))/(y(17)*y(17))));
g1(31,2)=1;
g1(31,6)=(-((-y(16))/(y(6)*y(6))));
g1(31,16)=(-(1/y(6)));
g1(32,3)=1;
g1(32,15)=(-y(16));
g1(32,16)=(-y(15));
g1(33,3)=T(1);
g1(33,4)=1;
g1(33,17)=(-((-y(3))/(y(17)*y(17))));
g1(34,3)=(-(1/y(6)));
g1(34,5)=1;
g1(34,6)=(-((-y(3))/(y(6)*y(6))));

end
