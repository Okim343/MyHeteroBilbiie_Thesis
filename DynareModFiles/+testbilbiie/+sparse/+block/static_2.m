function [y, T, residual, g1] = static_2(y, x, params, sparse_rowval, sparse_colval, sparse_colptr, T)
residual=NaN(8, 1);
  residual(1)=(y(8))-(y(15)^(1/(params(1)-1)));
  residual(2)=(y(9))-((1-1/params(9))*y(17)/y(15));
  residual(3)=(y(16))-(y(10)*params(3)/y(18));
  residual(4)=(y(15))-((1-params(7))*(y(15)+y(14)));
  residual(5)=(params(4)*y(11)^(1/params(5)))-(y(10)/y(17));
  residual(6)=(y(16))-((1-params(7))*params(2)*(y(9)+y(16)));
  residual(7)=(y(17)+y(16)*y(14))-(y(10)*y(11)+y(15)*y(9));
  residual(8)=(y(8))-(params(9)*y(10)/y(18));
if nargout > 3
    g1_v = NaN(23, 1);
g1_v(1)=(-(getPowerDeriv(y(15),1/(params(1)-1),1)));
g1_v(2)=(-((1-1/params(9))*(-y(17))/(y(15)*y(15))));
g1_v(3)=1-(1-params(7));
g1_v(4)=(-y(9));
g1_v(5)=(-((1-1/params(9))*1/y(15)));
g1_v(6)=(-((-y(10))/(y(17)*y(17))));
g1_v(7)=1;
g1_v(8)=(-(params(3)/y(18)));
g1_v(9)=(-(1/y(17)));
g1_v(10)=(-y(11));
g1_v(11)=(-(params(9)/y(18)));
g1_v(12)=(-(1-params(7)));
g1_v(13)=y(16);
g1_v(14)=params(4)*getPowerDeriv(y(11),1/params(5),1);
g1_v(15)=(-y(10));
g1_v(16)=1;
g1_v(17)=(-((1-params(7))*params(2)));
g1_v(18)=(-y(15));
g1_v(19)=1;
g1_v(20)=1-(1-params(7))*params(2);
g1_v(21)=y(14);
g1_v(22)=1;
g1_v(23)=1;
    if ~isoctave && matlab_ver_less_than('9.8')
        sparse_rowval = double(sparse_rowval);
        sparse_colval = double(sparse_colval);
    end
    g1 = sparse(sparse_rowval, sparse_colval, g1_v, 8, 8);
end
end
