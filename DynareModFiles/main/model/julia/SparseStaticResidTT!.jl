function SparseStaticResidTT!(T::Vector{<: Real}, y::Vector{<: Real}, x::Vector{<: Real}, params::Vector{<: Real})
@inbounds begin
T[1] = 1/(params[3]-1)
T[2] = params[3]/(params[3]-1)
T[3] = T[2]*y[68]/(params[18]*y[64])
T[4] = y[2]/y[1]/y[64]
T[5] = T[4]^(1/params[18]-1)
T[6] = 1-1/T[2]
T[7] = y[68]*y[65]/y[64]
T[8] = params[2]/(1-params[2])
T[9] = T[2]*y[68]/(y[64]*params[20])
T[10] = y[9]/y[8]/y[64]
T[11] = T[10]^(1/params[20]-1)
T[12] = T[2]*y[68]/(y[64]*params[22])
T[13] = y[16]/y[15]/y[64]
T[14] = T[13]^(1/params[22]-1)
T[15] = T[2]*y[68]/(y[64]*params[24])
T[16] = y[23]/y[22]/y[64]
T[17] = T[16]^(1/params[24]-1)
T[18] = T[2]*y[68]/(y[64]*params[26])
T[19] = y[30]/y[29]/y[64]
T[20] = T[19]^(1/params[26]-1)
T[21] = T[2]*y[68]/(y[64]*params[28])
T[22] = y[37]/y[36]/y[64]
T[23] = T[22]^(1/params[28]-1)
T[24] = T[2]*y[68]/(y[64]*params[30])
T[25] = y[44]/y[43]/y[64]
T[26] = T[25]^(1/params[30]-1)
T[27] = T[2]*y[68]/(y[64]*params[32])
T[28] = y[51]/y[50]/y[64]
T[29] = T[28]^(1/params[32]-1)
T[30] = T[2]*y[68]/(y[64]*params[34])
T[31] = y[58]/y[57]/y[64]
T[32] = T[31]^(1/params[34]-1)
T[33] = (params[4]-1)/params[4]
T[34] = y[2]^T[33]+y[9]^T[33]+y[16]^T[33]+y[23]^T[33]+y[30]^T[33]+y[37]^T[33]+y[44]^T[33]+y[51]^T[33]+y[58]^T[33]
T[35] = T[34]^(params[4]/(params[4]-1))
end
    return nothing
end

