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
    T = testbilbiie.dynamic_resid_tt(T, y, x, params, steady_state, it_);
end
residual = zeros(34, 1);
    residual(1) = (y(11)) - (params(9)*y(13)/y(21));
    residual(2) = (y(11)) - (y(18)^(1/(params(1)-1)));
    residual(3) = (y(12)) - (T(1)*y(20)/y(18));
    residual(4) = (y(19)) - (y(13)*params(3)/y(21));
    residual(5) = (y(18)) - ((1-params(7))*(y(2)+y(1)));
    residual(6) = (params(4)*y(14)^(1/params(5))) - (y(13)/y(20));
    residual(7) = (y(19)) - ((1-params(7))*params(2)*y(20)/y(40)*(y(39)+y(38)));
    residual(8) = (y(20)+y(19)*y(17)) - (y(13)*y(14)+y(18)*y(12));
    residual(9) = (log(y(21))) - (params(6)*log(y(3))+x(it_, 1));
    residual(10) = (y(15)) - (params(3)*y(17)/y(21));
    residual(11) = (y(16)) - (y(14)-y(15));
    residual(12) = (y(9)) - (y(20)+y(19)*y(17));
    residual(13) = (y(10)) - (y(13)*y(14)+y(18)*y(12));
    residual(14) = (y(23)) - (log(y(20)));
    residual(15) = (y(22)) - (log(T(2)));
    residual(16) = (y(26)) - (log(y(12)));
    residual(17) = (y(27)) - (log(T(3)));
    residual(18) = (y(33)) - (log(y(13)));
    residual(19) = (y(34)) - (log(T(4)));
    residual(20) = (y(28)) - (log(y(19)));
    residual(21) = (y(29)) - (log(T(5)));
    residual(22) = (y(36)) - (log(y(9)));
    residual(23) = (y(37)) - (log(T(6)));
    residual(24) = (y(30)) - (log(y(14)));
    residual(25) = (y(31)) - (log(y(15)));
    residual(26) = (y(32)) - (log(y(16)));
    residual(27) = (y(24)) - (log(y(17)));
    residual(28) = (y(25)) - (log(y(18)));
    residual(29) = (y(35)) - (log(y(11)));
    residual(30) = (y(4)) - (y(19)/y(20));
    residual(31) = (y(5)) - (y(19)/y(9));
    residual(32) = (y(6)) - (y(18)*y(19));
    residual(33) = (y(7)) - (y(6)/y(20));
    residual(34) = (y(8)) - (y(6)/y(9));

end
