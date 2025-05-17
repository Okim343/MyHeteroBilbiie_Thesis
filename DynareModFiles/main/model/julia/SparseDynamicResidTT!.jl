function SparseDynamicResidTT!(T::Vector{<: Real}, y::Vector{<: Real}, x::Vector{<: Real}, params::Vector{<: Real}, steady_state::Vector{<: Real})
@inbounds begin
T[1] = 1/(params[3]-1)
T[2] = params[3]/(params[3]-1)
T[3] = T[2]*y[138]/(params[18]*y[134])
T[4] = y[72]/y[71]/y[134]
T[5] = T[4]^(1/params[18]-1)
T[6] = 1-1/T[2]
T[7] = params[1]*(1-params[2])
T[8] = y[138]*y[135]/y[134]
T[9] = params[2]/(1-params[2])
T[10] = T[2]*y[138]/(y[134]*params[20])
T[11] = y[79]/y[78]/y[134]
T[12] = T[11]^(1/params[20]-1)
T[13] = T[2]*y[138]/(y[134]*params[22])
T[14] = y[86]/y[85]/y[134]
T[15] = T[14]^(1/params[22]-1)
T[16] = T[2]*y[138]/(y[134]*params[24])
T[17] = y[93]/y[92]/y[134]
T[18] = T[17]^(1/params[24]-1)
T[19] = T[2]*y[138]/(y[134]*params[26])
T[20] = y[100]/y[99]/y[134]
T[21] = T[20]^(1/params[26]-1)
T[22] = T[2]*y[138]/(y[134]*params[28])
T[23] = y[107]/y[106]/y[134]
T[24] = T[23]^(1/params[28]-1)
T[25] = T[2]*y[138]/(y[134]*params[30])
T[26] = y[114]/y[113]/y[134]
T[27] = T[26]^(1/params[30]-1)
T[28] = T[2]*y[138]/(y[134]*params[32])
T[29] = y[121]/y[120]/y[134]
T[30] = T[29]^(1/params[32]-1)
T[31] = T[2]*y[138]/(y[134]*params[34])
T[32] = y[128]/y[127]/y[134]
T[33] = T[32]^(1/params[34]-1)
T[34] = (params[4]-1)/params[4]
T[35] = y[72]^T[34]+y[79]^T[34]+y[86]^T[34]+y[93]^T[34]+y[100]^T[34]+y[107]^T[34]+y[114]^T[34]+y[121]^T[34]+y[128]^T[34]
T[36] = params[4]/(params[4]-1)
T[37] = y[142]^T[34]+y[149]^T[34]+y[156]^T[34]+y[163]^T[34]+y[170]^T[34]+y[177]^T[34]+y[184]^T[34]+y[191]^T[34]+y[198]^T[34]
end
    return nothing
end

