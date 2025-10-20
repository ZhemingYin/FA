% Design a random trajectory with a given starting position and get the
% position and velocity in particular time.

function [sampledPositions, sampledOrientations, sampledVelocities, position, orientation, velocity] = trajectory_generation(t)
    % start_pos = pos_tx;
    % pos_1 = [pos_tx(1)+1; pos_tx(2)-1; pos_tx(3)];
    % pos_2 = [pos_1(1)+1; pos_1(2)+2; pos_1(3)];

    % start_pos = [2; -2; 0.5];
    % pos_1 = [-4; -4; 0.5];
    % pos_2 = [-8; -2; 0.5];
    % pos_3 = [-6; -4; 0.5];
    % pos_4 = [-8; -8; 0.5];
    % pos_5 = [-1; -5; 0.5];
    % pos_6 = [8; -8; 0.5];
    % pos_7 = [5; 1; 0.5];
    % pos_8 = [8; 8; 0.5];
    % pos_9 = [5; 5; 0.5];
    % pos_10 = [2; 8; 0.5];
    % pos_11 = [5; 3; 0.5];
    % end_pos = [2; -2; 0.5];

    start_pos = [1; -1; 0.5];
    pos_1 = [0; -4; 0.5];
    pos_2 = [-5; -5; 0.5];
    pos_3 = [-7; -5; 0.5];
    pos_4 = [-7; -7; 0.5];
    pos_5 = [-1; -7; 0.5];
    pos_6 = [2; -5; 0.5];
    pos_7 = [5; -3; 0.5];
    pos_8 = [6; -3; 0.5];
    pos_9 = [6; 2; 0.5];
    pos_10 = [3; 5; 0.5];
    pos_11 = [1; 1; 0.5];
    end_pos = [1; -1; 0.5];
    
    time_points = [0; 4; 8; 14; 18; 25; 30; 33; 37; 43; 46; 50; 55];
    % time_points = [0; 3; 5; 8; 10; 13; 16; 18; 20; 21; 23; 26; 29];
    
    waypoints = [start_pos, pos_1, pos_2, pos_3, pos_4, pos_5, pos_6, pos_7, pos_8, pos_9, pos_10, pos_11, end_pos];
    trajectory = waypointTrajectory(waypoints', 'TimeOfArrival', time_points);

    numSamples = trajectory.SampleRate * (time_points(end) - time_points(1));
    sampledPositions = zeros(numSamples, 3);
    sampledVelocities = zeros(numSamples, 3);
    sampledOrientations = zeros(numSamples, 4);
    
    for i = 1:numSamples
        % [position, orientation, velocity, acceleration] = trajectory();
        [position, orientation, velocity, ~] = trajectory();
        % if i == 1
        %     disp(compact(orientation))
        % end
        sampledPositions(i, :) = position;
        sampledVelocities(i, :) = velocity;
        sampledOrientations(i, :) = compact(orientation);
    end

    figure(4)
    plot3(sampledPositions(:,1), sampledPositions(:,2), sampledPositions(:,3), '-');
    hold on;
    plot3(waypoints(1,:), waypoints(2,:), waypoints(3,:), 'o', ...
        'MarkerSize', 10, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'r');
    
    grid on;
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    title('3D Trajectory');
    legend('Sampled Trajectory', 'Waypoints');
    
    time = floor(t/time_points(end) * numSamples);
    queryTimes = linspace(1, numSamples, numSamples);

    xPos = interp1(queryTimes, sampledPositions(:,1), time, 'linear');
    yPos = interp1(queryTimes, sampledPositions(:,2), time, 'linear');
    zPos = interp1(queryTimes, sampledPositions(:,3), time, 'linear');

    xVel = interp1(queryTimes, sampledVelocities(:,1), time, 'linear');
    yVel = interp1(queryTimes, sampledVelocities(:,2), time, 'linear');
    zVel = interp1(queryTimes, sampledVelocities(:,3), time, 'linear');

    wOrien = interp1(queryTimes, sampledOrientations(:,1), time, 'linear');
    xOrien = interp1(queryTimes, sampledOrientations(:,2), time, 'linear');
    yOrien = interp1(queryTimes, sampledOrientations(:,3), time, 'linear');
    zOrien = interp1(queryTimes, sampledOrientations(:,4), time, 'linear');

    position = [xPos; yPos; zPos];
    velocity = [xVel; yVel; zVel];
    orientation = [wOrien, xOrien, yOrien, zOrien];
end