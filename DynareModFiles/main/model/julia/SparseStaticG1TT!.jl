function SparseStaticG1TT!(T::Vector{<: Real}, y::Vector{<: Real}, x::Vector{<: Real}, params::Vector{<: Real})
    SparseStaticResidTT!(T, y, x, params)
@inbounds begin
T[36] = get_power_deriv(T[4],1/params[18]-1,1)
T[37] = get_power_deriv(T[34],params[4]/(params[4]-1),1)
T[38] = (-(get_power_deriv(y[2],T[33],1)*T[37]))
T[39] = get_power_deriv(T[10],1/params[20]-1,1)
T[40] = (-(T[37]*get_power_deriv(y[9],T[33],1)))
T[41] = get_power_deriv(T[13],1/params[22]-1,1)
T[42] = (-(T[37]*get_power_deriv(y[16],T[33],1)))
T[43] = get_power_deriv(T[16],1/params[24]-1,1)
T[44] = (-(T[37]*get_power_deriv(y[23],T[33],1)))
T[45] = get_power_deriv(T[19],1/params[26]-1,1)
T[46] = (-(T[37]*get_power_deriv(y[30],T[33],1)))
T[47] = get_power_deriv(T[22],1/params[28]-1,1)
T[48] = (-(T[37]*get_power_deriv(y[37],T[33],1)))
T[49] = get_power_deriv(T[25],1/params[30]-1,1)
T[50] = (-(T[37]*get_power_deriv(y[44],T[33],1)))
T[51] = get_power_deriv(T[28],1/params[32]-1,1)
T[52] = (-(T[37]*get_power_deriv(y[51],T[33],1)))
T[53] = get_power_deriv(T[31],1/params[34]-1,1)
T[54] = (-(T[37]*get_power_deriv(y[58],T[33],1)))
T[55] = (-((-(y[68]*y[65]))/(y[64]*y[64])))
T[56] = (-(y[68]/y[64]))
T[57] = (-(y[65]/y[64]))
end
    return nothing
end

