% Set the guard cells and reference cells in CFAR detector to detect the
% targets on the range-Doppler matrix with the amplitude in unit W.
% 
% To plot the CFAR in another units, line 57-61 and 75-77 can be chosen to
% modify

% CFAR detection
function [targets, peak_values] = cfar_detector(range_doppler, P_FA, delta_r, delta_v, N_p, index, propagationdistances, v_ks, R)
    detector = phased.CFARDetector2D('TrainingBandSize', [3, 5], ...
        'ThresholdFactor', 'Auto', 'GuardBandSize', [1,1], ...
        'ProbabilityFalseAlarm', P_FA, 'Method', 'CA', ...
        'ThresholdOutputPort', true);

    Ncol = size(range_doppler, 2);
    Nrow = size(range_doppler, 1);
    Ngc = detector.GuardBandSize(2);
    Ngr = detector.GuardBandSize(1);
    Ntc = detector.TrainingBandSize(2);
    Ntr = detector.TrainingBandSize(1);
    cutidx = [];
    colstart = Ntc + Ngc + 1;
    colend = Ncol - ( Ntc + Ngc);
    rowstart = Ntr + Ngr + 1;
    rowend = Nrow - ( Ntr + Ngr);
    for m = colstart:colend
        for n = rowstart:rowend
            cutidx = [cutidx,[n;m]];
        end
    end
    ncutcells = size(cutidx,2);

    figure(2);
    cutimage = zeros(Nrow, Ncol);
    for k = 1:ncutcells
        cutimage(cutidx(1,k),cutidx(2,k)) = 1;
    end
    imagesc(cutimage)
    axis equal

    [dets,th] = detector(abs(range_doppler),cutidx);

    peaks = find(dets);
    [peaks_row, peaks_col] = ind2sub([rowend-rowstart+1, colend-colstart+1], peaks);
    peaks_row = peaks_row + rowstart - 1;
    peaks_col = peaks_col + colstart - 1;

    range = (peaks_col-1) * delta_r;
    outRange = (range<3) | (range>20);
    idx = find(outRange);
    peaks(idx) = [];
    peaks_row(idx) = [];
    peaks_col(idx) = [];

    maxTh = max(abs(range_doppler(peaks_row, peaks_col)),[],"all");
    minTh = min(abs(range_doppler(peaks_row, peaks_col)),[],"all");
    % maxTh = sqrt(maxTh * R);
    % minTh = sqrt(minTh * R);
    % maxTh = 10*log10(maxTh);
    % minTh = 10*log10(minTh);
    % maxTh = 10*log10(maxTh)+30;
    % minTh = 10*log10(minTh)+30;

    x_pos = propagationdistances;
    y_pos = v_ks;
    % x_pos = propagationdistances / delta_r + 1;
    % y_pos = v_ks / delta_v + Nrow / 2 + 1;
    % disp(x_pos)
    % disp(y_pos)

    f3 = figure(3);
    figure(f3)
    xtgt = zeros(Nrow, Ncol);
    for i = 1:size(peaks)
        rd = abs(range_doppler(peaks_row(i), peaks_col(i)));
        % rd = sqrt(rd * R);
        % rd = 10*log10(rd);
        % rd = 10*log10(rd)+30;
        xtgt(peaks_row(i), peaks_col(i)) = rd / maxTh;
        % xtgt(peaks_row(i), peaks_col(i)) = (rd - minTh) / (maxTh - minTh);
    end
    x_axis = 0:delta_r:(Ncol-1)*delta_r;
    y_axis = (-Nrow/2)*delta_v:delta_v:(Nrow/2-1)*delta_v;
    img = imagesc(x_axis, y_axis, xtgt);
    for j = 1:length(x_pos)
        hold on
        if x_pos(j) < 19
            plot(x_pos(j),y_pos(j),'marker','x','MarkerSize',20,'Color','red', 'LineWidth', 2)
        end
    end
    xlabel('Range (m)');
    ylabel('Velocity (m/s)');
    colorbar;
    title('CFAR Detection');
    save_path = "/Users/yinzheming/Downloads/FA/new_gif/" + compose('%02d', index) + "c.png";
    saveas(f3, save_path);

    % I = imread(save_path);
    % for j = 1:length(x_pos)
    %     pos = [x_pos(:), y_pos(:)];
    %     RGB = insertMarker(I,pos,"x",MarkerColor="red",Size=10);
    % end
    % imshow(RGB)

    targets = horzcat((peaks_col-1).*delta_r, (peaks_row-(N_p/2+1))*delta_v);

    peak_values = abs(range_doppler(sub2ind(size(range_doppler),...
        peaks_row, peaks_col)));

end