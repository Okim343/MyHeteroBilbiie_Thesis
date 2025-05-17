function [T_order, T] = dynamic_g2_tt(y, x, params, steady_state, T_order, T)
if T_order >= 2
    return
end
[T_order, T] = main_ine.sparse.dynamic_g1_tt(y, x, params, steady_state, T_order, T);
T_order = 2;
if size(T, 1) < 195
    T = [T; NaN(195 - size(T, 1), 1)];
end
T(175) = getPowerDeriv(T(4),T(5)-1,2);
T(176) = getPowerDeriv(y(181),1/(1-params(9)),2);
T(177) = getPowerDeriv(T(13),T(14)-1,2);
T(178) = getPowerDeriv(T(18),T(19)-1,2);
T(179) = getPowerDeriv(T(23),T(24)-1,2);
T(180) = getPowerDeriv(T(28),T(29)-1,2);
T(181) = getPowerDeriv(T(33),T(34)-1,2);
T(182) = getPowerDeriv(T(38),T(39)-1,2);
T(183) = getPowerDeriv(T(43),T(44)-1,2);
T(184) = getPowerDeriv(T(48),T(49)-1,2);
T(185) = getPowerDeriv(T(53),params(5)/(params(5)-1),2);
T(186) = getPowerDeriv(y(118)/(y(117)*y(180)),T(5),2);
T(187) = getPowerDeriv(y(125)/(y(180)*y(124)),T(14),2);
T(188) = getPowerDeriv(y(132)/(y(180)*y(131)),T(19),2);
T(189) = getPowerDeriv(y(139)/(y(180)*y(138)),T(24),2);
T(190) = getPowerDeriv(y(146)/(y(180)*y(145)),T(29),2);
T(191) = getPowerDeriv(y(153)/(y(180)*y(152)),T(34),2);
T(192) = getPowerDeriv(y(160)/(y(180)*y(159)),T(39),2);
T(193) = getPowerDeriv(y(167)/(y(180)*y(166)),T(44),2);
T(194) = getPowerDeriv(y(174)/(y(180)*y(173)),T(49),2);
T(195) = (-((-params(13))*(y(180)+y(180))))/(y(180)*y(180)*y(180)*y(180));
end
