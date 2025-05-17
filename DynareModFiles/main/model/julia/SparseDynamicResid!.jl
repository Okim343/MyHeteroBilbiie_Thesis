function SparseDynamicResid!(T::Vector{<: Real}, residual::AbstractVector{<: Real}, y::Vector{<: Real}, x::Vector{<: Real}, params::Vector{<: Real}, steady_state::Vector{<: Real})
    @assert length(T) >= 37
    @assert length(residual) == 70
    @assert length(y) == 210
    @assert length(x) == 1
    @assert length(params) == 35
@inbounds begin
residual[1] = y[73]-y[71]^T[1];
residual[2] = y[73]-T[3]*T[5];
residual[3] = y[74]-y[72]*T[6]/y[71];
residual[4] = y[75]-T[7]*y[72]/y[142]*(y[145]+y[144]);
residual[5] = y[75]*params[19]-T[8];
residual[6] = params[19]*y[76]-y[71]*T[9];
residual[7] = y[77]-(1-params[2])*(y[71]+y[71]*T[9]);
residual[8] = y[80]-y[78]^T[1];
residual[9] = y[80]-T[10]*T[12];
residual[10] = y[81]-T[6]*y[79]/y[78];
residual[11] = y[82]-T[7]*y[79]/y[149]*(y[152]+y[151]);
residual[12] = y[82]*params[21]-T[8];
residual[13] = params[21]*y[83]-T[9]*y[78];
residual[14] = y[84]-(1-params[2])*(y[78]+T[9]*y[78]);
residual[15] = y[87]-y[85]^T[1];
residual[16] = y[87]-T[13]*T[15];
residual[17] = y[88]-T[6]*y[86]/y[85];
residual[18] = y[89]-T[7]*y[86]/y[156]*(y[159]+y[158]);
residual[19] = y[89]*params[23]-T[8];
residual[20] = params[23]*y[90]-T[9]*y[85];
residual[21] = y[91]-(1-params[2])*(y[85]+T[9]*y[85]);
residual[22] = y[94]-y[92]^T[1];
residual[23] = y[94]-T[16]*T[18];
residual[24] = y[95]-T[6]*y[93]/y[92];
residual[25] = y[96]-T[7]*y[93]/y[163]*(y[166]+y[165]);
residual[26] = y[96]*params[25]-T[8];
residual[27] = params[25]*y[97]-T[9]*y[92];
residual[28] = y[98]-(1-params[2])*(y[92]+T[9]*y[92]);
residual[29] = y[101]-y[99]^T[1];
residual[30] = y[101]-T[19]*T[21];
residual[31] = y[102]-T[6]*y[100]/y[99];
residual[32] = y[103]-T[7]*y[100]/y[170]*(y[173]+y[172]);
residual[33] = y[103]*params[27]-T[8];
residual[34] = params[27]*y[104]-T[9]*y[99];
residual[35] = y[105]-(1-params[2])*(y[99]+T[9]*y[99]);
residual[36] = y[108]-y[106]^T[1];
residual[37] = y[108]-T[22]*T[24];
residual[38] = y[109]-T[6]*y[107]/y[106];
residual[39] = y[110]-T[7]*y[107]/y[177]*(y[180]+y[179]);
residual[40] = y[110]*params[29]-T[8];
residual[41] = params[29]*y[111]-T[9]*y[106];
residual[42] = y[112]-(1-params[2])*(y[106]+T[9]*y[106]);
residual[43] = y[115]-y[113]^T[1];
residual[44] = y[115]-T[25]*T[27];
residual[45] = y[116]-T[6]*y[114]/y[113];
residual[46] = y[117]-T[7]*y[114]/y[184]*(y[187]+y[186]);
residual[47] = y[117]*params[31]-T[8];
residual[48] = params[31]*y[118]-T[9]*y[113];
residual[49] = y[119]-(1-params[2])*(y[113]+T[9]*y[113]);
residual[50] = y[122]-y[120]^T[1];
residual[51] = y[122]-T[28]*T[30];
residual[52] = y[123]-T[6]*y[121]/y[120];
residual[53] = y[124]-T[7]*y[121]/y[191]*(y[194]+y[193]);
residual[54] = y[124]*params[33]-T[8];
residual[55] = params[33]*y[125]-T[9]*y[120];
residual[56] = y[126]-(1-params[2])*(y[120]+T[9]*y[120]);
residual[57] = y[129]-y[127]^T[1];
residual[58] = y[129]-T[31]*T[33];
residual[59] = y[130]-T[6]*y[128]/y[127];
residual[60] = y[131]-T[7]*y[128]/y[198]*(y[201]+y[200]);
residual[61] = y[131]*params[35]-T[8];
residual[62] = params[35]*y[132]-T[9]*y[127];
residual[63] = y[133]-(1-params[2])*(y[127]+T[9]*y[127]);
    residual[64] = (y[136]) - (T[35]^T[36]);
    residual[65] = (y[137]) - (T[37]^T[36]);
residual[66] = params[7]*y[139]^(1/params[8])-y[138]/y[136];
residual[67] = 1-y[136]*params[1]*(1+y[140])/y[206];
residual[68] = (-(y[136]/params[11]-1));
residual[69] = log(y[134])-params[12]*log(y[64])+x[1];
residual[70] = y[135]-params[17]*y[65];
end
    return nothing
end

