% Plot some conceptual drawing in thesis with Matlab

clear;
close all;
clc;



% % FMCW_signal_left
% Fs = 10000; % sampling frequency
% T = 1; % length of signa
% f0 = 10; % initial frequency
% f1 = 500; % end frequency
% t = linspace(0, T, Fs * T); % time vector
% 
% % FMCW signal
% y = chirp(t, f0, T, f1);
% 
% % decay = exp(-t * 5); % delay
% % y = y .* decay;
% 
% figure;
% plot(t, y);
% xlim([0 0.5]);
% ylim([-1.5 1.5]);
% text(0.5, -1.6, 't', 'HorizontalAlignment', 'center', 'FontSize', 20);
% text(0, 1.5, 'A', 'FontSize', 20, 'Rotation', 0, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
% set(gca, 'XTick', [], 'YTick', []);
% grid on;




% % FMCW_signal_right
% T = 1; % interval
% Fs = 1000; % sampling frequence
% t = 0:1/Fs:3*T;
% 
% f = mod(t, T) * (500/T) +100; % signal
% 
% figure;
% plot(t, f);
% % xlabel('t', 'FontSize', 20);
% % ylabel('f', 'FontSize', 20, 'Rotation', 0, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
% xlim([0 4]);
% ylim([0 700]);
% text(4, -0.5, 't', 'HorizontalAlignment', 'center', 'FontSize', 20);
% text(-0.5, 700, 'f', 'FontSize', 20, 'Rotation', 0, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
% set(gca, 'XTick', [], 'YTick', []);
% grid on;





% % IF_signal_left
% t = 0:0.01:7;
% f_tx = 2*t;
% t1 = 3:0.01:10;
% t2 = 4:0.01:11;
% t3 = 5:0.01:12;
% 
% delay1 = -3;
% delay2 = -4;
% delay3 = -5;
% 
% f_rx1 = 2*(t1 + delay1); 
% f_rx2 = 2*(t2 + delay2); 
% f_rx3 = 2*(t3 + delay3); 
% 
% tau = 3;
% Tc = 7;
% 
% figure;
% hold on;
% plot(t, f_tx, 'k', 'LineWidth', 2);
% plot(t1, f_rx1, 'r', 'LineWidth', 2);
% plot(t2, f_rx2, 'b', 'LineWidth', 2);
% plot(t3, f_rx3, 'g', 'LineWidth', 2);
% 
% plot([tau tau], [0 2*tau], 'k--');
% plot([0 tau], [2*tau 2*tau], 'k--');
% plot([Tc Tc], [0 2*Tc], 'k--');
% plot([0 Tc], [2*Tc 2*Tc], 'k--');
% 
% text(tau, -0.5, '$\tau$', 'HorizontalAlignment', 'center', 'Rotation', 0, 'Interpreter', 'latex', 'FontSize', 20);
% text(Tc, -0.8, 'T_c', 'HorizontalAlignment', 'center', 'FontSize', 20);
% text(-0.5, 2*tau-1, 'S\tau', 'FontSize', 20, 'Rotation', 0, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
% text(-0.5, 2*Tc, 'B', 'FontSize', 20, 'Rotation', 0, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
% text(15, -0.8, 't', 'HorizontalAlignment', 'center', 'FontSize', 20);
% text(-0.5, 20, 'f', 'FontSize', 20, 'Rotation', 0, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
% 
% xlim([0 15]);
% ylim([0 20]);
% 
% legend('TX', 'Receive signal 1', 'Receive signal 2', 'Receive signal 3');
% set(gca, 'XTick', [], 'YTick', []);
% 
% hold off;





% % IF_signal_right
% f1 = 2;
% f2 = 3;
% f3 = 4;
% 
% start_time = 3;
% end_time = 8;
% 
% figure;
% hold on;
% 
% plot([start_time end_time], [f1 f1], 'r', 'LineWidth', 2);
% plot([start_time end_time], [f2 f2], 'b', 'LineWidth', 2);
% plot([start_time end_time], [f3 f3], 'g', 'LineWidth', 2);
% 
% plot([start_time start_time], [0 10], 'k--');
% plot([end_time end_time], [0 10], 'k--');
% plot([0 start_time], [f1 f1], 'k--');
% 
% text(start_time, -0.5, '$\tau$', 'HorizontalAlignment', 'center', 'Rotation', 0, 'Interpreter', 'latex', 'FontSize', 20);
% text(-0.3, f1, 'S\tau', 'FontSize', 20, 'Rotation', 0, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
% text(10, -0.5, 't', 'HorizontalAlignment', 'center', 'FontSize', 20);
% text(-0.5, 8, 'f', 'FontSize', 20, 'Rotation', 0, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
% 
% xlim([0 10]);
% ylim([0 8]);
% 
% legend('IF signal 1', 'IF signal 2', 'IF signal 3');
% set(gca, 'XTick', [], 'YTick', []);
% 
% hold off;



% % range_resolution_21
% t = 0:0.01:3;
% 
% A = 1;
% f1 = 4;
% f2 = 4.07;
% phi = pi/20;
% 
% signal1 = A * sin(f1 * t);
% signal2 = A * sin(f2 * t + phi);
% 
% figure;
% hold on;
% 
% plot(t, signal1, 'r', 'LineWidth', 2);
% plot(t, signal2, 'b', 'LineWidth', 2);
% 
% plot([0 0], [-1.5 1.5], 'k--');
% plot([3 3], [-1.5 1.5], 'k--');
% 
% xlim([-2 8]);
% ylim([-1.5 1.5]);
% text(8, -1.5, 't', 'HorizontalAlignment', 'center', 'FontSize', 20);
% text(-2, 1.4, 'A', 'FontSize', 20, 'Rotation', 0, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
% 
% legend('IF signal 1', 'IF signal 2');
% set(gca, 'XTick', [], 'YTick', []);
% 
% hold off;






% % range_resolution_22
% t = 0:0.01:6;
% 
% A = 1;
% f1 = 4;
% f2 = 4.09;
% phi = pi/20;
% 
% signal1 = A * sin(f1 * t);
% signal2 = A * sin(f2 * t + phi);
% 
% figure;
% hold on;
% 
% plot(t, signal1, 'r', 'LineWidth', 2);
% plot(t, signal2, 'b', 'LineWidth', 2);
% 
% plot([0 0], [-1.5 1.5], 'k--');
% plot([6 6], [-1.5 1.5], 'k--');
% 
% xlim([-2 8]);
% ylim([-1.5 1.5]);
% text(8, -1.5, 't', 'HorizontalAlignment', 'center', 'FontSize', 20);
% text(-2, 1.4, 'A', 'FontSize', 20, 'Rotation', 0, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
% 
% legend('IF signal 1', 'IF signal 2');
% set(gca, 'XTick', [], 'YTick', []);
% 
% hold off;










% % range_resolution_11
% t = -2:0.01:3;
% f_tx = t;
% t1 = 0:0.01:5;
% t2 = 1:0.01:6;
% t3 = 2:0.01:7;
% 
% delay1 = -2;
% delay2 = -3;
% delay3 = -4;
% 
% f_rx1 = t1 + delay1; 
% f_rx2 = t2 + delay2; 
% f_rx3 = t3 + delay3; 
% 
% figure;
% hold on;
% plot(t, f_tx, 'k', 'LineWidth', 2);
% plot(t1, f_rx1, 'r', 'LineWidth', 2);
% plot(t2, f_rx2, 'b', 'LineWidth', 2);
% 
% plot([-2 3], [3 3], 'k--');
% plot([0 0], [-2 3], 'k--');
% plot([3 3], [-2 3], 'k--');
% 
% text(-2.1, 2.7, 'B', 'FontSize', 20, 'Rotation', 0, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
% text(7.5, -2.3, 't', 'HorizontalAlignment', 'center', 'FontSize', 20);
% text(-2.1, 7.7, 'f', 'FontSize', 20, 'Rotation', 0, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
% 
% xlim([-2 8]);
% ylim([-2 8]);
% 
% legend('TX chirp', 'IF signal 1', 'IF signal 2');
% set(gca, 'XTick', [], 'YTick', []);
% 
% hold off;





% % range_resolution_12
% t = -2:0.01:6;
% f_tx = t;
% t1 = 0:0.01:8;
% t2 = 1:0.01:9;
% t3 = 2:0.01:10;
% 
% delay1 = -2;
% delay2 = -3;
% delay3 = -4;
% 
% f_rx1 = t1 + delay1; 
% f_rx2 = t2 + delay2; 
% f_rx3 = t3 + delay3; 
% 
% figure;
% hold on;
% plot(t, f_tx, 'k', 'LineWidth', 2);
% plot(t1, f_rx1, 'r', 'LineWidth', 2);
% plot(t2, f_rx2, 'b', 'LineWidth', 2);
% 
% plot([-2 6], [6 6], 'k--');
% plot([0 0], [-2 6], 'k--');
% plot([6 6], [-2 6], 'k--');
% 
% text(-2.1, 5.7, '2B', 'FontSize', 20, 'Rotation', 0, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
% text(7.5, -2.3, 't', 'HorizontalAlignment', 'center', 'FontSize', 20);
% text(-2.1, 7.7, 'f', 'FontSize', 20, 'Rotation', 0, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
% 
% xlim([-2 8]);
% ylim([-2 8]);
% 
% legend('TX chirp', 'IF signal 1', 'IF signal 2');
% set(gca, 'XTick', [], 'YTick', []);
% 
% hold off;






% % range_resolution_31
% f = linspace(-2000, 2000, 1000);
% y = exp(-0.00001*(f.^2));
% 
% jitter = 0.01 * randn(size(f));
% y_jitter = y + jitter;
% 
% figure;
% plot(f, y_jitter, 'k');
% 
% xlim([-2000 2000]);
% ylim([0 1.1]);
% text(2000, -0.05, 'f', 'HorizontalAlignment', 'center', 'FontSize', 20);
% text(-2000.08, 1.05, 'A', 'FontSize', 20, 'Rotation', 0, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
% 
% set(gca, 'XTick', [], 'YTick', []);
% grid on;







% % range_resolution_32
% f = linspace(-2000, 2000, 1000);
% y1 = exp(-0.00001*((f-500).^2));
% y2 = exp(-0.00001*((f+500).^2));
% y = y1 + y2;
% 
% jitter = 0.05 * randn(size(f));
% y_jitter = y + jitter;
% 
% figure;
% plot(f, y_jitter, 'k');
% 
% xlim([-2500 2500]);
% ylim([-0.2 1.2]);
% 
% text(2500, -0.25, 'f', 'HorizontalAlignment', 'center', 'FontSize', 20);
% text(-2505, 1.15, 'A', 'FontSize', 20, 'Rotation', 0, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
% 
% set(gca, 'XTick', [], 'YTick', []);
% 
% grid on;

