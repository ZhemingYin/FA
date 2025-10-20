% Using the baseband signal to plot the range-doppler map after applying the 2D FFT.

function [range_doppler_voltage, range_doppler_power] = range_doppler_map(X_sum, delta_r, delta_v, N_p, N_s, R, idx)

% calculate range-doppler spectrum
range_doppler = fft2(X_sum.');
range_doppler_voltage = fftshift(range_doppler,1);
% convert voltage to power spectrum
range_doppler_power = abs(range_doppler_voltage).^2/R;

% plot range-doppler_voltage
f1 = figure(1);
set(f1, 'NumberTitle', 'off', 'Name', 'Range-Doppler(V)');
figure(f1)
surf(0:delta_r:(N_s-1)*delta_r, -N_p/2*delta_v:delta_v:(N_p/2-1)*...
    delta_v, abs(range_doppler_voltage));
xlabel('Range [m]')
ylabel('Velocity [m/s]')
% save_path = "/Users/yinzheming/Downloads/FA/gif/rdmV_empty_" + compose('%02d', idx) + ".png";
% saveas(f1, save_path);

% plot range-doppler amplitude. this is normally proportional to signal power;
% CFAR detection is also done based on signal power.
f5 = figure(5);
set(f5, 'NumberTitle', 'off', 'Name', 'Range-Doppler (W)');
figure(f5)
surf(0:delta_r:(N_s-1)*delta_r, -N_p/2*delta_v:delta_v:(N_p/2-1)*...
    delta_v, range_doppler_power);
xlabel('Range [m]')
ylabel('Velocity [m/s]')
save_path = "/Users/yinzheming/Downloads/FA/new_gif/" + compose('%02d', idx) + "r.png";
saveas(f5, save_path);

%  plot in dBW
f6 = figure(6);
set(f6, 'NumberTitle', 'off', 'Name', 'Range-Doppler (dBW)')
figure(f6)
surf(0:delta_r:(N_s-1)*delta_r, -N_p/2*delta_v:delta_v:(N_p/2-1)*...
    delta_v, 10*log10(range_doppler_power));
xlabel('Range [m]')
ylabel('Velocity [m/s]')

%  plot in dBm
f7 = figure(7);
set(f7, 'NumberTitle', 'off', 'Name', 'Range-Doppler (dBm)')
figure(f7)
surf(0:delta_r:(N_s-1)*delta_r, -N_p/2*delta_v:delta_v:(N_p/2-1)*...
    delta_v, 10*log10(range_doppler_power)+30);
xlabel('Range [m]')
ylabel('Velocity [m/s]')

end