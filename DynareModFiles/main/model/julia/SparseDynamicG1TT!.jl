function SparseDynamicG1TT!(T::Vector{<: Real}, y::Vector{<: Real}, x::Vector{<: Real}, params::Vector{<: Real}, steady_state::Vector{<: Real})
    SparseDynamicResidTT!(T, y, x, params, steady_state)
@inbounds begin
T[38] = get_power_deriv(T[4],1/params[18]-1,1)
T[39] = get_power_deriv(T[35],T[36],1)
T[40] = get_power_deriv(T[37],T[36],1)
T[41] = get_power_deriv(T[11],1/params[20]-1,1)
T[42] = get_power_deriv(T[14],1/params[22]-1,1)
T[43] = get_power_deriv(T[17],1/params[24]-1,1)
T[44] = get_power_deriv(T[20],1/params[26]-1,1)
T[45] = get_power_deriv(T[23],1/params[28]-1,1)
T[46] = get_power_deriv(T[26],1/params[30]-1,1)
T[47] = get_power_deriv(T[29],1/params[32]-1,1)
T[48] = get_power_deriv(T[32],1/params[34]-1,1)
T[49] = (-((-(y[138]*y[135]))/(y[134]*y[134])))
T[50] = (-(y[138]/y[134]))
T[51] = (-(y[135]/y[134]))
end
    return nothing
end

