% function [rcs_value] = rcs_analytical(az_simulated, ele_simulated)
rcs_pattern = zeros(89, 89);
rcs_pattern_dbsm = zeros(89, 89);

for az=1:1:89
    for ele=1:1:89
        rcs_lin = rcs_trihedral(az, ele);
        rcs_dbsm = 10*log10(rcs_lin);
        rcs_pattern(az, ele) = rcs_lin;
        rcs_pattern_dbsm(az, ele) = rcs_dbsm;
    end
end

az=1:1:89;
ele=1:1:89;

figure
imagesc(az,ele,rcs_pattern_dbsm)
title('Radar cross section (dBsm)')
xlabel('Elevation (deg)')
ylabel('Azimuth (deg)')
colorbar

% the cut at 0° (or 45°, depending on coordinate system def. of elevation)
% this is what you see (without the two "horns") if you google 
% trihedral corner reflector rcs pattern
% We can check the rcs simulation agains this. If we simulate a smaller 
% reflector we have to upscale the rcs to fit this curve (e.g. by using
% rcs_pattern = rcs_pattern_sim * max(rcs_patter_analytical)/max(rcs_pattern_sim)

figure
plot(rcs_pattern_dbsm(:, 35))

%     rows = 1:89;
%     cols = 1:89;
% 
%     rcs_value = interp2(rows, cols, rcs_pattern_dbsm, az_simulated, ele_simulated, 'linear');
% end