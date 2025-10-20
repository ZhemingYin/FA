% Calculate the relative range between the radar and reflectors.

function distances = range_calculation(pos_tx)

distances = [];

rx_positions = [[-9.299;-0.701;3.499], [-9.299;-9.299;3.499], [9.299;-9.299;3.499], [9.299;9.299;3.499], [0.701;9.299;3.499]];

[row, col] = size(rx_positions);
for i = 1:col
    dis = norm(pos_tx - rx_positions(:, i));
    distances(i) = dis;
end