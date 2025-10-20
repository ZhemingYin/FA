% Plot the 2D radiation pattern in both E- and H-plane of antenna to check
% the directional shape

clear;
close all;
clc;
%% Antenna Properties 
antennaObject = design(patchMicrostrip, 60*1e9);
antennaObject.Length = 0.0019908;
antennaObject.Width = 0.00093211;
antennaObject.Height = 4.8995e-05;
antennaObject.Substrate.Thickness = 4.8995e-05;
antennaObject.GroundPlaneLength = 0.0023848;
antennaObject.GroundPlaneWidth = 0.0010152;
antennaObject.PatchCenterOffset = [0.00014792, -6.9634e-08];
antennaObject.FeedOffset = [-0.00019916, -0.00014773];
antennaObject.Conductor.Name = 'Aluminium';
antennaObject.Conductor.Conductivity = 8.8902*1e9;
antennaObject.Conductor.Thickness = 0.000762;

% % Show antenna
figure;
show(antennaObject) 

% %% Antenna Analysis 
% % 3D pattern
figure
pattern(antennaObject, 60e9)
% 
% % E-plane
% figure
% patternElevation(antennaObject, 60e9, 0, 'Elevation', 0:1:180)
% legend('E-plane')
% 
% % H-plane
% figure
% patternElevation(antennaObject, 60e9, 90, 'Elevation', 0:1:180)
% legend('H-plane')

% both in one plot ... see below and adapt to own needs
% https://de.mathworks.com/matlabcentral/answers/373596-how-to-change-the-properties-of-patternelevation-or-patternazimuth-polarpattern-plots
figure
patternElevation(antennaObject, 60e9, [90, 0], 'Elevation', 0:1:180)
pAx = polarpattern('gco');
pAx.LegendLabels{1,1} = 'E-plane';
pAx.LegendLabels{1,2} = 'H-plane';
pAx.TitleTop = 'Antenna Gain (dBi)';
pAx.AngleLim = [180 360]; % this actually goes from 0 to 180 - idk why
pAx.MagnitudeTick = [-25 -20 -15 -10 -5 0 5];
pAx.MagnitudeLim = [-25 5];
pAx.Peaks = 0;