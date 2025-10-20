% Find the line-of-sight rays from reflectors in the case of isotropic
% antenna.
% 
% The tricky method is that we set the receivers directly at the positions
% of reflectors



function rays_preprocessed = reflector_los_isotropic(model, pos_tx, f, P_T)

rx_positions = [[-9.3;-0.7;3.5], [-9.3;-9.3;3.5], [9.3;-9.3;3.5], [9.3;9.3;3.5], [0.7;9.3;3.5]];
% rx_positions = [[-9.4;-0.6;3.5], [-9.4;-9.4;3.5], [9.4;-9.4;3.5], [9.4;9.4;3.5], [0.6;9.4;3.5]];
% rx_positions = [0.2;-9.9;7.8];

% x_list = [7.3138106 ,  9.03508063,  5.83701912,  4.93176183, -2.21736428, -2.44876864, -5.53495104,  4.56641794,  3.45747366,  2.81835404, 7.82994499, -5.10603369, -7.28394453, 3.30009743, 9.18484014, 4.75595799, -3.99104465, -5.38595545, -2.88609189, 3.713262];
% y_list = [-9.05797146, -8.07198035,  3.81726266, -4.70752155, -4.96531434, -6.33330677, -7.57749486,  8.78524558,  3.72879222,  8.57228823, 3.78739586, -4.60929488, -6.40630977, 9.27788184, -9.5, 0.37912808, -1.22402734, -6.00918221, -3.18444677, -2.67578365];
% z_list = [3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5];
% rx_positions = [x_list; y_list; z_list];

viewer = siteviewer(SceneModel=model);
viewer.Materials;
tx = txsite("cartesian", ...
    "Antenna", 'isotropic', ...
    "AntennaPosition", pos_tx, ...
    'TransmitterFrequency', f, ...
    'TransmitterPower', P_T);

rxs = rxsite("cartesian", ...
    "Antenna", 'isotropic', ...
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
    MaxNumDiffractions=0,Method='sbr');
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

end