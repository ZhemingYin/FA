% After setting the target SNR, this function is used to calculate the
% minimum P_T which could make the antenna system to achieve the target.

function P_T = min_P_T_calculation(rays, minSNR, pathLosses, N_F, N_T, G_FFT)

numRays = length(rays{1});
P_T = zeros(1,numRays);
for i = 1:numRays
    P_T(1, i) = 10^((minSNR + pathLosses(1,i) + N_F + N_T - G_FFT) / 10 - 3);
end

end