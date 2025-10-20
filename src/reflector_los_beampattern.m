% Find the line-of-sight rays from reflectors in the case of microstrip
% antenna.
% 
% The tricky method is that we set the receivers directly at the positions
% of reflectors


function rays_preprocessed = reflector_los_beampattern(model, pos_tx, f, P_T, orientation)

% rx_positions = [[0.5;-0.7;3.5], [-9.3;-0.7;3.5], [-9.3;-9.3;3.5], [0.5;-9.3;3.5], [9.3;-9.3;3.5], [9.3;-0.7;3.5], [9.3;9.3;3.5], [0.7;9.3;3.5]];
% rx_positions = [[0.5;-0.7;3.5], [-9.3;-0.7;3.5], [-4.5;-5;3.5], [-9.3;-9.3;3.5], [0.5;-9.3;3.5], [9.3;-9.3;3.5], [5;-5;3.5], [9.3;-0.7;3.5], [5;0;3.5], [5;5;3.5], [9.3;9.3;3.5], [0.7;9.3;3.5]];
rx_positions = [[-9.3;-0.7;3.5], [-9.3;-9.3;3.5], [9.3;-9.3;3.5], [9.3;9.3;3.5], [0.7;9.3;3.5]];
% rx_positions = [0.2;-9.9;7.8];

% x_list = [7.3138106 ,  9.03508063,  5.83701912,  4.93176183, -2.21736428, -2.44876864, -5.53495104,  4.56641794,  3.45747366,  2.81835404, 7.82994499, -5.10603369, -7.28394453, 3.30009743, 9.18484014, 4.75595799, -3.99104465, -5.38595545, -2.88609189, 3.713262];
% y_list = [-9.05797146, -8.07198035,  3.81726266, -4.70752155, -4.96531434, -6.33330677, -7.57749486,  8.78524558,  3.72879222,  8.57228823, 3.78739586, -4.60929488, -6.40630977, 9.27788184, -9.5, 0.37912808, -1.22402734, -6.00918221, -3.18444677, -2.67578365];
% z_list = [3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5];
% rx_positions = [x_list; y_list; z_list];

viewer = siteviewer(SceneModel=model);
viewer.Materials;

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
% antennaObject.TiltAxis = [pos_tx(1) pos_tx(2) pos_tx(3)];

tx = txsite("cartesian", ...
    "Antenna", antennaObject, ...
    "AntennaPosition", pos_tx, ...
    'TransmitterFrequency', f, ...
    'TransmitterPower', P_T);

rxs = rxsite("cartesian", ...
    "Antenna", antennaObject, ...
    "AntennaPosition",rx_positions);

show(tx,ShowAntennaHeight=false);
show(rxs,ShowAntennaHeight=false);

% vis = los(tx,rxs);

pm = propagationModel("raytracing", ...
    CoordinateSystem="cartesian", ...
    AngularSeparation=.5, ...
    MaxNumReflections=0, ...
    SurfaceMaterial='concrete', ...
    MaxAbsolutePathLoss=150,...
    MaxRelativePathLoss=Inf, ...
    MaxNumDiffractions=0, ...
    Method='sbr');
rays = raytrace(tx,rxs,pm);
rays_preprocessed = [];
i = 1;

for idx = 1:length(rays)
    if ~isempty(rays{idx})
        plot(rays{idx});
        rays_preprocessed{1}(i) = rays{idx};
        i = i + 1;
    end
end

% array_1 = [pos_tx(1); pos_tx(2); pos_tx(3)];
% array_2 = [pos_tx(1) + 10*cosd(tiltDegrees(1)); pos_tx(2)+10*sind(tiltDegrees(1)); pos_tx(3)];
% plot(array_1, array_2, '-')

% hold on
% scatter3(pos_tx(1), pos_tx(2), pos_tx(3), 'filled', 'r');
% scatter3(pos_tx(1) + 10*cosd(tiltDegrees(1)), pos_tx(2)+10*sind(tiltDegrees(1)), pos_tx(3), 'filled', 'r');
% plot3([pos_tx(1), pos_tx(1) + 10*cosd(tiltDegrees(1))], [pos_tx(2), pos_tx(2)+10*sin(tiltDegrees(1))], [pos_tx(3), pos_tx(3)], 'r', 'LineWidth', 2);
% hold off


end