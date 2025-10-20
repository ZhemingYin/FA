% The main code to import and run overall functions. The room model,
% antenna type, use trajectory or not, and the RCS pattern can be chosen.
% If use trajectory, time can be chosen in line 44; If not, the position
% and velocity of robot can be set in line 85-87.

clear;
close all;
clc;

P_T = 0.005;
c = 3e8;
f = 60e9;
lambda = c/f;
B = 2e9;
T = 200e-6;
f_s = 1.28e6;
T_s = 1/f_s;
T_p = 220e-6;
N_s = 256;
N_p = 32;
beta_r = 1; % factor depending on the window function used before FFT along fast time P22
beta_v = 1; % factor depending on the window function used before FFT along slow time P23
% from the radar parameters follow the range and velocity resolutions
delta_r = c * beta_r / (2 * B); % the range resolution of the fast-time frequency P21
delta_v = c * beta_v / (2 * f * T_p * N_p);   % velocity resolution P23

a = 0.2;
R = 50;
N_F = 12;
G_FFT = 39;
minSNR = 15;
P_FA = 1e-3;    % probability of false alarm

% choose the type of room in "empty", "furniture", "triangular", "octahedral", "wall_test" or "wall_reflector_test"
room = 'empty';
% choose a type of antenna, "isotropic" or "microstrip"
antenna_type = "microstrip";
% choose, whether the roboter moves in a trajectory, "yes" or "no"
trajectory_type = "yes";
% choose, whether consider the pattern of reflector, "yes" or "no"
pattern_type = "yes";
% If roboter moves in a trajectory, set t as time between 0-55 to get
% the current position and velocity
t = 31;
% list = [51, 52, 53, 54];
% for i = 1:length(list)
%     t = list(i);
if room == "triangular"
    model = 'room.gltf';
    if pattern_type == "no"
        pattern = isotropic_pattern_generator(a, lambda);
    elseif pattern_type == "yes"
        pattern = load('rcs_pattern_dbsm_cleaned_trihed.mat');
    end
elseif room == "furniture"
    model = 'room_furniture.gltf';
    if pattern_type == "no"
        pattern = isotropic_pattern_generator(a, lambda);
    elseif pattern_type == "yes"
        pattern = load('rcs_pattern_dbsm_cleaned.mat');
    end
elseif room == "octahedral"
    model = 'room_octahedral.gltf';
    if pattern_type == "no"
        pattern = isotropic_pattern_generator(a, lambda);
    elseif pattern_type == "yes"
        pattern = load('rcs_pattern_dbsm_cleaned.mat');
    end
elseif room == "empty"
    model = 'empty.gltf';
    if pattern_type == "no"
        pattern = isotropic_pattern_generator(a, lambda);
    elseif pattern_type == "yes"
        pattern = load('rcs_pattern_dbsm_cleaned.mat');
    end
elseif room == "wall_test"
    model = 'wall_test.gltf';
    pattern = isotropic_pattern_generator(a, lambda);
elseif room == "wall_reflector_test"
    model = 'wall_reflector_test.gltf';
    pattern = isotropic_pattern_generator(a, lambda);
end

if trajectory_type == "no"
    pos_tx = [3;-2;0.5];
    v = [1,2,0];
    orientation = [1, 0, 0, 0];
elseif trajectory_type == "yes"
    [positions, orientations, velocities, pos_tx, orientation, v] = trajectory_generation(t);
    disp(pos_tx)
    disp(v)
end

pos_rx = pos_tx - .001;
% orientation = [1, 0, 0, 0];

if antenna_type == "isotropic"
    rays = raytracing_isotropic(model, pos_tx, f, P_T, pos_rx);
    rays_reflector = reflector_los_isotropic(model, pos_tx, f, P_T);
    [pathloss_reflector, propagationdistances] = reflector_pathloss_isotropic(rays_reflector, a, lambda);
elseif antenna_type == "microstrip"
    rays = raytracing_beampattern(model, pos_tx, f, P_T, pos_rx, orientation);
    rays_reflector = reflector_los_beampattern(model, pos_tx, f, P_T, orientation);
    [pathloss_reflector, propagationdistances] = reflector_pathloss_beampattern(rays_reflector, lambda, orientation, pattern, pattern_type);
end

% rays{1}(1) = [];

disp(propagationdistances)

N_T = thermal_noise_calculation(f_s);

[X_sum, pathLosses, propagationDistance, AoAs, phaseShifts, v_ks] = sample_vector(rays, rays_reflector, pathloss_reflector, N_s, N_p, P_T, R, B, T_s, T, f, v, T_p, N_T, N_F);

% show the minimum P_T for target SNR
% P_T = min_P_T_calculation(rays, minSNR, pathLosses, N_F, N_T, G_FFT);
% [maxP_T, idx] = max(P_T);
% disp(maxP_T)
% disp(idx)

% show the minimum SNR for the particular P_T
SNR = min_SNR_calculation(rays, P_T, pathLosses, N_F, N_T, G_FFT);
[minSNR, idx] = min(SNR(2:end));
disp(minSNR)
disp(idx)

[range_doppler_voltage, range_doppler_power] = range_doppler_map(X_sum, delta_r, delta_v, N_p, N_s, R, t);

[targets, peak_values] = cfar_detector(range_doppler_power, P_FA, delta_r, delta_v, N_p, t, propagationdistances, v_ks, R);
% end