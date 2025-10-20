% Simulate the RCS pattern of reflector in 3D

close('all')

% definition of object to simulate and triangular mesh
p = platform;
% p.FileName = "/home/m145/Documents/iss/Code/Matlab/plate.stl";
p.FileName = "cr.stl";
p.Units = "m";
figure
show(p)

figure
mesh(p, MaxEdgeLength=0.002)

% rcs simulation; we'll actually need all angles in azimuth (360°) and 
% the bottom side of the reflector (180°), i.e. what's facing towards the
% radar
% however, there are symmetries that could (but don't have to) be used to cut 
% the processing time and maybe we don't need a 1° angular resolution like here
rcs_pattern_dbsm = zeros(360, 360);
for az=1:1:360
    for ele=1:1:360
        % disp([az, ele]) % loop counter
        rcs_dbsm = rcs(p, 60e9, az, ele, Solver="MOM", EnableGPU=0);
        rcs_pattern_dbsm(az, ele) = rcs_dbsm;
    end
end

% plot
az=1:1:360;
ele=1:1:360;
imagesc(az,ele,rcs_pattern_dbsm)
title('Radar cross section (dBsm)')
xlabel('Azimuth (deg)')
ylabel('Elevation (deg)')
colorbar

figure
plot(rcs_pattern_dbsm(:, 35))