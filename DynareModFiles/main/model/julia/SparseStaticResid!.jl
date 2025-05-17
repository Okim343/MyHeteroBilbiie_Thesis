function SparseStaticResid!(T::Vector{<: Real}, residual::AbstractVector{<: Real}, y::Vector{<: Real}, x::Vector{<: Real}, params::Vector{<: Real})
    @assert length(T) >= 35
    @assert length(residual) == 70
    @assert length(y) == 70
    @assert length(x) == 1
    @assert length(params) == 35
@inbounds begin
residual[1] = y[3]-y[1]^T[1];
residual[2] = y[3]-T[3]*T[5];
residual[3] = y[4]-y[2]*T[6]/y[1];
residual[4] = y[5]-params[1]*(1-params[2])*(y[4]+y[5]);
residual[5] = y[5]*params[19]-T[7];
residual[6] = params[19]*y[6]-y[1]*T[8];
residual[7] = y[7]-(1-params[2])*(y[1]+y[1]*T[8]);
residual[8] = y[10]-y[8]^T[1];
residual[9] = y[10]-T[9]*T[11];
residual[10] = y[11]-T[6]*y[9]/y[8];
residual[11] = y[12]-params[1]*(1-params[2])*(y[11]+y[12]);
residual[12] = y[12]*params[21]-T[7];
residual[13] = params[21]*y[13]-T[8]*y[8];
residual[14] = y[14]-(1-params[2])*(y[8]+T[8]*y[8]);
residual[15] = y[17]-y[15]^T[1];
residual[16] = y[17]-T[12]*T[14];
residual[17] = y[18]-T[6]*y[16]/y[15];
residual[18] = y[19]-params[1]*(1-params[2])*(y[18]+y[19]);
residual[19] = y[19]*params[23]-T[7];
residual[20] = params[23]*y[20]-T[8]*y[15];
residual[21] = y[21]-(1-params[2])*(y[15]+T[8]*y[15]);
residual[22] = y[24]-y[22]^T[1];
residual[23] = y[24]-T[15]*T[17];
residual[24] = y[25]-T[6]*y[23]/y[22];
residual[25] = y[26]-params[1]*(1-params[2])*(y[25]+y[26]);
residual[26] = y[26]*params[25]-T[7];
residual[27] = params[25]*y[27]-T[8]*y[22];
residual[28] = y[28]-(1-params[2])*(y[22]+T[8]*y[22]);
residual[29] = y[31]-y[29]^T[1];
residual[30] = y[31]-T[18]*T[20];
residual[31] = y[32]-T[6]*y[30]/y[29];
residual[32] = y[33]-params[1]*(1-params[2])*(y[32]+y[33]);
residual[33] = y[33]*params[27]-T[7];
residual[34] = params[27]*y[34]-T[8]*y[29];
residual[35] = y[35]-(1-params[2])*(y[29]+T[8]*y[29]);
residual[36] = y[38]-y[36]^T[1];
residual[37] = y[38]-T[21]*T[23];
residual[38] = y[39]-T[6]*y[37]/y[36];
residual[39] = y[40]-params[1]*(1-params[2])*(y[39]+y[40]);
residual[40] = y[40]*params[29]-T[7];
residual[41] = params[29]*y[41]-T[8]*y[36];
residual[42] = y[42]-(1-params[2])*(y[36]+T[8]*y[36]);
residual[43] = y[45]-y[43]^T[1];
residual[44] = y[45]-T[24]*T[26];
residual[45] = y[46]-T[6]*y[44]/y[43];
residual[46] = y[47]-params[1]*(1-params[2])*(y[46]+y[47]);
residual[47] = y[47]*params[31]-T[7];
residual[48] = params[31]*y[48]-T[8]*y[43];
residual[49] = y[49]-(1-params[2])*(y[43]+T[8]*y[43]);
residual[50] = y[52]-y[50]^T[1];
residual[51] = y[52]-T[27]*T[29];
residual[52] = y[53]-T[6]*y[51]/y[50];
residual[53] = y[54]-params[1]*(1-params[2])*(y[53]+y[54]);
residual[54] = y[54]*params[33]-T[7];
residual[55] = params[33]*y[55]-T[8]*y[50];
residual[56] = y[56]-(1-params[2])*(y[50]+T[8]*y[50]);
residual[57] = y[59]-y[57]^T[1];
residual[58] = y[59]-T[30]*T[32];
residual[59] = y[60]-T[6]*y[58]/y[57];
residual[60] = y[61]-params[1]*(1-params[2])*(y[60]+y[61]);
residual[61] = y[61]*params[35]-T[7];
residual[62] = params[35]*y[62]-T[8]*y[57];
residual[63] = y[63]-(1-params[2])*(y[57]+T[8]*y[57]);
    residual[64] = (y[66]) - (T[35]);
    residual[65] = (y[67]) - (T[35]);
residual[66] = params[7]*y[69]^(1/params[8])-y[68]/y[66];
residual[67] = 1-params[1]*(1+y[70]);
residual[68] = (-(y[66]/params[11]-1));
residual[69] = log(y[64])-log(y[64])*params[12]+x[1];
residual[70] = y[65]-y[65]*params[17];
end
    if ~isreal(residual)
        residual = real(residual)+imag(residual).^2;
    end
    return nothing
end

