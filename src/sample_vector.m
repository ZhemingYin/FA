% With the result of raytracing, the baseband signal is modeled here.

function [X_sum, pathLosses, propagationDistance, AoAs, phaseShifts, v_ks] = sample_vector(rays, rays_reflector, pathloss_reflector, N_s, N_p, P_T, R, B, T_s, T, f, v, T_p, N_T, N_F)

numRays = length(rays{1});
numRays_reflector = length(rays_reflector{1});
wholeNum = numRays + numRays_reflector;
pathLosses = zeros(1, wholeNum);
propagationDistance = zeros(1, wholeNum);
AoAs = zeros(2, wholeNum);
phaseShifts = zeros(1,wholeNum);
X_sum = zeros(N_s,N_p);
c = 3e8;
v_ks = zeros(1, numRays_reflector);
average = 0;

for i = 1:numRays
    ray = rays{1}(i);
    % disp(properties(ray));
    % disp(methods(ray));

    X_k = zeros(N_s,N_p);

    pathLosses(1,i) = ray.PathLoss;
    propagationDistance(1,i) = ray.PropagationDistance / 2;
    % propagationDistance(1,i) = 3;
    AoAs(:,i) = ray.AngleOfArrival;
    phaseShifts(1,i) = ray.PhaseShift;
    average = average + pathLosses(1,i);

    if propagationDistance(1,i) < 0.1
        continue;
    end

    if propagationDistance(1,i) > 0.45 && propagationDistance(1,i) < 0.55
        continue;
    end

    az = deg2rad(AoAs(1, i));
    el = deg2rad(AoAs(2, i));
    d_x = cos(el) * cos(az);
    d_y = cos(el) * sin(az);
    d_z = sin(el);
    d = [d_x, d_y, d_z];
    v_k = dot(v, d);

    for n_s = 0:N_s-1
        for n_p = 0:N_p-1
            P_R = P_T * 10^(-pathLosses(1,i)/10); %received power
            U_R_a = sqrt(P_R * R); % sinusoidal signal --> amplitude = rms * sqrt(2)
            X_k(n_s+1,n_p+1) = U_R_a * exp(2*pi*1j*(2*B*propagationDistance(1,i)*T_s*n_s/T/c + 2*f*v_k*T_p*n_p/c));
        end
    end
    X_sum = X_sum + X_k;

end
% average = average / numRays;
% disp(average)
% 
% pl = median(pathLosses(2:numRays));
% disp(pl)

for i = numRays+1 : wholeNum
    ray = rays_reflector{1}(i-numRays);
    % disp(properties(ray));
    % disp(methods(ray));

    X_k = zeros(N_s,N_p);

    pathLosses(1,i) = pathloss_reflector(1, i-numRays) * (-1);
    propagationDistance(1,i) = ray.PropagationDistance;
    % propagationDistance(1,i) = 3;
    AoAs(:,i) = ray.AngleOfDeparture;
    % AoAs(1,i) = AoAs(1,i) - 180;
    % AoAs(2,i) = -AoAs(2,i);
    phaseShifts(1,i) = ray.PhaseShift;

    % if propagationDistance(1,i) < 0.1 || propagationDistance(1,i) == 0.5
    %     continue;
    % end

    az = deg2rad(AoAs(1, i));
    el = deg2rad(AoAs(2, i));
    d_x = cos(el) * cos(az);
    d_y = cos(el) * sin(az);
    d_z = sin(el);
    d = [d_x, d_y, d_z];
    v_k = dot(v, d);
    v_ks(1, i-numRays) = v_k;

    for n_s = 0:N_s-1
        for n_p = 0:N_p-1
            P_R = P_T * 10^(-pathLosses(1,i)/10); %received power
            U_R_a = sqrt(P_R * R); % sinusoidal signal --> amplitude = rms * sqrt(2)
            X_k(n_s+1,n_p+1) = U_R_a * exp(2*pi*1j*(2*B*propagationDistance(1,i)*T_s*n_s/T/c + 2*f*v_k*T_p*n_p/c));
        end
    end
    X_sum = X_sum + X_k;

end

% add Gaussian thermal noise with power P_n
P_noise = 10^((N_T - 30 + N_F)/10);
V_noise = P_noise * R; % voltage noise variance = mean square voltage
Gaussian_noise = sqrt(V_noise/2) * (randn(N_s, N_p) + 1j* randn(N_s, N_p));

X_sum = X_sum + Gaussian_noise;
end