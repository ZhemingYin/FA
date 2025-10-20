% Check the availability of rcs function in our case

close('all')
% %% Get rcs tutorial running in our setting
% % from Matlab rcs documentation: https://de.mathworks.com/help/antenna/ref/cavity.rcs.html
% % go to Examaples - RCS of a Tetrahedron Platform
% p = platform;
% p.FileName = "tetrahedra.stl"; 
% p.Units = "m";
% figure
% show(p)
% 
% figure
% mesh(p, MaxEdgeLength=0.1)
% 
% az = 0:1:360;
% el = 0;
% figure
% rcs(p,700e6,az,el)

% % the same but scaled to our setting:
% % the frequency above is 700e6 Hz, we have 60e9Hz ~= 70e9 Hz
% % 70e9 = 700e8, 700e6 = 7e8 --> factor 100
% % Does it still look like a realistic pattern? first plausibility check
% p = platform;
% p.FileName = "tetrahedra.stl"; 
% p.Units = "cm"; % m --> cm: 100, can also be done by scaling size in Blender
% figure
% show(p)
% 
% 
% mesh(p, MaxEdgeLength=0.001) % EdgeLenght = 1mm; wavelength lambda = 5 mm @ 60 GHz
% 
% az = 0:1:360;
% el = 0;
% figure 
% % rcs(p,60e9,az,el) % new frequency - our 60 GHz carrier frequency
% rcs(p,60e9,az,el,Solver="MOM", EnableGPU=0) % use MoM as Solver --> this seems to work

%% after that simulate trihedral and compare simulated pattern ...
% with analytical formula rcs pattern as second, better plausibility check.

% It might also make sense to test the effect of changing the rcs simulation 
% parameters on the rcs pattern like MaxEdgeLenght but this only for the 1D plot (el=0)
% (too expensive for all elevation angles)
p = platform;
p.Units = "m";

% cr.stl is attached with the code.
% it's outer sidelenghts are .05m, i.e. a=0.05/sqrt(2)m with the paper definition 
% (Fig. 2a) of the corner reflector size (same as you also use for max rcs)
p.FileName = "cr.stl";
mesh(p, MaxEdgeLength=0.0007)
az=1:1:360;
ele=0;%10:10:360;
rcs(p, 60e9, az, ele, Solver="MOM", EnableGPU=0);

% Since it's probably too expensive to simulate a 20 cm corner reflector, 
% we'll have to linearly scale the rcs pattern of the smaller reflector. 
% The scaling coeff. could be determined by the max_rcs_20cm / max_rcs_5cm or similar.

%% then plug-in octahedral in simulation with correct orientation. 
% this result can then be used as rcs(az, ele) in the path loss calculation of the 
% octahedral corner reflectors.

