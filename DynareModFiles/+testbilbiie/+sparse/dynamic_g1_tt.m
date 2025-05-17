function [T_order, T] = dynamic_g1_tt(y, x, params, steady_state, T_order, T)
if T_order >= 1
    return
end
[T_order, T] = testbilbiie.sparse.dynamic_resid_tt(y, x, params, steady_state, T_order, T);
T_order = 1;
if size(T, 1) < 13
    T = [T; NaN(13 - size(T, 1), 1)];
end
T(7) = (-(1/y(51)));
T(8) = 1/y(42);
T(9) = (-y(51))/(y(42)*y(42));
T(10) = (-y(43))/(y(42)*y(42));
T(11) = (-y(44))/(y(42)*y(42));
T(12) = (-y(50))/(y(42)*y(42));
T(13) = (-y(40))/(y(42)*y(42));
end
