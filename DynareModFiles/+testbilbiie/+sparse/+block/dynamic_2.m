function [y, T, residual, g1] = dynamic_2(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T)
residual=NaN(7, 1);
  y(42)=y(49)^(1/(params(1)-1));
  residual(1)=(params(4)*y(45)^(1/params(5)))-(y(44)/y(51));
  residual(2)=(y(42))-(params(9)*y(44)/y(52));
  residual(3)=(y(49))-((1-params(7))*(y(15)+y(14)));
  residual(4)=(y(51)+y(50)*y(48))-(y(44)*y(45)+y(49)*y(43));
  residual(5)=(y(43))-((1-1/params(9))*y(51)/y(49));
  residual(6)=(y(50))-(y(44)*params(3)/y(52));
  residual(7)=(y(50))-((1-params(7))*params(2)*y(51)/y(85)*(y(84)+y(77)));
if nargout > 3
    g1_v = NaN(25, 1);
g1_v(1)=(-(1-params(7)));
g1_v(2)=(-(1-params(7)));
g1_v(3)=params(4)*getPowerDeriv(y(45),1/params(5),1);
g1_v(4)=(-y(44));
g1_v(5)=(-(1/y(51)));
g1_v(6)=(-(params(9)/y(52)));
g1_v(7)=(-y(45));
g1_v(8)=(-(params(3)/y(52)));
g1_v(9)=getPowerDeriv(y(49),1/(params(1)-1),1);
g1_v(10)=1;
g1_v(11)=(-y(43));
g1_v(12)=(-((1-1/params(9))*(-y(51))/(y(49)*y(49))));
g1_v(13)=y(50);
g1_v(14)=(-y(49));
g1_v(15)=1;
g1_v(16)=y(48);
g1_v(17)=1;
g1_v(18)=1;
g1_v(19)=(-((-y(44))/(y(51)*y(51))));
g1_v(20)=1;
g1_v(21)=(-((1-1/params(9))*1/y(49)));
g1_v(22)=(-((y(84)+y(77))*(1-params(7))*params(2)*1/y(85)));
g1_v(23)=(-((1-params(7))*params(2)*y(51)/y(85)));
g1_v(24)=(-((1-params(7))*params(2)*y(51)/y(85)));
g1_v(25)=(-((y(84)+y(77))*(1-params(7))*params(2)*(-y(51))/(y(85)*y(85))));
    if ~isoctave && matlab_ver_less_than('9.8')
        sparse_rowval = double(sparse_rowval);
        sparse_colval = double(sparse_colval);
    end
    g1 = sparse(sparse_rowval, sparse_colval, g1_v, 7, 21);
end
end
