function new_pattern = isotropic_pattern_generator(a, lambda)
    pattern_isotropic = [];
    for i = 1:181
        for j = 1:91
            pattern_isotropic(i, j) = 4 * pi * a^4 / 3 / lambda^2;
        end
    end
    theta = -180:2:180;
    phi = -90:2:90;
    new_pattern = zeros(length(theta), length(phi));
    new_pattern = pattern_isotropic;
end
