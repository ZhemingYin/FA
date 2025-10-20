% Calculate the rcs value dependence on the angle

function [rcs] = rcs_trihedral(az, ele)
    % Eq. 2&3 from: Reflectors for SAR Performance Testing – second edition

    assert((0<az)&(az<90), "azimuth has to be 0<az<90");
    assert((0<ele)&(ele<90), "elevation has to be 0<ele<90");

    % shift to fct. arguments later
    lamda = .005; %wavelength
    a = .2; % size

    c1 = sind(ele);
    c2 = cosd(ele)*sind(az);
    c3 = cosd(ele)*cosd(az);

    c = [c1 c2 c3];
    c = sort(c);

    c1 = c(1);
    c2 = c(2);
    c3 = c(3);

    const = 4*pi*power(a, 4)/power(lamda, 2);
    
    if c1 + c2 < c3
        rcs = const * power((4*c1*c2/(c1+c2+c3)), 2);
    else
        rcs = const * power((c1+c2+c3-2/(c1+c2+c3)),2);
    end

end