function [T_order, T] = dynamic_g2_tt(y, x, params, steady_state, T_order, T)
if T_order >= 2
    return
end
[T_order, T] = testbilbiie.sparse.dynamic_g1_tt(y, x, params, steady_state, T_order, T);
T_order = 2;
if size(T, 1) < 15
    T = [T; NaN(15 - size(T, 1), 1)];
end
T(14) = (-((-1)/(y(51)*y(51))));
T(15) = (-1)/(y(42)*y(42));
end
