function [T_order, T] = dynamic_resid_tt(y, x, params, steady_state, T_order, T)
if T_order >= 0
    return
end
T_order = 0;
if size(T, 1) < 6
    T = [T; NaN(6 - size(T, 1), 1)];
end
T(1) = 1-1/params(9);
T(2) = y(51)/y(42);
T(3) = y(43)/y(42);
T(4) = y(44)/y(42);
T(5) = y(50)/y(42);
T(6) = y(40)/y(42);
end
