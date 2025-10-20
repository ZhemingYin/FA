% Calculate the power of thermal noise.

function N_T = thermal_noise_calculation(f_s)

k = 1.38e-23;
T0 = 290;
N_T = 10 * log10(k * T0 * f_s * 10^3);

end