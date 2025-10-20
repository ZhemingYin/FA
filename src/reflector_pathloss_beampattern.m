% Calculate the path loss of line-of-sight rays in the case of microstrip
% antenna.

function [pathloss, propagationdistances] = reflector_pathloss_beampattern(rays, lambda, orientation, reflector_pattern, pattern_type)

numRays = length(rays{1});
pathloss = zeros(1,numRays);

%% Antenna Properties 

antennaObject = design(patchMicrostrip, 60*1e9);
antennaObject.Length = 0.0019908;
antennaObject.Width = 0.00119211;
antennaObject.Height = 3.699e-04;
antennaObject.Substrate.Thickness = 4.8995e-04;
antennaObject.GroundPlaneLength = 0.0023848;
antennaObject.GroundPlaneWidth = 0.0013152;
antennaObject.PatchCenterOffset = [-0.000305792, -0.00024];
antennaObject.FeedOffset = [-0.00108916, -0.00057];
antennaObject.Conductor.Name = 'Aluminium';
antennaObject.Conductor.Conductivity = 1.002*1e5;
antennaObject.Conductor.Thickness = 0.01562;

tiltDegrees = quat2deg(orientation);
antennaObject.Tilt = tiltDegrees(1);
antennaObject.TiltAxis = 'Z';

% a = 0.2;
% sigma = 4 * pi * a^4 / 3 / lambda^2;
freq = 60e9;
AoAs = zeros(2, numRays);
AoDs = zeros(2, numRays);
propagationdistances = zeros(1, numRays);
for i = 1:numRays
    ray = rays{1}(i);
    AoDs(:,i) = ray.AngleOfDeparture;
    % AoAs(1,i) = AoDs(1,i) - 180;
    % AoA(2,i) = -AoDs(2,i);

    G_T = pattern(antennaObject, freq, AoDs(1,i), AoDs(2,i), 'Type', 'gain');
    % G_R = pattern(antennaObject, freq, AoAs(1,i), AoAs(2,i), 'Type', 'gain');
    propagationdistance = ray.PropagationDistance;
    propagationdistances(1, i) = propagationdistance;
    % disp([AoDs(1,i), AoDs(2,i)])
    
    if pattern_type == "no"
        rcs_pattern = reflector_pattern;
    end
    if pattern_type == "yes"
        rcs_pattern = reflector_pattern.rcs_pattern_dbsm_cleaned;
        % rcs_pattern = reflector_pattern.rcs_pattern_dbsm_cleaned_trihed;
    end

    % pattern params from rcs_simulation.m that created the pattern
    angle_resolution = 2;
    az=-180:angle_resolution:180;
    el=-90:angle_resolution:90;

    % % sanity check - plot the pattern
    % % is rea
    % phi = az;
    % theta = 90-el;
    % figure
    % patternCustom(rcs_pattern, theta, phi)

    % the ray goes from the transmitter (radar) to the receiver
    % (reflector), thus for the reflector rcs(az, ele), we need the pattern 
    % amplitude at the AoA of the receiver 
    AoA = ray.AngleOfArrival;
    sigma = interp2(az, el, transpose(rcs_pattern), AoA(1), AoA(2), 'linear');
    % antenna gain and rcs are both in log scale --> convert to lin.
    G_T = 10^(G_T/10);
    if pattern_type == "yes"
        sigma = 10^(sigma/10);
    end
    pathloss(1, i) = 10 * log10(G_T^2 * lambda^2 * sigma / (4 * pi)^3 / propagationdistance^4) + 12;
    % X = 1:181;
    % Y = 1:91;
    % sigma = interp2(Y, X, rcs_pattern, AoDs(2,i)+1, 180-abs(AoDs(1,i))+1, 'linear');
    % pathloss(1, i) = 10 * log10(G_T^2 * lambda^2 * sigma / (4 * pi)^3 / propagationdistance^4);
end

end