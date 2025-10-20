% Calculate the path loss of line-of-sight rays in the case of isotropic
% antenna.

function [pathloss, propagationdistances] = reflector_pathloss_isotropic(rays, a, lambda)

numRays = length(rays{1});
pathloss = zeros(1,numRays);
propagationdistances = zeros(1,numRays);
G_T = 1;
G_R = 1;
sigma = 4 * pi * a^4 / 3 / lambda^2;
for i = 1:numRays
    ray = rays{1}(i);
    propagationdistance = ray.PropagationDistance;
    propagationdistances(1, i) = propagationdistance;
    % sigma = rcs_analytical(AoDs(1,i), AoDs(2,i));
    pathloss(1, i) = 10 * log10(G_T * G_R * lambda^2 * sigma / (4 * pi)^3 / propagationdistance^4);
end

end