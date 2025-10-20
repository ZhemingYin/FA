% Plot the RCS pattern of octahedral reflector in the thesis

close('all')

pattern = load('rcs_pattern_dbsm_cleaned.mat');
rcs_pattern_dbsm = pattern.rcs_pattern_dbsm_cleaned;

% plot
angle_resolution = 2;
az=-180:angle_resolution:180;
el=-90:angle_resolution:90;

% 2D plot (az, ele)
imagesc(az, el, rcs_pattern_dbsm, [-50 40])
title('Radar cross section (dBsm)')
ylabel('Azimuth (deg)')
xlabel('Elevation (deg)')
colorbar

% see antenna toolbox "spherical coordinate system definition" for phi and theta
% https://de.mathworks.com/help/antenna/gs/antenna-coordinate-system.html
phi = az;
theta = 90 - el;

% 3D plot (az, ele, amplitude) = pattern plot from the antenna toolbox
figure
patternCustom(rcs_pattern_dbsm, theta, phi)