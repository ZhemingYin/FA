% Convert the quaternion to the angle with degree.

function tiltDegrees = quat2deg(orientation)
    w = orientation(1);
    x = orientation(2);
    y = orientation(3);
    z = orientation(4);
    q = [w, x, y, z];
    eulerAngles = quat2eul(q, 'ZYX');
    tiltDegrees = rad2deg(eulerAngles);
end
