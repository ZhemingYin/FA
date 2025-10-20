% Input the blender model, then ray trace in model with the patch antenna
% array and radiation pattern.

function rays = raytracing_beampattern(model, pos_tx, f, P_T, pos_rx, orientation)

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
% Show
figure;
show(antennaObject) 

%% Antenna Analysis 
% Define plot frequency 
plotFrequency = 60*1e9;
% % Define frequency range 
% freqRange = (54:0.6:66)*1e9;
% % Reference Impedance 
% refImpedance = 50;
% pattern
f8=figure(8);
figure(f8)
pattern(antennaObject, plotFrequency)
% elevation
f9=figure(9);
figure(f9)
patternElevation(antennaObject, plotFrequency,0,'Elevation',0:5:360)

tiltDegrees = quat2deg(orientation);
antennaObject.Tilt = tiltDegrees(1);
antennaObject.TiltAxis = 'Z';
% elevation
f10=figure(10);
figure(f10)
patternElevation(antennaObject, plotFrequency,0,'Elevation',0:5:360)

tx = txsite("cartesian", ...
    "Antenna", antennaObject, ...
    "AntennaPosition", pos_tx, ...
    'TransmitterFrequency', f, ...
    'TransmitterPower', P_T);

rx = rxsite("cartesian", ...
    "Antenna", antennaObject, ...
    "AntennaPosition",pos_rx);

show(tx,ShowAntennaHeight=false);
show(rx,ShowAntennaHeight=false);

pm = propagationModel("raytracing", ...
    CoordinateSystem="cartesian", ...
    AngularSeparation=.5, ...
    MaxNumReflections=4, ...
    SurfaceMaterial='concrete', ...
    MaxAbsolutePathLoss=150,...
    MaxRelativePathLoss=Inf,...
    MaxNumDiffractions=1,Method='sbr');
rays = raytrace(tx,rx,pm);
plot(rays{1});


end