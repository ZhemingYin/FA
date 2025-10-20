% After calculating the minimum P_T value, this function could be used to
% check whether the SNR achieve the target.

function SNR = min_SNR_calculation(rays, P_T, pathLosses, N_F, N_T, G_FFT)

numRays = length(rays{1});
SNR = zeros(1,numRays);
for i = 1:numRays
    SNR(1, i) = 10 * log10(P_T * 1000) - pathLosses(1, i) - N_F - N_T + G_FFT;
end

end